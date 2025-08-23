Class {
	#name : 'ClassNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'applying' }
ClassNameStrategy >> appliesToNode: aNode [

	^ aNode isVariable
]
