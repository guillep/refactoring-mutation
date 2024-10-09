Class {
	#name : 'ExtractMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> applyMutation: aMutation [

	| refactoring options |
	refactoring := RBExtractMethodRefactoring
		               extract: aMutation data
		               from: aMutation originalMethod selector
		               in: aMutation originalMethod methodClass name.
	options := refactoring options copy.
	options at: #methodName put: [ :aMethodName :ref |
		aMethodName
			selector: #foo , ('' join: (ref parameters collect: [ :e | '_:' ]));
			yourself ].
	options at: #extractAssignment put: [ :a :b | true ].
	refactoring options: options.

	refactoring prepareForExecution.
	aMutation shouldApplyPreconditions ifTrue: [
		refactoring checkApplicabilityPreconditions ].
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> canRefactor: aNode [

	| refactoring options |
	refactoring := RBExtractMethodRefactoring
		               extract: aNode sourceInterval
		               from: aNode methodNode selector
		               in: aNode methodNode methodClass name.

	options := refactoring options copy.
	options at: #methodName put: [ :aMethodName :ref |
		1 halt.
		aMethodName
			selector: #foo;
			yourself ].
	options at: #extractAssignment put: [ :a :b | true ].
	refactoring options: options.

	[
	refactoring prepareForExecution.
	refactoring checkPreconditions ]
		on: RBRefactoringError , RBRefactoringWarning
		do: [ ^ false ].
	^ true
]

{ #category : 'printing' }
ExtractMethodMutationOperator >> description [
	
	^ 'Extract an expression/statement from the method into a separate method'
]

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode first to: aNode last with: ' EXTRACTED '
]

{ #category : 'private' }
ExtractMethodMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

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
