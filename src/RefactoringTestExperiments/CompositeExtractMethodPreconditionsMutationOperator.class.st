Class {
	#name : 'CompositeExtractMethodPreconditionsMutationOperator',
	#superclass : 'CompositeExtractMethodMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CompositeExtractMethodPreconditionsMutationOperator >> applyMutation: aMutation [

	[ aMutation refactoring checkApplicabilityPreconditions ]
		on: RBRefactoringError, RBRefactoringWarning
		do: [ self error ].

	aMutation refactoring privateTransform.
	aMutation refactoring performChanges
]

{ #category : 'mutant generation' }
CompositeExtractMethodPreconditionsMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
