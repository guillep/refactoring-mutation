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
	(aMutation inputFor: #name) ifNil: [ ^ nil ].
	(aMutation inputFor: #interval) ifNil: [ ^ nil ].
	refactoring := RBRenameArgumentOrTemporaryRefactoring
		  model: (RBNamespace onEnvironment: classEnvironment)
		  renameTemporaryFrom: (aMutation inputFor: #interval) 
		  to: (aMutation inputFor: #name)
		  in: aMutation data methodNode compiledMethod origin
		  selector: aMutation data methodNode selector.
	
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
