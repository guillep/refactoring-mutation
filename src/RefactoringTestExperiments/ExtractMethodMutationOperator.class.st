Class {
	#name : 'ExtractMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> applyMutation: aMutation [

	| failing |
	aMutation refactoring prepareForExecution.
	aMutation refactoring options at: #methodName put: [ :aMethodName :ref |
		aMethodName
			selector: #foo , ('' join: (aMutation refactoring parameters collect: [ :e | '_:' ]));
			yourself ].
	aMutation shouldCheckApplicability ifTrue: [
			failing := aMutation refactoring failedApplicabilityPreconditions.
			aMutation failedApplicabilityPreconditions: failing.
			failing ifNotEmpty: [ RBRefactoringError signal ].
			aMutation shouldCheckBehaviorPreserving ifTrue: [
					failing := aMutation refactoring
						           failedBreakingChangePreconditions.
					aMutation failedBehaviorPreservingPreconditions: failing.
					failing ifNotEmpty: [ RBRefactoringWarning signal ] ] ].
	aMutation refactoring privateTransform.
	aMutation refactoring performChanges
]

{ #category : 'private' }
ExtractMethodMutationOperator >> createRefactoringWith: aMutant [

	| refactoring options |
	(aMutant inputFor: #interval) ifNil: [ ^ nil ].
	refactoring := RBExtractMethodRefactoring
		               extract: (aMutant inputFor: #interval)
		               from: aMutant data methodNode selector
		               in: aMutant data methodNode methodClass name.

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


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode sourceInterval first to: aNode sourceInterval last with: 'EXTRACTED '
]
