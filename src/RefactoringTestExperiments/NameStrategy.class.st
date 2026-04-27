Class {
	#name : 'NameStrategy',
	#superclass : 'AbstractStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
NameStrategy class >> invalidGlobalNames [

	^ ClassNameStrategy subclasses reject: [ :each | each isValidInput ] thenCollect: [ :each | each new ]
]

{ #category : 'as yet unclassified' }
NameStrategy class >> invalidVarNames [

	^ VariableNameStrategy subclasses reject: [ :each | each isValidInput ] thenCollect: [ :each | each new ]
]

{ #category : 'as yet unclassified' }
NameStrategy class >> validGlobalNames [

	^ { UniqueGlobalNameStrategy new }
]

{ #category : 'as yet unclassified' }
NameStrategy class >> validVarNames [

	^ { UniqueTempNameStrategy new }
]

{ #category : 'checking' }
NameStrategy >> appliesToNode: aNode [

	^ true
]

{ #category : 'running' }
NameStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]

{ #category : 'running' }
NameStrategy >> intervalFor: aMutant [

	^ aMutant data sourceInterval
]

{ #category : 'accessing' }
NameStrategy >> key [

	^ #name
]
