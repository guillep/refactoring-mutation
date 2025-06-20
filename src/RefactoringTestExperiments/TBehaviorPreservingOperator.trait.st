Trait {
	#name : 'TBehaviorPreservingOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'checking' }
TBehaviorPreservingOperator >> appliesToMutant: aMutant [
	"take only mutants that fail behavior preserving preconditions"
	[
		[ aMutant refactoring prepareForExecution ]
			on: RBRefactoringError
			do: [ ^ false ] ]
		on: RBRefactoringWarning
		do: [ ^ true ].
	^ false
]

{ #category : 'testing' }
TBehaviorPreservingOperator >> canRefactor: aMutant [
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
TBehaviorPreservingOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	"Checks applicability but skips behavior preserving ones"
	mutations do: [ :e | e doNotCheckBehaviorPreserving ].
	^ mutations
]
