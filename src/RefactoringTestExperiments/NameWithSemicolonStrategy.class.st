Class {
	#name : 'NameWithSemicolonStrategy',
	#superclass : 'VariableNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NameWithSemicolonStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
NameWithSemicolonStrategy >> forNode: aNode and: aModel [

	^ 'not;allowed'
]

{ #category : 'running' }
NameWithSemicolonStrategy >> tempNameFor: aMutant [

	^ 'not;allowed'
]
