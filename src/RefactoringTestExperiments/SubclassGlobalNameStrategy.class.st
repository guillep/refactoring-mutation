Class {
	#name : 'SubclassGlobalNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
SubclassGlobalNameStrategy >> forNode: aNode and: aModel [

	| class |
	class := aModel classNamed: aNode name.
	^ { class subclasses
			ifEmpty: [ nil ]
			ifNotEmpty: [ class subclasses first name ] }
]
