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

{ #category : 'mutant generation' }
RenameMethodMutationOperator >> createRefactoringWith: aMutation [

	| refactoring model name permutations |
	(aMutation strategy appliesToNode: aMutation data) ifFalse: [ ^ nil ].
	name := (aMutation strategy methodNameFor: aMutation ) ifNil: [ ^ nil ].
	permutations := (aMutation strategy permutationsFor: aMutation ) ifNil: [ ^ nil ].
	model := RBNamespace onEnvironment: classEnvironment.
	refactoring := ReRenameMethodRefactoring
		               model: model
		               renameMethod: aMutation data selector
		               in: aMutation data methodNode methodClass name
		               to: name
		               permutation: permutations.
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
