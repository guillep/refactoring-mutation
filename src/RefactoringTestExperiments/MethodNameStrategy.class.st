Class {
	#name : 'MethodNameStrategy',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
MethodNameStrategy class >> invalidMethodNames [

	^ self subclasses reject: [ :each | each isValidInput ] thenCollect: [ :each | each new ]
]

{ #category : 'as yet unclassified' }
MethodNameStrategy class >> validAddArgMethodNames [

	^ { MethodNameAdditionalArgumentStrategy new }
]

{ #category : 'as yet unclassified' }
MethodNameStrategy class >> validRenameMethodNames [

	^ { UniqueMethodNameStrategy new }
]

{ #category : 'applying' }
MethodNameStrategy >> appliesToNode: aNode [

	^ aNode isMethod
]

{ #category : 'accessing' }
MethodNameStrategy >> key [

	^ #methodName
]

{ #category : 'accessing' }
MethodNameStrategy >> permutationsForNode: aNode [

	| keywords |
	keywords := aNode selector count: [ :c | c = $: ].
	^ 1 to: keywords
]
