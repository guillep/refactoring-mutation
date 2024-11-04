Class {
	#name : 'MethodNameStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'applying' }
MethodNameStrategy >> appliesToNode: aNode [

	^ aNode isMethod
]

{ #category : 'accessing' }
MethodNameStrategy >> key [

	^ #methodName
]

{ #category : 'as yet unclassified' }
MethodNameStrategy >> permutationsForNode: aNode [

	| keywords |
	keywords := aNode selector count: [ :c | c = $: ].
	^ 1 to: keywords
]
