Class {
	#name : 'AddArgumentPermutationsStrategy',
	#superclass : 'MethodNamePermutationsStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
AddArgumentPermutationsStrategy >> forNode: aNode [

	^ self noPermutationsFor: aNode , -1
]
