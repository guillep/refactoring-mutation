Class {
	#name : 'ExistingInstanceVariableNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
ExistingInstanceVariableNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
ExistingInstanceVariableNameStrategy >> forNode: aNode and: aModel [

	^ { aNode methodNode methodClass instVarNames
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ aNode methodNode methodClass instVarNames first ] }
]
