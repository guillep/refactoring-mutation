Class {
	#name : 'ExistingTraitGlobalNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
ExistingTraitGlobalNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
ExistingTraitGlobalNameStrategy >> forNode: aNode and: aModel [

	^ { 'RBTDummy' }
]
