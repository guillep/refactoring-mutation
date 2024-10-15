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

{ #category : 'as yet unclassified' }
NodeIntervalMutateStartAndStopStrategy >> forNode: aNode [

	^ aNode sourceInterval first + startOffset to: aNode sourceInterval last + stopOffset 
]

{ #category : 'as yet unclassified' }
NodeIntervalMutateStartAndStopStrategy >> start: aStartOffset stop: aStopOffset [

	startOffset := aStartOffset.
	stopOffset := aStopOffset.
]
