Class {
	#name : 'NameWithSemicolonStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
NameWithSemicolonStrategy >> forNode: aNode and: aModel [

	^ { 'not;allowed' }
]
