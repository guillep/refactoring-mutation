Class {
	#name : 'SameVariableNameStrategy',
	#superclass : 'VariableNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
SameVariableNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
SameVariableNameStrategy >> forNode: aNode and: aModel [

	^ aNode name
]

{ #category : 'running' }
SameVariableNameStrategy >> tempNameFor: aMutant [

	^ aMutant data name
]
