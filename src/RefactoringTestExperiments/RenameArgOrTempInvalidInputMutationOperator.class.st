Class {
	#name : 'RenameArgOrTempInvalidInputMutationOperator',
	#superclass : 'RenameArgumentOrTemporaryMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameArgOrTempInvalidInputMutationOperator >> applyMutation: aMutation [

	| refactoring |
	(aMutation inputFor: #name) ifNil: [ ^ nil ].
	(aMutation inputFor: #interval) ifNil: [ ^ nil ].
	refactoring := RBRenameArgumentOrTemporaryRefactoring
		  model: (RBNamespace onEnvironment: classEnvironment)
		  renameTemporaryFrom: (aMutation inputFor: #interval) 
		  to: (aMutation inputFor: #name)
		  in: aMutation data methodNode compiledMethod origin
		  selector: aMutation data methodNode selector.
	
	
	[ 
	refactoring
		prepareForExecution; 
		checkPreconditions ]
		on: RBRefactoringError
		do: [ :e | "Nothing since we want it to break and we continue" ].
		
	refactoring privateTransform.
	refactoring performChanges.
]

{ #category : 'testing' }
RenameArgOrTempInvalidInputMutationOperator >> canRefactor: aNode in: aModel [
	"Here we check if we can run this refactoring by checking preconditions.
	In these cases we know the preconditions would fail, so we run everything."
	^ true 
]
