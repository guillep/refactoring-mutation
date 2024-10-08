Class {
	#name : 'CompositeExtractMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CompositeExtractMethodMutationOperator >> applyMutation: aMutation [

	| refactoring model |
	model := RBNamespace onEnvironment: classEnvironment.
	refactoring := ReCompositeExtractMethodRefactoring
		               model: model
		               extractInterval: aMutation data
		               from: aMutation originalMethod selector
		               to: #foo
		               in: aMutation originalMethod methodClass name.

	refactoring prepareForExecution.

	refactoring newSelector:
		#foo , ('' join: (refactoring arguments collect: [ :e | '_:' ])).

	aMutation shouldApplyPreconditions ifTrue: [
		[ refactoring checkApplicabilityPreconditions ]
			on: RBRefactoringError
			do: [ self error ] ].

	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
CompositeExtractMethodMutationOperator >> canRefactor: aNode [

	| refactoring |
	refactoring := ReCompositeExtractMethodRefactoring
		               extractInterval: aNode sourceInterval
		               from: aNode methodNode selector
		               to: #foo
		               in: aNode methodNode methodClass name.

	[ refactoring prepareForExecution; checkPreconditions ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'printing' }
CompositeExtractMethodMutationOperator >> description [
	
	^ 'Extract an expression/statement from the method into a separate method'
]

{ #category : 'private' }
CompositeExtractMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode first to: aNode last with: ' EXTRACTED '
]

{ #category : 'mutant generation' }
CompositeExtractMethodMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

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
