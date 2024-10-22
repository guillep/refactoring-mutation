Class {
	#name : 'AddArgumentPermutationsStrategy',
	#superclass : 'MethodNamePermutationsStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
AddArgumentPermutationsStrategy >> forNode: aNode and: aModel [

	^ { (self noPermutationsFor: aNode) asArray , #(-1) }
]
