Class {
	#name : 'MethodNameDifferentArityStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
MethodNameDifferentArityStrategy >> forNode: aNode and: aRefactoring [

	^ { aNode selector isBinary
		  ifTrue: [ #foo:foo: ]
		  ifFalse: [ aNode selector , 'foo:' ] }
]
