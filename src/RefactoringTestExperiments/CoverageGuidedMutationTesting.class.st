Class {
	#name : 'CoverageGuidedMutationTesting',
	#superclass : 'MTAnalysis',
	#instVars : [
		'refactorings',
		'previousCoverage'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CoverageGuidedMutationTesting class >> forRefactorings: refactoringsList usingOperators: operatorsList [

	^ self new forRefactorings: refactoringsList usingOperators: operatorsList
]

{ #category : 'instance creation' }
CoverageGuidedMutationTesting >> forRefactorings: refactoringsList usingOperators: operatorsList [

	refactorings := refactoringsList.
	operators := operatorsList
]

{ #category : 'running' }
CoverageGuidedMutationTesting >> generateResults [

	mutantResults := OrderedCollection new.
	logger logStartMutationEvaluation: mutations.
	previousCoverage := 0.

	mutations do: [ :aMutation |
		| mutantEvaluation |
		(budget exceedsBudgetOn: mutantResults fromTotalMutations: mutations)
			ifTrue: [ ^ mutantResults ].
		logger logStartEvaluating: aMutation with: testCases size.

		mutantEvaluation := ((MTMutantEvaluation
				  for: aMutation
				  using: testCases
				  following: testSelectionStrategy
				  andConsidering: self coverageAnalysisResult)
				 valueStoppingOnError: stopOnErrorOrFail).
		(self mutantIncreasesCoverage: mutantEvaluation) ifTrue: [ mutantResults add: mutantEvaluation ].
		logger logEndEvaluating ].

	logger logEndMutationEvaluation.
	logger logEnd.
	^ mutantResults
]
