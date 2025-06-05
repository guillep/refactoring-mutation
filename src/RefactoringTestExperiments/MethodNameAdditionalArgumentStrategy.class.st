Class {
	#name : 'MethodNameAdditionalArgumentStrategy',
	#superclass : 'MethodNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
MethodNameAdditionalArgumentStrategy class >> isValidInput [ 

	^ true
]

{ #category : 'running' }
MethodNameAdditionalArgumentStrategy >> forNode: aNode and: aModel [

	^ { aNode selector , #foo: }
]
