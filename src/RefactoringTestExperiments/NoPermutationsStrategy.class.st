Class {
	#name : 'NoPermutationsStrategy',
	#superclass : 'MethodNamePermutationsStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
NoPermutationsStrategy >> forNode: aNode and: aModel [

	^ self noPermutationsFor: aNode
]
