Class {
	#name : 'RenameClassWithoutPreconditionsMutationOperator',
	#superclass : 'RenameClassMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameClassWithoutPreconditionsMutationOperator >> applyMutation: aMutation [
	
	[ 
	aMutation refactoring
		prepareForExecution; 
		checkPreconditions ]
		on: RBRefactoringError, RBRefactoringWarning 
		do: [ :e | "Nothing since we want it to break and we continue" ].
		
	aMutation refactoring privateTransform.
	aMutation refactoring performChanges.
]

{ #category : 'mutant generation' }
RenameClassWithoutPreconditionsMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
