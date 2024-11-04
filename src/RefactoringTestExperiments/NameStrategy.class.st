Class {
	#name : 'NameStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

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
