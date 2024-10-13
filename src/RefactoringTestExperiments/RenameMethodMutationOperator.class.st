Class {
	#name : 'RenameMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#instVars : [
		'nameStrategy'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameMethodMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	| selected |
	selected := aParseTree allChildren select: [ :aNode |
		            self appliesToNode: aNode ].

	^ selected
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> appliesToNode: aNode [

	(aNode isMethod) ifFalse: [ ^ false ].
	(self class blackListMethodNames includes: aNode selector) ifTrue: [ ^ false ].

	^ super appliesToNode: aNode
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> applyMutation: aMutation [

	| refactoring failing selector permutations newName |
	selector := aMutation originalMethod selector.
	permutations := selector count: [ :c | c = $: ].
	refactoring := ReRenameMethodRefactoring
						 model: (RBNamespace onEnvironment: classEnvironment)
		               renameMethod: selector
		               in: aMutation originalMethod methodClass name
		               to: ''
		               permutation: (1 to: permutations).
	newName := nameStrategy forNode: aMutation data and: refactoring.
	refactoring newName: newName.

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
	refactoring prepareForExecution.
	failing := refactoring failedApplicabilityPreconditions
		           asOrderedCollection.
	failing addAll: refactoring failedBreakingChangePreconditions.
	^ failing isEmpty
]

{ #category : 'as yet unclassified' }
RenameMethodMutationOperator >> createRefactoringFor: aNode [

	| refactoring model |
	model := RBNamespace onEnvironment: classEnvironment.
	refactoring := ReRenameMethodRefactoring
		               model: model
		               renameMethod: aNode selector
		               in: aNode methodNode methodClass name
		               to: 'new' , aNode selector
		               permutation: #(  ).
	^ refactoring
]

{ #category : 'printing' }
RenameMethodMutationOperator >> description [
	
	^ 'Rename a method'
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode sourceInterval first to: aNode selector size with: 'NEW' , aNode selector
]

{ #category : 'private' }
RenameMethodMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| affectedNodes |
	((aCompiledMethod hasPragmaNamed: #ignoreForMutations) or: [
		 aCompiledMethod hasPragmaNamed: #ignoreForCoverage ]) ifTrue: [
		^ #(  ) ].

	affectedNodes := self affectedNodesFor: aParseTree.
	^ affectedNodes collectWithIndex: [ :affectedNode :index |
		  RefactoringMutation
			  for: aCompiledMethod
			  using: self
			  nodeNumber: index
			  ofClass: aCompiledMethod methodClass
			  withData: affectedNode ]
]

{ #category : 'accessing' }
RenameMethodMutationOperator >> nameStrategy: aStrategy [

	nameStrategy := aStrategy 
]
