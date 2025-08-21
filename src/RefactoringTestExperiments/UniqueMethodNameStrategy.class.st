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

{ #category : 'as yet unclassified' }
UniqueMethodNameStrategy >> forNode: aNode and: aModel [

	^ #foo , aNode selector
]

{ #category : 'as yet unclassified' }
UniqueMethodNameStrategy >> methodNameFor: aMutant [

	^ #foo , aMutant data selector
]
