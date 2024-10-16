Class {
	#name : 'NameStartingWithNumberStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
NameStartingWithNumberStrategy >> forNode: aNode and: aRefactoring [

	^ { '1uniqueName' }
]
