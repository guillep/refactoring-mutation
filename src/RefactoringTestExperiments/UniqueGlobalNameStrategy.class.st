Class {
	#name : 'UniqueGlobalNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
UniqueGlobalNameStrategy class >> isValidInput [ 

	^ true
]

{ #category : 'running' }
UniqueGlobalNameStrategy >> forNode: aNode and: aModel [

	^ { 'UniqueNameInTheSystem' }
]
