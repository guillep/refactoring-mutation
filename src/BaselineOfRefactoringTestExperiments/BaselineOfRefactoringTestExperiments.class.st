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
				with: [ spec repository: 'github://balsa-sarenac/mutalk:c4ad8eb459aed6d768ad8e2c698ceb078d0a8b87/src' ].

			spec 
				package: 'RefactoringTestExperiments'
				with: [ spec requires: #('MuTalk') ]
				
		]
]
