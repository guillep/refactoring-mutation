Class {
	#name : 'ExistingNonClassGlobalNameStrategy',
	#superclass : 'ClassNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
ExistingNonClassGlobalNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
ExistingNonClassGlobalNameStrategy >> forNode: aNode and: aModel [

	^ 'SharedVarA'
]

{ #category : 'running' }
ExistingNonClassGlobalNameStrategy >> nameFor: aMutant [

	^ 'SharedVarA'
]

{ #category : 'running' }
ExistingNonClassGlobalNameStrategy >> nameFor: aMutant and: model [

	^ 'SharedVarA'
]

{ #category : 'running' }
ExistingNonClassGlobalNameStrategy >> tempNameFor: aMutant [

	^ 'SharedVarA'
]
