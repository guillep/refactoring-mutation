"
I am a report that contains mutation analysis and refactoring code coverage.
I implement printOn: to easier document results of the tests.
"
Class {
	#name : 'RefactoringMutationReport',
	#superclass : 'Object',
	#instVars : [
		'mutationAnalysis',
		'coverage'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'accessing' }
RefactoringMutationReport >> coverage [
	^ coverage
]

{ #category : 'accessing' }
RefactoringMutationReport >> coverage: aDTCoverageResult [

	coverage := aDTCoverageResult
]

{ #category : 'accessing' }
RefactoringMutationReport >> mutationAnalysis [

	^ mutationAnalysis
]

{ #category : 'accessing' }
RefactoringMutationReport >> mutationAnalysis: aMTAnalysis [

	mutationAnalysis := aMTAnalysis
]

{ #category : 'coverage' }
RefactoringMutationReport >> previewCoverageInDrTests [

	| dr result notExecuted methodsSize |
	dr := DrTests open.
	dr pluginsDropList selectIndex: 2.
	dr currentPlugin: (dr pluginsDropList selectedItem new).
	result := DTTestCoverageResult new.
	notExecuted := coverage uncoveredMethods.
	methodsSize := coverage methods size + coverage uncoveredMethods size.
	result
		percent: 1s2 - (notExecuted size / methodsSize asScaledDecimal: 2);
		methodList: notExecuted;
		partiallyCoveredMethods: coverage partiallyCoveredMethods.
	dr pluginResult: result.
	dr updateWithPluginResult: result.
]

{ #category : 'printing' }
RefactoringMutationReport >> printCsvOn: aStream [

	| result |
	result := mutationAnalysis generalResult.
	aStream print: result numberOfEvaluatedMutants.
	aStream nextPutAll: ','.
	aStream print: result numberOfKilledMutants.
	aStream nextPutAll: ','.
	aStream print: result numberOfAliveMutants.
	aStream nextPutAll: ','.
	aStream print: result numberOfTerminatedMutants.
	aStream nextPutAll: ','.
	aStream print: result mutationScore.
	aStream nextPutAll: '%,'.
	aStream print: result elapsedTime.
	aStream nextPutAll: ','.
	aStream print:
		(100.0 * coverage methods size / coverage collector methods size)
			rounded.
	aStream nextPutAll: '%,('.
	aStream print: coverage methods size.
	aStream nextPutAll: '/'.
	aStream print: coverage collector methods size.
	aStream nextPutAll: '),'.
	aStream print:
		(100.0 * coverage nodes size / coverage collector nodes size)
			rounded.
	aStream nextPutAll: '%,('.
	aStream print: coverage nodes size.
	aStream nextPutAll: '/'.
	aStream print: coverage collector nodes size.
	aStream nextPutAll: ')'.
	aStream nextPut: Character lf.
]

{ #category : 'printing' }
RefactoringMutationReport >> printOn: aStream [

	aStream print: mutationAnalysis generalResult.
	aStream nextPut: Character space.
	aStream print: mutationAnalysis generalResult elapsedTime.
	aStream nextPut: Character space.
	aStream nextPutAll: 'Method coverage: '.
	aStream print:
		(100.0 * coverage methods size / coverage collector methods size)
			rounded.
	aStream nextPut: Character space.
	aStream nextPutAll: '% ('.
	aStream print: coverage methods size.
	aStream nextPutAll: '/'.
	aStream print: coverage collector methods size.
	aStream nextPutAll: ')'.
	aStream nextPut: Character space.
	aStream nextPutAll: 'Node Coverage: '.
	aStream print:
		(100.0 * coverage nodes size / coverage collector nodes size)
			rounded.
	aStream nextPutAll: '% ('.
	aStream print: coverage nodes size.
	aStream nextPutAll: '/'.
	aStream print: coverage collector nodes size.
	aStream nextPutAll: ')'
]
