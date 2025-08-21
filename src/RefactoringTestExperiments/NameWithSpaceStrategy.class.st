Class {
	#name : 'NameWithSpaceStrategy',
	#superclass : 'NameStrategy',
	#category : 'RefactoringTestExperiments-Strategy',
	#package : 'RefactoringTestExperiments',
	#tag : 'Strategy'
}

{ #category : 'testing' }
NameWithSpaceStrategy class >> isValidInput [ 

	^ false
]

{ #category : 'running' }
NameWithSpaceStrategy >> forNode: aNode and: aModel [

	^ 'should not pass'
]
