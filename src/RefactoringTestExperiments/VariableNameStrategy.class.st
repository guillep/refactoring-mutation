Class {
	#name : 'VariableNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'checking' }
VariableNameStrategy >> appliesToNode: aNode [

	^ aNode isVariable
]

{ #category : 'running' }
VariableNameStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]
