Class {
	#name : 'EmptyIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
EmptyIntervalStrategy >> forNode: aNode [

	^ { aNode start to: aNode start }
]
