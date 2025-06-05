Class {
	#name : 'ExistingTempOrArgNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
ExistingTempOrArgNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
ExistingTempOrArgNameStrategy >> forNode: aNode and: aModel [

	| existingNames |
	existingNames := aNode methodNode allDefinedVariables reject: [ :var | var = aNode name ].
	^ { existingNames
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ existingNames first ] }
]
