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

{ #category : 'running' }
MultipleNodeIntervalsStrategy >> forNode: aNode and: aModel [

	| start last |
	start := aNode sourceInterval first.
	last := aNode sourceInterval last.
	^ (1 to: offset) flatCollect: [ :num |
		  {
			  (start + num to: last).
			  (start to: last + num).
			  (start + num to: last + num) } ]
]

{ #category : 'initialization' }
MultipleNodeIntervalsStrategy >> initialize [

	offset := 2
]

{ #category : 'accessing' }
MultipleNodeIntervalsStrategy >> offset: aNumber [

	offset := aNumber
]
