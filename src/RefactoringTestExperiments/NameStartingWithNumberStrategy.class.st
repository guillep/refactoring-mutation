Class {
	#name : 'NameStartingWithNumberStrategy',
	#superclass : 'VariableNameStrategy',
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

{ #category : 'running' }
NameStartingWithNumberStrategy >> tempNameFor: aMutant [

	^ '1uniqueName'
]
