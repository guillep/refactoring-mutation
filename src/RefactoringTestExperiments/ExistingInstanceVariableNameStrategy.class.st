Class {
	#name : 'ExistingInstanceVariableNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
ExistingInstanceVariableNameStrategy >> forNode: aNode and: aRefactoring [

	^ aNode methodNode methodClass instVarNames
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ aNode methodNode methodClass instVarNames first ]
]
