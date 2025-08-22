Class {
	#name : 'NameWithSpaceStrategy',
	#superclass : 'VariableNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NameWithSpaceStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
NameWithSpaceStrategy >> forNode: aNode and: aModel [

	^ 'should not pass'
]

{ #category : 'running' }
NameWithSpaceStrategy >> tempNameFor: aMutant [

	^ 'should not pass'
]
