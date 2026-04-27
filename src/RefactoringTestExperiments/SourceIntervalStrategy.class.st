Class {
	#name : 'SourceIntervalStrategy',
	#superclass : 'AbstractStrategy',
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

{ #category : 'checking' }
SourceIntervalStrategy >> appliesToNode: aNode [

	^ true
]

{ #category : 'accessing' }
SourceIntervalStrategy >> classNameFor: aMutant [

	^ 'UniqueNameInTheSystem'
]

{ #category : 'running' }
SourceIntervalStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]

{ #category : 'running' }
SourceIntervalStrategy >> intervalFor: aMutant [ 
	^ self subclassResponsibility
]

{ #category : 'accessing' }
SourceIntervalStrategy >> key [

	^ #interval
]

{ #category : 'accessing' }
SourceIntervalStrategy >> tempNameFor: aMutant [

	^ #foo , aMutant data name
]
