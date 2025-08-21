Class {
	#name : 'SwapMethodArgumentsStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
SwapMethodArgumentsStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
SwapMethodArgumentsStrategy >> forNode: aNode and: aRefactoring [

	^ aNode numArgs >= 2
		ifTrue: [ | node| node := aNode copy. ('' join: (node selectorParts swap: 1 with: 2)) asSymbol ]
		ifFalse: [ nil ]
]

{ #category : 'running' }
SwapMethodArgumentsStrategy >> methodNameFor: aMutant [

	^ aMutant data numArgs >= 2
		ifTrue: [ | node| node := aMutant data copy. ('' join: (node selectorParts swap: 1 with: 2)) asSymbol ]
		ifFalse: [ nil ]
]
