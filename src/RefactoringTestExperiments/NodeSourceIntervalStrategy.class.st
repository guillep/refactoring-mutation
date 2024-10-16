Class {
	#name : 'NodeSourceIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
NodeSourceIntervalStrategy >> forNode: aNode [

	^ { aNode sourceInterval }
]
