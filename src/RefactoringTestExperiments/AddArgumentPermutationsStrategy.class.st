Class {
	#name : 'AddArgumentPermutationsStrategy',
	#superclass : 'MethodNamePermutationsStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
AddArgumentPermutationsStrategy >> forNode: aNode and: aModel [

	^ (self noPermutationsFor: aNode) asArray , #(-1)
]

{ #category : 'running' }
AddArgumentPermutationsStrategy >> methodNameFor: aMutant [

	^ aMutant data selector, #foo:
]

{ #category : 'running' }
AddArgumentPermutationsStrategy >> permutationsFor: aMutant [

	^ (self noPermutationsFor: aMutant data) asArray , #(-1)
]
