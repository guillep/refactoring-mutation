Class {
	#name : 'UniqueGlobalNameStrategy',
	#superclass : 'ClassNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
UniqueGlobalNameStrategy class >> isValidInput [ 

	^ true
]

{ #category : 'running' }
UniqueGlobalNameStrategy >> forNode: aNode and: aModel [

	^ 'UniqueNameInTheSystem'
]

{ #category : 'running' }
UniqueGlobalNameStrategy >> nameFor: aMutant [

	^ 'UniqueNameInTheSystem'
]

{ #category : 'running' }
UniqueGlobalNameStrategy >> nameFor: aMutant and: model [

	^ 'UniqueNameInTheSystem'
]
