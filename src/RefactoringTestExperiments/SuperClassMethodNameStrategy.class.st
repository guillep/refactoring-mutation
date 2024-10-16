Class {
	#name : 'SuperClassMethodNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
SuperClassMethodNameStrategy >> forNode: aNode and: aRefactoring [ 

	^ aNode methodClass superclass methods 
			select: [ :method | aNode numArgs = method numArgs and: [ aNode selector ~= method selector ] ] 
			thenCollect: [ :method | method selector ]
]
