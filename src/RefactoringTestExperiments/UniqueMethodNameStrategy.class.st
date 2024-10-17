Class {
	#name : 'UniqueMethodNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
UniqueMethodNameStrategy >> forNode: aNode and: aModel [

	^ { #foo , aNode selector }
]
