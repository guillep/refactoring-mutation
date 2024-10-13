Class {
	#name : 'SwapMethodArgumentsStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
SwapMethodArgumentsStrategy >> forNode: aNode and: aRefactoring [

	^ aNode numArgs >= 2
		ifTrue: [ | node| node := aNode copy. ('' join: (node selectorParts swap: 1 with: 2)) asSymbol ]
		ifFalse: [ nil ]
]

{ #category : 'as yet unclassified' }
SwapMethodArgumentsStrategy >> permutationsForNode: aNode [

	| permutations |
	permutations := (super permutationsForNode: aNode) asArray.
	permutations at: 1 put: 2.
	permutations at: 2 put: 1.
	^ permutations
]
