Class {
	#name : 'VariableNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'applying' }
VariableNameStrategy >> appliesToNode: aNode [

	^ aNode isVariable
]
