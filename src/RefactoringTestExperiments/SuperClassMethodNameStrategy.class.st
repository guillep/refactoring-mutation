Class {
	#name : 'SuperClassMethodNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'as yet unclassified' }
SuperClassMethodNameStrategy >> forNode: aMethodNode with: aRBNamespace [ 

	^ aMethodNode methodClass superclass methods 
			select: [ :method | aMethodNode numArgs = method numArgs and: [ aMethodNode selector ~= method selector ] ] 
			thenCollect: [ :method | method selector ]
]
