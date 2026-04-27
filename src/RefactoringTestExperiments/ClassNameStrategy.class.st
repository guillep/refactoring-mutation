Class {
	#name : 'ClassNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'checking' }
ClassNameStrategy >> appliesToNode: aNode [

	^ aNode isVariable
]

{ #category : 'running' }
ClassNameStrategy >> forNode: aNode and: aModel [

	^ self subclassResponsibility 
]
