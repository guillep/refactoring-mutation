Class {
	#name : 'UniqueTempNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
UniqueTempNameStrategy >> forNode: aNode and: aRefactoring [

	^ aRefactoring safeVariableNameFor: aRefactoring sourceClass temporaries: aNode methodNode allDefinedVariables basedOn: #foo
]
