Class {
	#name : 'UniqueMethodNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
UniqueMethodNameStrategy class >> isValidInput [ 

	^ true
]

{ #category : 'running' }
UniqueMethodNameStrategy >> forNode: aNode and: aModel [

	^ #foo , aNode selector
]

{ #category : 'running' }
UniqueMethodNameStrategy >> methodNameFor: aMutant [

	^ #foo , aMutant data selector
]
