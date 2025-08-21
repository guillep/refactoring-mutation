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

	| methods |
	methods := aNode methodClass superclass methods 
			select: [ :method | aNode numArgs + 1 = method numArgs ] 
			thenCollect: [ :method | method selector ].
	methods ifEmpty: [ ^ nil ].
	^ methods first
			
]

{ #category : 'running' }
SuperClassAdditionalArgMethodNameStrategy >> methodNameFor: aMutant [ 

	| methods |
	methods := aMutant data methodClass superclass methods 
			select: [ :method | aMutant data numArgs + 1 = method numArgs ] 
			thenCollect: [ :method | method selector ].
	methods ifEmpty: [ ^ nil ].
	^ methods first
			
]

{ #category : 'running' }
SuperClassAdditionalArgMethodNameStrategy >> permutationsFor: aMutant [ 

	^ (super permutationsFor: aMutant) asArray , #(-1)
]
