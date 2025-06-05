Class {
	#name : 'NodeIntervalMutateStartAndStopStrategy',
	#superclass : 'SourceIntervalStrategy',
	#instVars : [
		'startOffset',
		'stopOffset'
	],
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NodeIntervalMutateStartAndStopStrategy class >> isValidInput [

	^ false
]

{ #category : 'running' }
NodeIntervalMutateStartAndStopStrategy >> forNode: aNode and: aModel [

	^ { aNode sourceInterval }
]
