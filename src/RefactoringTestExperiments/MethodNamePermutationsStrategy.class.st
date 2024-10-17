Class {
	#name : 'MethodNamePermutationsStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
MethodNamePermutationsStrategy >> forNode: aNode [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MethodNamePermutationsStrategy >> key [

	^ #permutations
]

{ #category : 'as yet unclassified' }
MethodNamePermutationsStrategy >> noPermutationsFor: aNode [

	| keywords |
	keywords := aNode selector count: [ :c | c = $: ].
	^ 1 to: keywords
]
