Class {
	#name : 'ExistingNonClassGlobalNameStrategy',
	#superclass : 'NameStrategy',
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
