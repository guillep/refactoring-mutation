Class {
	#name : 'ExistingClassGlobalNameStrategy',
	#superclass : 'ClassNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
ExistingClassGlobalNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
ExistingClassGlobalNameStrategy >> forNode: aNode and: aModel [

	^ 'Object'
]

{ #category : 'running' }
ExistingClassGlobalNameStrategy >> nameFor: aMutant [

	^ 'Object'
]

{ #category : 'running' }
ExistingClassGlobalNameStrategy >> nameFor: aMutant and: model [

	^ 'Object'
]

{ #category : 'running' }
ExistingClassGlobalNameStrategy >> tempNameFor: aMutant [

	^ 'Object'
]
