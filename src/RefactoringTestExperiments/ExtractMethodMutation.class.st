Class {
	#name : 'ExtractMethodMutation',
	#superclass : 'MTMethodMutation',
	#instVars : [
		'theSelector',
		'shouldApplyPreconditions'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'installing' }
ExtractMethodMutation >> doNotApplyPreconditions [

	shouldApplyPreconditions := false
]

{ #category : 'installing' }
ExtractMethodMutation >> initialize [

	super initialize.
	shouldApplyPreconditions := true
]

{ #category : 'installing' }
ExtractMethodMutation >> install [

	| refactoring options |
	theSelector := ''.
	refactoring := RBExtractMethodRefactoring
		               extract: data
		               from: originalMethod selector
		               in: originalMethod methodClass name.
	options := refactoring options copy.
	options at: #methodName put: [ :aMethodName :ref |
		aMethodName
			selector: #foo , ('' join: (ref parameters collect: [ :e | '_:' ]));
			yourself ].
	options at: #extractAssignment put: [ :a :b | true ].
	refactoring options: options.
	
	refactoring prepareForExecution.
	shouldApplyPreconditions ifTrue: [
		refactoring applicabilityPreconditions check ifFalse: [ self error ] ].
	refactoring privateTransform.
	refactoring performChanges.

	theSelector := refactoring newExtractedSelector
]

{ #category : 'installing' }
ExtractMethodMutation >> uninstall [

	super uninstall.
	
	(theSelector beginsWith: #foo) ifTrue: [
		| didError |
		didError := originalClass removeSelector: theSelector.
		didError ifNil: [ self halt ]]
]
