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
	"take only mutants that fail behavior preserving preconditions"
	[
		| failing |
		aMutant shouldCheckApplicability ifTrue: [
				failing := aMutant refactoring failedApplicabilityPreconditions.
				aMutant failedApplicabilityPreconditions: failing.
				failing ifNotEmpty: [ ^ false ] ] ]
		on: RBRefactoringError
		do: [ ^ false ].
	[
		| failing |
		aMutant shouldCheckBehaviorPreserving ifTrue: [
				failing := aMutant refactoring failedBreakingChangePreconditions.
				aMutant failedBehaviorPreservingPreconditions: failing.
				failing ifNotEmpty: [ ^ true ] ] ]
		on: RBRefactoringWarning
		do: [ ^ true ].
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
