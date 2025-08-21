Class {
	#name : 'NameStartingWithNumberStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NameStartingWithNumberStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
NameStartingWithNumberStrategy >> forNode: aNode and: aModel [

	^ '1uniqueName'
]
