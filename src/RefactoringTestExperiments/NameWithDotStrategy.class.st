Class {
	#name : 'NameWithDotStrategy',
	#superclass : 'VariableNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NameWithDotStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
NameWithDotStrategy >> forNode: aNode and: aModel [

	^ 'not.allowed'
]

{ #category : 'running' }
NameWithDotStrategy >> tempNameFor: aMutant [

	^ 'not.allowed'
]
