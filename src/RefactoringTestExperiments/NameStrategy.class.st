Class {
	#name : 'NameStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
NameStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
NameStrategy >> key [

	^ #name
]
