Class {
	#name : 'NegativeIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
NegativeIntervalStrategy >> forNode: aNode [

	^ { aNode stop to: aNode start }
]

{ #category : 'running' }
NegativeIntervalStrategy >> forNode: aNode and: aModel [

	^ { aNode stop to: aNode start }
]
