"
I am a trait that is used on mutation operators to make them run only when applicability preconditions fail.
"
Trait {
	#name : 'TApplicabilityOperatior',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'checking' }
TApplicabilityOperatior >> appliesToMutant: aMutant [
	"take only mutants that fail applicability preconditions"

	[
		[ aMutant refactoring prepareForExecution ]
			on: RBRefactoringError
			do: [ ^ true ] ]
		on: RBRefactoringWarning
		do: [ ^ false ].
	^ false
]

{ #category : 'testing' }
TApplicabilityOperatior >> canRefactor: aMutant [
	"take only mutants that fail applicability preconditions"
	[
		| failing |
		aMutant refactoring prepareForExecution.
		aMutant shouldCheckApplicability ifTrue: [
				failing := aMutant refactoring failedApplicabilityPreconditions.
				aMutant failedApplicabilityPreconditions: failing.
				failing ifNotEmpty: [ ^ true ] ] ]
		on: RBRefactoringError
		do: [ ^ true ].
	[
		| failing |
		aMutant shouldCheckBehaviorPreserving ifTrue: [
				failing := aMutant refactoring failedBreakingChangePreconditions.
				aMutant failedBehaviorPreservingPreconditions: failing.
				failing ifNotEmpty: [ ^ false ] ] ]
		on: RBRefactoringWarning
		do: [ ^ false ].
	^ false
]

{ #category : 'mutant generation' }
TApplicabilityOperatior >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	"Does skip all preconditions"
	mutations do: [ :e | e doNotCheckApplicability "this is assumed: e doNotCheckBehaviorPreserving" ].
	^ mutations
]
