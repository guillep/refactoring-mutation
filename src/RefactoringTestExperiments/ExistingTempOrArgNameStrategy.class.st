Class {
	#name : 'ExistingTempOrArgNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
ExistingTempOrArgNameStrategy >> forNode: aNode and: aRefactoring [

	| existingNames |
	existingNames := aNode methodNode allDefinedVariables reject: [ :var | var = aNode name ].
	^ existingNames
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ existingNames first ]
]
