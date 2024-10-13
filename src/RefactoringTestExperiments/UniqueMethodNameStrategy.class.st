Class {
	#name : 'UniqueMethodNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
UniqueMethodNameStrategy >> forNode: aNode and: aRefactoirng [

	^ aRefactoirng uniqueMethodNameFor: aNode arguments size
]