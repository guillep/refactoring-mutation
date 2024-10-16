Class {
	#name : 'SameNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
SameNameStrategy >> forNode: aNode and: aRefactoring [

	^ { aNode selector }
]
