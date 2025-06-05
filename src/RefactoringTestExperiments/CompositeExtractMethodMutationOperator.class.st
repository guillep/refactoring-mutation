Class {
	#name : 'CompositeExtractMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CompositeExtractMethodMutationOperator >> applyMutation: aMutation [


	aMutation shouldApplyPreconditions ifTrue: [
		[ aMutation refactoring checkApplicabilityPreconditions ]
			on: RBRefactoringError, RBRefactoringWarning
			do: [ self error ] ].

	aMutation refactoring privateTransform.
	aMutation refactoring performChanges
]

{ #category : 'mutant generation' }
CompositeExtractMethodMutationOperator >> createRefactoringWith: aMutation [

	| refactoring model |
	(aMutation inputFor: #interval) ifNil: [ ^ nil ].
	model := RBNamespace onEnvironment: classEnvironment.
	refactoring := ReCompositeExtractMethodRefactoring
		               model: model
		               extractInterval: (aMutation inputFor: #interval)
		               from: aMutation originalMethod selector
		               to: #foo
		               in: aMutation originalMethod methodClass name.
	[ refactoring prepareForExecution ] on: Error do: [ ^ nil ]. "we need to prepare so we can set new name with correct arrity"
	refactoring arguments ifNil: [ ^ nil ]. "if we don't have subtree, we don't have arguments"
	refactoring newSelector:
		#foo , ('' join: (refactoring arguments collect: [ :e | '_:' ])).
	^ refactoring
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

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
