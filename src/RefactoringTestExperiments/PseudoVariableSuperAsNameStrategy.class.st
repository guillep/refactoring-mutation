Class {
	#name : 'PseudoVariableSuperAsNameStrategy',
	#superclass : 'VariableNameStrategy',
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

{ #category : 'running' }
PseudoVariableSuperAsNameStrategy >> tempNameFor: aMutant [

	^ 'super'
]
