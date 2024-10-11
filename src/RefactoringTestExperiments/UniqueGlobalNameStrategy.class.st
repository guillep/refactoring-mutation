Class {
	#name : 'UniqueGlobalNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
UniqueGlobalNameStrategy >> forNode: aNode and: aRefactoring [

	^ 'UniqueNameInTheSystem' 
]
