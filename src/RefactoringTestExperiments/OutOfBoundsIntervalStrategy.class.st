Class {
	#name : 'OutOfBoundsIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
OutOfBoundsIntervalStrategy >> forNode: aNode and: aModel [

	^ { aNode start to: aNode methodNode sourceCode size + 1 }
]
