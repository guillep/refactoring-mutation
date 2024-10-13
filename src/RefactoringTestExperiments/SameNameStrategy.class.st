Class {
	#name : 'SameNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
SameNameStrategy >> forNode: aNode and: aRefactoring [

	^ aNode selector
]
