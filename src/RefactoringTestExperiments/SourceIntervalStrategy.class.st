Class {
	#name : 'SourceIntervalStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
SourceIntervalStrategy class >> invalidIntervals [

	^ self subclasses reject: [ :each | each isValidInput ] thenCollect: [ :each | each new ]
]

{ #category : 'as yet unclassified' }
SourceIntervalStrategy class >> validIntervals [

	^ self subclasses select: [ :each | each isValidInput ] thenCollect: [ :each | each new ]
]

{ #category : 'applying' }
SourceIntervalStrategy >> appliesToNode: aNode [

	^ true
]

{ #category : 'as yet unclassified' }
SourceIntervalStrategy >> classNameFor: aMutant [

	^ 'UniqueNameInTheSystem'
]

{ #category : 'running' }
SourceIntervalStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
SourceIntervalStrategy >> key [

	^ #interval
]

{ #category : 'as yet unclassified' }
SourceIntervalStrategy >> tempNameFor: aMutant [

	^ #foo , aMutant data name
]
