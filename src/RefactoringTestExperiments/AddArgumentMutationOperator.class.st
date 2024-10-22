Class {
	#name : 'AddArgumentMutationOperator',
	#superclass : 'RefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
AddArgumentMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	| selected |
	selected := aParseTree body allChildren select: [ :aNode |
		            self appliesToNode: aNode ].
	(self appliesToNode: aParseTree methodNode) ifTrue: [
		selected add: aParseTree methodNode ].

	^ selected
]

{ #category : 'instance creation' }
AddArgumentMutationOperator >> appliesToNode: aNode [

	| model |
	aNode methodNode compiledMethod isExtension ifTrue: [ ^ false ].
	aNode isMethod ifFalse: [ ^ false ].
	aNode selector = #initialize ifTrue: [ ^ false ].
	(self class blackListMethodNames includes: aNode selector) ifTrue: [ ^ false ].
	model := RBNamespace onEnvironment: classEnvironment.

	^ self canRefactor: aNode in: model
]

{ #category : 'instance creation' }
AddArgumentMutationOperator >> applyMutation: aMutation [

	| refactoring |
	(aMutation inputFor: #methodName) ifNil: [ ^ nil ].
	(aMutation inputFor: #permutations) ifNil: [ ^ nil ].
	refactoring := RBAddParameterRefactoring 
		  model: (RBNamespace onEnvironment: classEnvironment)
		  addParameterToMethod: aMutation data selector
		  in: aMutation data compiledMethod origin
		  newSelector: (aMutation inputFor: #methodName)
		  permutation: (aMutation inputFor: #permutations)
		  newArgs: { RBArgumentName name: 'aFoo' value: 'nil' }.
	
	refactoring execute
]

{ #category : 'testing' }
AddArgumentMutationOperator >> canRefactor: aNode in: aModel [

	| refactoring |
	refactoring := self createRefactoringWith: aNode on: aModel.

	[
	refactoring
		prepareForExecution;
		checkPreconditions ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'refactoring' }
AddArgumentMutationOperator >> createRefactoringWith: aNode on: aModel [
	| permutations |
	permutations := (1 to: aNode arguments size) asOrderedCollection.
	permutations add: -1.
	
	^ RBAddParameterRefactoring 
		  model: aModel
		  addParameterToMethod: aNode selector
		  in: aNode compiledMethod origin
		  newSelector: aNode selector , #foo:
		  permutation: permutations
		  newArgs: { RBArgumentName name: 'aFoo' value: 'nil' }
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
