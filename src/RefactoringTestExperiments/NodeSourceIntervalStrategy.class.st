Class {
	#name : 'NodeSourceIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NodeSourceIntervalStrategy class >> isValidInput [

	^ true
]

{ #category : 'running' }
NodeSourceIntervalStrategy >> forNode: aNode and: aModel [

	^ { aNode sourceInterval }
]
