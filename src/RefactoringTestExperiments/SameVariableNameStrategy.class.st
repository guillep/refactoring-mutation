Class {
	#name : 'SameVariableNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
SameVariableNameStrategy >> forNode: aNode and: aModel [

	^ { aNode name }
]
