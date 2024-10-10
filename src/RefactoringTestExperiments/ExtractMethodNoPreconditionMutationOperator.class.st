Class {
	#name : 'ExtractMethodNoPreconditionMutationOperator',
	#superclass : 'ExtractMethodMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtractMethodNoPreconditionMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := self createRefactoringWithInterval: aMutation data andMethodNode: aMutation originalMethod.

	[ refactoring 
		prepareForExecution;
		checkApplicabilityPreconditions
	]
		on: RBRefactoringError 
		do: [ :e | "We ignore the fact the exception happened and continue" ].
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
ExtractMethodNoPreconditionMutationOperator >> canRefactor: aNode [

	^ (super canRefactor: aNode) not
]

{ #category : 'private' }
ExtractMethodNoPreconditionMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
