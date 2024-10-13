Class {
	#name : 'RenameMethodMultipleNamesMutationOperator',
	#superclass : 'RenameMethodMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameMethodMultipleNamesMutationOperator >> applyMutation: aMutation [

	| refactoring failing selector permutations |
	selector := aMutation originalMethod selector.
	permutations := selector count: [ :c | c = $: ].
	refactoring := ReRenameMethodRefactoring
						 model: (RBNamespace onEnvironment: classEnvironment)
		               renameMethod: selector
		               in: aMutation originalMethod methodClass name
		               to: (aMutation data)
		               permutation: (1 to: permutations).

	refactoring prepareForExecution.
	failing := refactoring failedApplicabilityPreconditions.
	failing ifNotEmpty: [ RBRefactoringError signal ].
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
RenameMethodMultipleNamesMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aParseTree sourceInterval first to: aParseTree selector size with: aNode
]

{ #category : 'mutant generation' }
RenameMethodMultipleNamesMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| affectedNodes model namesList |
	((aCompiledMethod hasPragmaNamed: #ignoreForMutations) or: [
		 aCompiledMethod hasPragmaNamed: #ignoreForCoverage ]) ifTrue: [
		^ #(  ) ].

	affectedNodes := self affectedNodesFor: aParseTree.
	affectedNodes ifEmpty: [ ^ #() ].
	aParseTree methodClass superclass name = 'Object' ifTrue: [ ^ #() ].
	model := RBNamespace onEnvironment: classEnvironment.
	namesList := nameStrategy forNode: aParseTree with: model.
	namesList reject: [ :name | self class blackListMethodNames includes: name ].
	^ namesList collectWithIndex: [ :name :index |
		  RefactoringMutation
			  for: aCompiledMethod
			  using: self
			  nodeNumber: index
			  ofClass: aCompiledMethod methodClass
			  withData: name ]
]
