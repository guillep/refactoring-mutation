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
	(aMutation inputFor: #interval) ifNil: [ ^ nil ].
	refactoring := self createRefactoringWithInterval: (aMutation inputFor: #interval) andMethodNode: aMutation originalMethod.

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
