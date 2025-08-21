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

	^ aNode selector , #foo:
]

{ #category : 'as yet unclassified' }
MethodNameAdditionalArgumentStrategy >> methodNameFor: aMutant [

	^ aMutant data selector , #foo:
]

{ #category : 'as yet unclassified' }
MethodNameAdditionalArgumentStrategy >> permutationsFor: aMutant [

	^ (super permutationsFor: aMutant) asArray , #(-1)
]
