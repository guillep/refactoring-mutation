Class {
	#name : 'InlineMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
InlineMethodMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	^ aParseTree allChildren select: [ :aNode |
		  aNode isMessage and: [ self appliesToNode: aNode ] ]
]

{ #category : 'instance creation' }
InlineMethodMutationOperator >> applyMutation: aMutation [

	| refactoring options |
	refactoring := RBInlineMethodRefactoring
		               inline: aMutation data
		               inMethod: aMutation originalMethod selector
		               forClass: aMutation originalMethod methodClass name.

	options := refactoring options copy.
	options at: #inlineExpression put: [ :a :b | true ].
	refactoring options: options.

	refactoring prepareForExecution.
	aMutation shouldApplyPreconditions ifTrue: [
		refactoring applicabilityPreconditions check ifFalse: [ self error ] ].
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
InlineMethodMutationOperator >> canRefactor: aNode [

	| refactoring |
	refactoring := RBInlineMethodRefactoring
		               inline: aNode sourceInterval
		               inMethod: aNode methodNode selector
		               forClass: aNode methodNode methodClass name.

	[
	refactoring prepareForExecution.
	refactoring checkPreconditions ]
		on: RBRefactoringError , RBRefactoringWarning
		do: [ ^ false ].
	^ true
]

{ #category : 'printing' }
InlineMethodMutationOperator >> description [
	
	^ 'Extract an expression/statement from the method into a separate method'
]

{ #category : 'instance creation' }
InlineMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode first to: aNode last with: ' EXTRACTED '
]

{ #category : 'private' }
InlineMethodMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

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
