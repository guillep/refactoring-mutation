Class {
	#name : 'MethodNameStrategy',
	#superclass : 'AbstractStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
MethodNameStrategy class >> invalidAddArgMethodNames [

	^ { 
		SameNameStrategy new .
		SuperClassAdditionalArgMethodNameStrategy new.
		SwapMethodArgumentsStrategy new.
		UniqueMethodNameStrategy new.
	 }
]

{ #category : 'as yet unclassified' }
MethodNameStrategy class >> invalidRenameMethodNames [

	^ { 
		MethodNameAdditionalArgumentStrategy new.
		MethodNameDifferentArityStrategy new.
		SameNameStrategy new.
		SuperClassMethodNameStrategy new.
		SwapMethodArgumentsStrategy new.
	}
]

{ #category : 'as yet unclassified' }
MethodNameStrategy class >> validAddArgMethodNames [

	^ { MethodNameAdditionalArgumentStrategy new }
]

{ #category : 'as yet unclassified' }
MethodNameStrategy class >> validRenameMethodNames [

	^ { UniqueMethodNameStrategy new }
]

{ #category : 'checking' }
MethodNameStrategy >> appliesToNode: aNode [

	^ aNode isMethod
]

{ #category : 'running' }
MethodNameStrategy >> forNode: aNode and: aModel [ 
	^ self subclassResponsibility
]

{ #category : 'accessing' }
MethodNameStrategy >> key [

	^ #methodName
]

{ #category : 'running' }
MethodNameStrategy >> methodNameFor: aMutant [ 
	^ self subclassResponsibility
]

{ #category : 'running' }
MethodNameStrategy >> permutationsFor: aMutant [

	| keywords |
	keywords := aMutant data selector count: [ :c | c = $: ].
	^ 1 to: keywords
]
