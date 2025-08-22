Class {
	#name : 'OutOfBoundsIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
OutOfBoundsIntervalStrategy class >> isValidInput [

	^ false
]

{ #category : 'running' }
OutOfBoundsIntervalStrategy >> forNode: aNode and: aModel [

	^ aNode start to: aNode methodNode sourceCode size + 1
]

{ #category : 'running' }
OutOfBoundsIntervalStrategy >> intervalFor: aMutant [

	^ aMutant data start to: aMutant data methodNode sourceCode size + 1
]
