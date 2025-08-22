Class {
	#name : 'SubclassGlobalNameStrategy',
	#superclass : 'ClassNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
SubclassGlobalNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'applying' }
SubclassGlobalNameStrategy >> appliesToNode: aNode [

	^ aNode isGlobalVariable 
]

{ #category : 'running' }
SubclassGlobalNameStrategy >> forNode: aNode and: aModel [

	| class |
	class := aModel classNamed: aNode name.
	^ class subclasses
			ifEmpty: [ nil ]
			ifNotEmpty: [ class subclasses first name ]
]

{ #category : 'running' }
SubclassGlobalNameStrategy >> nameFor: aMutant [

	| class |
	class := RBNamespace new classNamed: aMutant data name.
	^ class subclasses
			ifEmpty: [ nil ]
			ifNotEmpty: [ class subclasses first name ]
]

{ #category : 'running' }
SubclassGlobalNameStrategy >> nameFor: aMutant and: model [

	| class |
	class := model classNamed: aMutant data name.
	^ class subclasses
			ifEmpty: [ nil ]
			ifNotEmpty: [ class subclasses first name ]
]

{ #category : 'running' }
SubclassGlobalNameStrategy >> tempNameFor: aMutant [

	| class |
	class := aMutant data classNamed: aMutant data name.
	^ class subclasses
			ifEmpty: [ nil ]
			ifNotEmpty: [ class subclasses first name ]
]
