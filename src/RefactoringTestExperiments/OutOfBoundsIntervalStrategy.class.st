Class {
	#name : 'OutOfBoundsIntervalStrategy',
	#superclass : 'SourceIntervalStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
OutOfBoundsIntervalStrategy >> forNode: aNode [

	^ aNode start to: aNode methodNode sourceCode size + 1
]
