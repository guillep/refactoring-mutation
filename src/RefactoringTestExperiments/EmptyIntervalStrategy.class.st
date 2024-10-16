Class {
	#name : 'EmptyIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
EmptyIntervalStrategy >> forNode: aNode and: aModel [

	^ { aNode start to: aNode start }
]
