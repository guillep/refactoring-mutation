Class {
	#name : 'ExistingNonClassGlobalNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
ExistingNonClassGlobalNameStrategy >> forNode: aNode and: aModel [

	^ { 'SharedVarA' }
]
