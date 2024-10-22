Class {
	#name : 'RenameMethodMutationOperator',
	#superclass : 'RefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameMethodMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	(self appliesToNode: aParseTree methodNode) ifFalse: [ ^ #() ].
	
	^ { aParseTree methodNode }
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> appliesToNode: aNode [

	(aNode methodNode compiledMethod origin isKindOf: TraitedMetaclass)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass class)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass)
		ifTrue: [ ^ false ].
		
	(aNode isMethod) ifFalse: [ ^ false ].
	(self class blackListMethodNames includes: aNode selector) ifTrue: [ ^ false ].

	aNode methodNode compiledMethod origin isTrait ifTrue: [ ^ false ].
	aNode sourceInterval ifEmpty: [ ^ false ].

	^ self canRefactor: aNode
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> applyMutation: aMutation [

	| refactoring failing model selector |

	(aMutation inputFor: #methodName) ifNil: [ ^ nil ].
	(aMutation inputFor: #permutations) ifNil: [ ^ nil ].
	model := RBNamespace onEnvironment: classEnvironment.
	selector := aMutation data selector.
	refactoring := ReRenameMethodRefactoring
		               model: model
		               renameMethod: selector
		               in: aMutation data methodNode methodClass name
		               to: (aMutation inputFor: #methodName)
		               permutation: (aMutation inputFor: #permutations).

	refactoring prepareForExecution.
	failing := refactoring failedApplicabilityPreconditions.
	failing ifNotEmpty: [ RBRefactoringError signal ].
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> canRefactor: aNode [

	| refactoring failing |
	refactoring := self createRefactoringFor: aNode.
	refactoring ifNil: [ ^ false ].
	
	refactoring prepareForExecution.
	failing := refactoring failedApplicabilityPreconditions
		           asOrderedCollection.
	failing addAll: refactoring failedBreakingChangePreconditions.
	^ failing isEmpty
]

{ #category : 'mutant generation' }
RenameMethodMutationOperator >> createRefactoringFor: aNode [

	| refactoring model permutations |
	model := RBNamespace onEnvironment: classEnvironment.
	permutations := aNode selector count: [ :c | c = $: ].
	refactoring := ReRenameMethodRefactoring
		               model: model
		               renameMethod: aNode selector
		               in: aNode methodNode methodClass name
		               to: 'foo' , aNode selector
		               permutation: (1 to: permutations).
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
