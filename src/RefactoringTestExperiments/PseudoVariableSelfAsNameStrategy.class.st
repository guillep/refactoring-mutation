Class {
	#name : 'PseudoVariableSelfAsNameStrategy',
	#superclass : 'VariableNameStrategy',
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

{ #category : 'running' }
PseudoVariableSelfAsNameStrategy >> tempNameFor: aMutant [

	^ 'self'
]
