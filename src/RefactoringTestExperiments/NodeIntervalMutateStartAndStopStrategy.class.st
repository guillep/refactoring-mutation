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

{ #category : 'running' }
NodeIntervalMutateStartAndStopStrategy >> forNode: aNode and: aModel [

	^ { aNode sourceInterval }
]
