Class {
	#name : 'MethodNamePermutationsStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
MethodNamePermutationsStrategy class >> invalidAddArgPermutations [

	^ { NoPermutationsStrategy new . SwapFirstTwoPermutationStrategy new }
]

{ #category : 'as yet unclassified' }
MethodNamePermutationsStrategy class >> invalidRenameMethodPermutations [

	^ { AddArgumentPermutationsStrategy new }
]

{ #category : 'as yet unclassified' }
MethodNamePermutationsStrategy class >> validAddArgPermutations [

	^ { AddArgumentPermutationsStrategy new }
]

{ #category : 'as yet unclassified' }
MethodNamePermutationsStrategy class >> validRenameMethodPermutations [

	^ { NoPermutationsStrategy new }
]

{ #category : 'applying' }
MethodNamePermutationsStrategy >> appliesToNode: aNode [

	^ aNode isMethod
]

{ #category : 'as yet unclassified' }
MethodNamePermutationsStrategy >> forNode: aNode and: aModel [

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
