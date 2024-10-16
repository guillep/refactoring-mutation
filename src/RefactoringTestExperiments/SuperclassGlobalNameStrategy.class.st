Class {
	#name : 'SuperclassGlobalNameStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
SuperclassGlobalNameStrategy >> forNode: aNode and: aModel [

	^ { (aModel classNamed: aNode name) superclass name }
]
