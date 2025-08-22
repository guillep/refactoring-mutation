Class {
	#name : 'SuperclassGlobalNameStrategy',
	#superclass : 'ClassNameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
SuperclassGlobalNameStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'applying' }
SuperclassGlobalNameStrategy >> appliesToNode: aNode [

	^ aNode isGlobalVariable 
]

{ #category : 'running' }
SuperclassGlobalNameStrategy >> forNode: aNode and: aModel [

	| superclass |
	superclass := aModel classNamed: aNode name.
	^ (superclass
		   ifNotNil: [
				   superclass superclass
					   ifNotNil: [ superclass superclass name ]
					   ifNil: [ nil ] ]
		   ifNil: [ nil ])
]

{ #category : 'running' }
SuperclassGlobalNameStrategy >> nameFor: aMutant [

	| superclass |
	superclass := aMutant data classNamed: aMutant data name.
	^ (superclass
		   ifNotNil: [
				   superclass superclass
					   ifNotNil: [ superclass superclass name ]
					   ifNil: [ nil ] ]
		   ifNil: [ nil ])
]

{ #category : 'running' }
SuperclassGlobalNameStrategy >> nameFor: aMutant and: model [

	| superclass |
	superclass := model classNamed: aMutant data name.
	^ (superclass
		   ifNotNil: [
				   superclass superclass
					   ifNotNil: [ superclass superclass name ]
					   ifNil: [ nil ] ]
		   ifNil: [ nil ])
]

{ #category : 'running' }
SuperclassGlobalNameStrategy >> tempNameFor: aMutant [

	| superclass |
	superclass := aMutant data classNamed: aMutant data name.
	^ (superclass
		   ifNotNil: [
				   superclass superclass
					   ifNotNil: [ superclass superclass name ]
					   ifNil: [ nil ] ]
		   ifNil: [ nil ])
]
