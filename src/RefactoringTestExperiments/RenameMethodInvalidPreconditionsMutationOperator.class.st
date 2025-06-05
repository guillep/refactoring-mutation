Class {
	#name : 'RenameMethodInvalidPreconditionsMutationOperator',
	#superclass : 'RenameMethodMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameMethodInvalidPreconditionsMutationOperator >> applyMutation: aMutation [

	[ aMutation refactoring checkApplicabilityPreconditions ]
		on: RBRefactoringError
		do: [ self error ].

	aMutation refactoring privateTransform.
	aMutation refactoring performChanges
]

{ #category : 'mutant generation' }
RenameMethodInvalidPreconditionsMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
