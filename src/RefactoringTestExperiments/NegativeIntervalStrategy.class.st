Class {
	#name : 'NegativeIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NegativeIntervalStrategy class >> isValidInput [

	^ false
]

{ #category : 'running' }
NegativeIntervalStrategy >> forNode: aNode and: aModel [

	^ { aNode stop to: aNode start }
]
