Class {
	#name : 'SuperclassGlobalNameStrategy',
	#superclass : 'NameStrategy',
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
