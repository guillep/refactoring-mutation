Class {
	#name : 'RenameArgOrTempInvalidSourceMutationOperator',
	#superclass : 'RenameArgumentOrTemporaryMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameArgOrTempInvalidSourceMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := self createRefactoringWith: aMutation data on: (RBNamespace onEnvironment: classEnvironment).
	
	refactoring prepareForExecution.
	
	[ refactoring checkPreconditions ]
		on: RBRefactoringError
		do: [ :e | "Nothing since we want it to break and we continue" ].
		
	refactoring privateTransform.
	refactoring performChanges.
]

{ #category : 'testing' }
RenameArgOrTempInvalidSourceMutationOperator >> canRefactor: aNode in: aModel [

	^ (super canRefactor: aNode in: aModel) not 
]
