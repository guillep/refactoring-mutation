Class {
	#name : 'SameNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
SameNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
SameNameStrategy >> forNode: aNode and: aRefactoring [

	^ aNode selector
]

{ #category : 'running' }
SameNameStrategy >> methodNameFor: aMutant [

	^ aMutant data selector
]
