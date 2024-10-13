Class {
	#name : 'MethodNameStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
MethodNameStrategy >> permutationsForNode: aNode [

	| keywords |
	keywords := aNode selector count: [ :c | c = $: ].
	^ 1 to: keywords
]
