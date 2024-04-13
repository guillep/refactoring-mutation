Class {
	#name : 'BaselineOfRefactoringTestExperiments',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfRefactoringTestExperiments',
	#package : 'BaselineOfRefactoringTestExperiments'
}

{ #category : 'baselines' }
BaselineOfRefactoringTestExperiments >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec
				baseline: 'MuTalk'
				with: [ spec repository: 'github://pharo-contributions/mutalk/src' ].

			spec 
				package: 'RefactoringTestExperiments'
				with: [ spec requires: #('MuTalk') ]
				
		]
]
