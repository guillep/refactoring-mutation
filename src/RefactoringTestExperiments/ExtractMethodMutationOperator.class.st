Class {
	#name : 'ExtractMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := self createRefactoringWithInterval: aMutation data andMethodNode: aMutation originalMethod.

	[ refactoring
		prepareForExecution;
		checkApplicabilityPreconditions;
		privateTransform
	] 
		on: RBRefactoringError 
	 	do: [ :e | self error ].

	refactoring performChanges
]

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> canRefactor: aNode [

	| refactoring |
	refactoring := self createRefactoringWithInterval: aNode sourceInterval andMethodNode: aNode methodNode.

	[
	refactoring prepareForExecution.
	refactoring checkPreconditions ]
		on: RBRefactoringError , RBRefactoringWarning
		do: [ ^ false ].
	^ true
]

{ #category : 'private' }
ExtractMethodMutationOperator >> createRefactoringWithInterval: anInterval andMethodNode: aMethodNode [

	| refactoring options |
	refactoring := RBExtractMethodRefactoring
		               extract: anInterval
		               from: aMethodNode selector
		               in: aMethodNode methodClass name.

	options := refactoring options copy.
	options at: #methodName put: [ :aMethodName :ref |
		aMethodName
			selector: #foo;
			yourself ].
	options at: #extractAssignment put: [ :a :b | true ].
	refactoring options: options.
	^ refactoring
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
