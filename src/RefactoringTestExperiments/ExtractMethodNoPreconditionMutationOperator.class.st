Class {
	#name : 'ExtractMethodNoPreconditionMutationOperator',
	#superclass : 'ExtractMethodMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtractMethodNoPreconditionMutationOperator >> applyMutation: aMutation [

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
	options at: #extractAssignment put: [ :a :b | false ].
	options at: #existingSelector put: [ :a | nil ].
	refactoring options: options.

	[ refactoring prepareForExecution; checkApplicabilityPreconditions ]
		on: RBRefactoringError 
		do: [ :e | "We ignore the fact the exception happened and continue" ].
	refactoring privateTransform.
	refactoring performChanges
]

{ #category : 'instance creation' }
ExtractMethodNoPreconditionMutationOperator >> canRefactor: aNode [

	^ (super canRefactor: aNode) not
]

{ #category : 'private' }
ExtractMethodNoPreconditionMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	mutations do: [ :e | e doNotApplyPreconditions ].
	^ mutations
]
