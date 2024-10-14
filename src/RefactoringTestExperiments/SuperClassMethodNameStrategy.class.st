Class {
	#name : 'SuperClassMethodNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
SuperClassMethodNameStrategy >> forNode: aNode and: aRefactoring [ 

	^ self forNode: aNode with: aRefactoring model
]

{ #category : 'as yet unclassified' }
SuperClassMethodNameStrategy >> forNode: aMethodNode with: aRBNamespace [ 

	^ aMethodNode methodClass superclass methods 
			select: [ :method | aMethodNode numArgs = method numArgs and: [ aMethodNode selector ~= method selector ] ] 
			thenCollect: [ :method | method selector ]
]
