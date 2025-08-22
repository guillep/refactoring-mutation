Class {
	#name : 'ExistingTempOrArgNameStrategy',
	#superclass : 'VariableNameStrategy',
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
	^ existingNames
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ existingNames first ]
]

{ #category : 'running' }
ExistingTempOrArgNameStrategy >> tempNameFor: aMutant [

	| existingNames |
	existingNames := aMutant data methodNode allDefinedVariables reject: [ :var | var = aMutant data name ].
	^ existingNames
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ existingNames first ]
]
