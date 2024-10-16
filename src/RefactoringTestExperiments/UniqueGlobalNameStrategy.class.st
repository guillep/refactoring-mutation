Class {
	#name : 'UniqueGlobalNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
UniqueGlobalNameStrategy >> forNode: aNode and: aRefactoring [

	^ { 'UniqueNameInTheSystem' }
]
