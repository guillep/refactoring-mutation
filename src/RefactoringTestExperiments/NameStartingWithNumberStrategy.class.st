Class {
	#name : 'NameStartingWithNumberStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
NameStartingWithNumberStrategy >> forNode: aNode and: aRefactoring [

	^ '1uniqueName' 
]
