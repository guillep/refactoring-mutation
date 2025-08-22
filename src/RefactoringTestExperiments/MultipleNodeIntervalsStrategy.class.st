Class {
	#name : 'MultipleNodeIntervalsStrategy',
	#superclass : 'SourceIntervalStrategy',
	#instVars : [
		'offset'
	],
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
MultipleNodeIntervalsStrategy class >> isValidInput [

	^ false
]

{ #category : 'running' }
MultipleNodeIntervalsStrategy >> forNode: aNode and: aModel [

	| start last |
	start := aNode sourceInterval first.
	last := aNode sourceInterval last.
	^ (start + offset to: last + offset)
]

{ #category : 'initialization' }
MultipleNodeIntervalsStrategy >> initialize [

	offset := 2
]

{ #category : 'running' }
MultipleNodeIntervalsStrategy >> intervalFor: aMutant [

	| start last |
	start := aMutant data sourceInterval first.
	last := aMutant data sourceInterval last.
	^ (start + offset to: last + offset)
]

{ #category : 'accessing' }
MultipleNodeIntervalsStrategy >> offset: aNumber [

	offset := aNumber
]
