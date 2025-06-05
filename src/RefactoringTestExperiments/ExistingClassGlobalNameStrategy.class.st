Class {
	#name : 'ExistingClassGlobalNameStrategy',
	#superclass : 'NameStrategy',
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

	^ { 'Object' }
]
