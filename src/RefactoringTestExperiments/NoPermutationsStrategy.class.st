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

{ #category : 'running' }
NoPermutationsStrategy >> methodNameFor: aMutant [

	^ #foo , aMutant data selector
]

{ #category : 'running' }
NoPermutationsStrategy >> permutationsFor: aMutant [

	^ self noPermutationsFor: aMutant data
]
