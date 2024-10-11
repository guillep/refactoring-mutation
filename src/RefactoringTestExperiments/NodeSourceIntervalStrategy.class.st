Class {
	#name : 'NodeSourceIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
NodeSourceIntervalStrategy >> forNode: aNode [

	^ aNode sourceInterval
]
