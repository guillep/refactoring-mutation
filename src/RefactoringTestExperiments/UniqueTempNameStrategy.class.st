Class {
	#name : 'UniqueTempNameStrategy',
	#superclass : 'VariableNameStrategy',
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

{ #category : 'running' }
UniqueTempNameStrategy >> tempNameFor: aMutant [

	^ #foo , aMutant data name
]
