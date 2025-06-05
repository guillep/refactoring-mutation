Class {
	#name : 'ExtractMethodNoPreconditionMutationOperator',
	#superclass : 'ExtractMethodMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtractMethodNoPreconditionMutationOperator >> applyMutation: aMutation [

	[ aMutation refactoring 
		prepareForExecution;
		checkApplicabilityPreconditions
	]
		on: RBRefactoringError , RBRefactoringWarning
		do: [ :e | "We ignore the fact the exception happened and continue" ].
	aMutation refactoring privateTransform.
	aMutation refactoring performChanges
]

{ #category : 'private' }
ExtractMethodNoPreconditionMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
