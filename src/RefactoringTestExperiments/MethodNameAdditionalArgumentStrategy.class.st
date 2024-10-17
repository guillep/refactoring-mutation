Class {
	#name : 'MethodNameAdditionalArgumentStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'running' }
MethodNameAdditionalArgumentStrategy >> forNode: aNode and: aModel [

	^ aNode selector , #foo:
]
