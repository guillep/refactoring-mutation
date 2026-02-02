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

	^ 'Foo', aMutant data name
]

{ #category : 'running' }
UniqueGlobalNameStrategy >> nameFor: aMutant and: model [

	^ 'UniqueNameInTheSystem'
]
