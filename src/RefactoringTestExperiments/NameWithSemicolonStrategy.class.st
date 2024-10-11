Class {
	#name : 'NameWithSemicolonStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
NameWithSemicolonStrategy >> forNode: aNode and: aRefactoring [

	^ 'not;allowed' 
]
