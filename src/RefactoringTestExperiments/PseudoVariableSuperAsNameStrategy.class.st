Class {
	#name : 'PseudoVariableSuperAsNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
PseudoVariableSuperAsNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
PseudoVariableSuperAsNameStrategy >> forNode: aNode and: aModel [

	^ 'super'
]
