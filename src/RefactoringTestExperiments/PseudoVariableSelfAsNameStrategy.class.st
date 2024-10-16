Class {
	#name : 'PseudoVariableSelfAsNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
PseudoVariableSelfAsNameStrategy >> forNode: aNode and: aRefactoring [

	^ { 'self' }
]
