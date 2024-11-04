Class {
	#name : 'RenameMethodMutationOperator',
	#superclass : 'RefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'private' }
RenameMethodMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	(self appliesToNode: aParseTree methodNode) ifFalse: [ ^ #() ].
	
	^ { aParseTree methodNode }
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> applyMutation: aMutation [

	| failing |
	aMutation refactoring prepareForExecution.
	failing := aMutation refactoring failedApplicabilityPreconditions.
	failing ifNotEmpty: [ RBRefactoringError signalFor: failing ].
	aMutation refactoring privateTransform.
	aMutation refactoring performChanges
]

{ #category : 'mutant generation' }
RenameMethodMutationOperator >> createRefactoringWith: aMutation [

	| refactoring model permutations |
	(aMutation inputFor: #methodName) ifNil: [ ^ nil ].
	(aMutation inputFor: #permutations) ifNil: [ ^ nil ].
	model := RBNamespace onEnvironment: classEnvironment.
	permutations := aMutation data selector count: [ :c | c = $: ].
	refactoring := ReRenameMethodRefactoring
		               model: model
		               renameMethod: aMutation data selector
		               in: aMutation data methodNode methodClass name
		               to: (aMutation inputFor: #methodName)
		               permutation: (aMutation inputFor: #permutations).
	^ refactoring
]

{ #category : 'printing' }
RenameMethodMutationOperator >> description [
	
	^ 'Rename a method'
]

{ #category : 'private' }
RenameMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode sourceInterval first to: aNode selector size with: 'NEW' , aNode selector
]
