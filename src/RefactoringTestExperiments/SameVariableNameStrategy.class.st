Class {
	#name : 'SameVariableNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
SameVariableNameStrategy >> forNode: aNode and: aRefactoring [

	^ aNode name
]
