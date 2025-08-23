Class {
	#name : 'AddArgumentMutationOperator',
	#superclass : 'RefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'private' }
AddArgumentMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	| selected |
	selected := aParseTree body allChildren select: [ :aNode |
		            self appliesToNode: aNode ].
	(self appliesToNode: aParseTree methodNode) ifTrue: [
		selected add: aParseTree methodNode ].

	^ selected
]

{ #category : 'mutant generation' }
AddArgumentMutationOperator >> createRefactoringWith: aMutation [

	| selector permutations |
	aMutation appliesToNode ifFalse: [ ^ nil ].
	selector := (aMutation strategy methodNameFor: aMutation) ifNil: [ ^ nil ].
	permutations := (aMutation strategy permutationsFor: aMutation) ifNil: [ ^ nil ].
	^ RBAddParameterRefactoring 
		  model: (RBNamespace onEnvironment: classEnvironment)
		  addParameterToMethod: aMutation data selector
		  in: aMutation data compiledMethod origin
		  newSelector: selector
		  permutation: permutations
		  newArgs: { RBArgumentName name: 'aFoo' value: 'nil' }.
]

{ #category : 'printing' }
AddArgumentMutationOperator >> description [
	
	^ 'Add argument to every method'
]

{ #category : 'private' }
AddArgumentMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	| sep |
	sep := aCompiledMethod selector isUnary ifTrue: [ '' ] ifFalse: [ ' ' ].
	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode selectorAndArgumentNames size with: aNode selectorAndArgumentNames , sep , 'foo: aFoo'
]
