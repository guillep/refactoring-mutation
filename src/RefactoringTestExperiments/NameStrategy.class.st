Class {
	#name : 'NameStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
NameStrategy class >> invalidGlobalAndVarNames [

	^ self subclasses reject: [ :each | each isValidInput ] thenCollect: [ :each | each new ]
]

{ #category : 'as yet unclassified' }
NameStrategy class >> validGlobalNames [

	^ { UniqueGlobalNameStrategy new }
]

{ #category : 'as yet unclassified' }
NameStrategy class >> validVarNames [

	^ { UniqueTempNameStrategy new }
]

{ #category : 'applying' }
NameStrategy >> appliesToNode: aNode [

	^ aNode isVariable
]

{ #category : 'running' }
NameStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
NameStrategy >> key [

	^ #name
]
