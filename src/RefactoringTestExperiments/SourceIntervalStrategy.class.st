Class {
	#name : 'SourceIntervalStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'applying' }
SourceIntervalStrategy >> appliesToNode: aNode [

	^ true
]

{ #category : 'running' }
SourceIntervalStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
SourceIntervalStrategy >> key [

	^ #interval
]
