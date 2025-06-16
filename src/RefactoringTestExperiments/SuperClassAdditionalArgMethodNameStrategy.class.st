Class {
	#name : 'SuperClassAdditionalArgMethodNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
SuperClassAdditionalArgMethodNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
SuperClassAdditionalArgMethodNameStrategy >> forNode: aNode and: aModel [ 

	^ aNode methodClass superclass methods 
			select: [ :method | aNode numArgs + 1 = method numArgs ] 
			thenCollect: [ :method | method selector ]
]
