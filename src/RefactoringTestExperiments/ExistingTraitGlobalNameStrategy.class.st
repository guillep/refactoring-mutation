Class {
	#name : 'ExistingTraitGlobalNameStrategy',
	#superclass : 'ClassNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
ExistingTraitGlobalNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
ExistingTraitGlobalNameStrategy >> forNode: aNode and: aModel [

	^ 'RBTDummy'
]

{ #category : 'running' }
ExistingTraitGlobalNameStrategy >> nameFor: aMutant [

	^ 'RBTDummy'
]

{ #category : 'running' }
ExistingTraitGlobalNameStrategy >> nameFor: aMutant and: model [

	^ 'RBTDummy'
]

{ #category : 'running' }
ExistingTraitGlobalNameStrategy >> tempNameFor: aMutant [

	^ 'RBTDummy'
]
