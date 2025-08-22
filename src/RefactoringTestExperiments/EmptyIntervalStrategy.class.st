Class {
	#name : 'EmptyIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
EmptyIntervalStrategy class >> isValidInput [

	^ false
]

{ #category : 'running' }
EmptyIntervalStrategy >> forNode: aNode and: aModel [

	^ aNode start to: aNode start
]

{ #category : 'running' }
EmptyIntervalStrategy >> intervalFor: aMutant [

	^ aMutant data start to: aMutant data start
]
