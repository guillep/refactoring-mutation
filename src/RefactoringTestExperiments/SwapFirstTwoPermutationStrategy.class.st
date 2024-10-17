Class {
	#name : 'SwapFirstTwoPermutationStrategy',
	#superclass : 'MethodNamePermutationsStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
SwapFirstTwoPermutationStrategy >> forNode: aNode [

	| permutations |
	permutations := (self noPermutationsFor: aNode) asArray.
	permutations at: 1 put: 2.
	permutations at: 2 put: 1.
	^ permutations
]
