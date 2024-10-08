Class {
	#name : 'RenameMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
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

	(aNode isMessage or: [ aNode isMethod ]) ifFalse: [ ^ false ].

	^ super appliesToNode: aNode
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> applyMutation: aMutation [

	| refactoring failing parsedExpression selector permutations |
	parsedExpression := RBParser parseExpression: (aMutation originalMethod sourceCode
				                copyFrom: aMutation data first
				                to: aMutation data last).
	selector := parsedExpression selector.
	permutations := selector count: [ :c | c = $: ].
	refactoring := ReRenameMethodRefactoring
						 model: (RBNamespace onEnvironment: classEnvironment)
		               renameMethod: selector
		               in: aMutation originalMethod methodClass name
		               to: 'new' , selector
		               permutation: (1 to: permutations).

	refactoring prepareForExecution.
	failing := refactoring failedApplicabilityPreconditions.
	failing ifNotEmpty: [ RBRefactoringError signal ].
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> canRefactor: aNode [

	| refactoring failing model |
	model := RBNamespace onEnvironment: classEnvironment.
	refactoring := ReRenameMethodRefactoring
						 model: model
		               renameMethod: aNode selector
		               in: aNode methodNode methodClass name
		               to: 'new' , aNode selector
		               permutation: #(  ).

	refactoring prepareForExecution.
	failing := refactoring failedApplicabilityPreconditions asOrderedCollection.
	failing addAll: refactoring failedBreakingChangePreconditions.
	^ failing isEmpty
]

{ #category : 'printing' }
RenameMethodMutationOperator >> description [
	
	^ 'Rename a method'
]

{ #category : 'instance creation' }
RenameMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode first to: aNode last with: ' EXTRACTED '
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
			  withData: affectedNode sourceInterval ]
]
