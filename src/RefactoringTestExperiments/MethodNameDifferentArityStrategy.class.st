Class {
	#name : 'MethodNameDifferentArityStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
MethodNameDifferentArityStrategy >> forNode: aNode and: aRefactoring [

	^ aNode selector isBinary
		  ifTrue: [ #foo:foo: ]
		  ifFalse: [ aNode selector , 'foo:' ]
]
