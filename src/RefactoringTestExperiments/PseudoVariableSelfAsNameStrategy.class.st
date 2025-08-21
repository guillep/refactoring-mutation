Class {
	#name : 'PseudoVariableSelfAsNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
PseudoVariableSelfAsNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
PseudoVariableSelfAsNameStrategy >> forNode: aNode and: aModel [

	^ 'self'
]
