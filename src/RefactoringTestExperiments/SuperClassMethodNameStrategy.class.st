Class {
	#name : 'SuperClassMethodNameStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
SuperClassMethodNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
SuperClassMethodNameStrategy >> forNode: aNode and: aModel [ 

	| methods |
	methods :=aNode methodClass superclass methods 
			select: [ :method | aNode numArgs = method numArgs and: [ aNode selector ~= method selector ] ] 
			thenCollect: [ :method | method selector ].
	methods ifEmpty: [ ^ nil ].
	^ methods first
]

{ #category : 'running' }
SuperClassMethodNameStrategy >> methodNameFor: aMutant [ 

	| methods |
	methods := aMutant data methodClass superclass methods 
			select: [ :method | aMutant data numArgs = method numArgs and: [ aMutant data selector ~= method selector ] ] 
			thenCollect: [ :method | method selector ].
	methods ifEmpty: [ ^ nil ].
	^ methods first
]
