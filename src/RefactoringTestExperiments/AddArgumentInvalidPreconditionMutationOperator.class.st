Class {
	#name : 'AddArgumentInvalidPreconditionMutationOperator',
	#superclass : 'AddArgumentMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
AddArgumentInvalidPreconditionMutationOperator >> applyMutation: aMutation [
	
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
AddArgumentInvalidPreconditionMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
