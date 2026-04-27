Class {
	#name : 'AbstractStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'checking' }
AbstractStrategy >> appliesToNode: aNode [

	^ self subclassResponsibility
]

{ #category : 'running' }
AbstractStrategy >> forNode: aNode and: aModel [ 
	^ self subclassResponsibility
]

{ #category : 'accessing' }
AbstractStrategy >> key [

	^ self subclassResponsibility 
]
