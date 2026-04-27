Class {
	#name : 'MethodNamePermutationsStrategy',
	#superclass : 'AbstractStrategy',
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

{ #category : 'checking' }
MethodNamePermutationsStrategy >> appliesToNode: aNode [

	^ aNode isMethod
]

{ #category : 'running' }
MethodNamePermutationsStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MethodNamePermutationsStrategy >> key [

	^ #permutations
]

{ #category : 'running' }
MethodNamePermutationsStrategy >> methodNameFor: aMutant [ 
	^ self subclassResponsibility
]

{ #category : 'running' }
MethodNamePermutationsStrategy >> noPermutationsFor: aNode [

	| keywords |
	keywords := aNode selector count: [ :c | c = $: ].
	^ 1 to: keywords
]

{ #category : 'running' }
MethodNamePermutationsStrategy >> permutationsFor: aMutant [ 
	^ self subclassResponsibility
]
