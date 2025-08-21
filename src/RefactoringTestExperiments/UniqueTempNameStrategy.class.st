Class {
	#name : 'UniqueTempNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
UniqueTempNameStrategy class >> isValidInput [ 

	^ true
]

{ #category : 'running' }
UniqueTempNameStrategy >> forNode: aNode and: aModel [

	^ #foo , aNode name
]
