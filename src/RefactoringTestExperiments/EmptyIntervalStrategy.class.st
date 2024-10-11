Class {
	#name : 'EmptyIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
EmptyIntervalStrategy >> forNode: aNode [

	^ aNode start to: aNode start
]
