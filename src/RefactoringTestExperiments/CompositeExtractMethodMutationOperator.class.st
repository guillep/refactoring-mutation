Class {
	#name : 'CompositeExtractMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#instVars : [
		'model'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CompositeExtractMethodMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := ReCompositeExtractMethodRefactoring 
						 model: model
		               extract: aMutation data
		               from: aMutation originalMethod selector
						  to: #foo
		               in: aMutation originalMethod methodClass name.

	refactoring prepareForExecution.
	
	refactoring selector: #foo , ('' join: (refactoring arguments collect: [ :e | '_:' ])).
	
	aMutation shouldApplyPreconditions ifTrue: [
		refactoring applicabilityPreconditions check ifFalse: [ self error ] ].
	
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
CompositeExtractMethodMutationOperator >> canRefactor: aNode [

	| refactoring |
	refactoring := ReCompositeExtractMethodRefactoring
						 model: model
		               extract: aNode sourceCode
		               from: aNode methodNode selector
						  to: #foo
		               in: aNode methodNode methodClass name.

	[
	refactoring prepareForExecution.
	refactoring checkPreconditions ]
		on: RBRefactoringError , RBRefactoringWarning
		do: [ ^ false ].
	^ true
]

{ #category : 'printing' }
CompositeExtractMethodMutationOperator >> description [
	
	^ 'Extract an expression/statement from the method into a separate method'
]

{ #category : 'accessing' }
CompositeExtractMethodMutationOperator >> model: aRBNamespace [ 
	model := aRBNamespace 
]

{ #category : 'instance creation' }
CompositeExtractMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	| start |
	start := aCompiledMethod sourceCode findString: aNode.
	^ aCompiledMethod sourceCode copyReplaceFrom: start to: start + aNode size - 1 with: ' EXTRACTED '
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
			  withData: affectedNode sourceCode ]
]
