Class {
	#name : 'SwapFirstTwoPermutationStrategy',
	#superclass : 'MethodNamePermutationsStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
SwapFirstTwoPermutationStrategy >> forNode: aNode and: aModel [

	| permutations |
	permutations := (self noPermutationsFor: aNode) asArray.
	permutations size < 2 ifTrue: [ ^ { nil } ]. "we cannot permutate when we have 0 or 1 arguments"
	permutations at: 1 put: 2.
	permutations at: 2 put: 1.
	^ permutations
]

{ #category : 'running' }
SwapFirstTwoPermutationStrategy >> methodNameFor: aMutant [

	^ #foo , aMutant data selector
]

{ #category : 'running' }
SwapFirstTwoPermutationStrategy >> permutationsFor: aMutant [

	| permutations |
	permutations := (self noPermutationsFor: aMutant data) asArray.
	permutations size < 2 ifTrue: [ ^ { nil } ]. "we cannot permutate when we have 0 or 1 arguments"
	permutations at: 1 put: 2.
	permutations at: 2 put: 1.
	^ permutations
]
