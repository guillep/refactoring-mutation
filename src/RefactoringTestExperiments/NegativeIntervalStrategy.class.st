Class {
	#name : 'NegativeIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
NegativeIntervalStrategy >> forNode: aNode [

	^ aNode stop to: aNode start
]
