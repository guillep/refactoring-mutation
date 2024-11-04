Class {
	#name : 'RenameArgOrTempInvalidInputMutationOperator',
	#superclass : 'RenameArgumentOrTemporaryMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameArgOrTempInvalidInputMutationOperator >> applyMutation: aMutation [
	
	[ 
	aMutation refactoring
		prepareForExecution; 
		checkPreconditions ]
		on: RBRefactoringError
		do: [ :e | "Nothing since we want it to break and we continue" ].
		
	aMutation privateTransform.
	aMutation performChanges.
]
