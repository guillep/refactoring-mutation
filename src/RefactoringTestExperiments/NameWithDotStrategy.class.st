Class {
	#name : 'NameWithDotStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
NameWithDotStrategy >> forNode: aNode and: aModel [

	^ { 'not.allowed' }
]
