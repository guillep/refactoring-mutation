Class {
	#name : 'RefactoringMutationTestingScripts',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'as yet unclassified' }
RefactoringMutationTestingScripts class >> reloadMicrodown [

	EpMonitor disableDuring: [
		(IceRepository repositoryNamed: 'Microdown')
			ifNil: [ self inform: 'Project not found: ' , name ]
			ifNotNil: [ :found |
				found
					unload;
					forget ].
		[
		Metacello new
			baseline: 'Microdown';
			repository: 'github://Pillar-markup/Microdown:dev/src';
			onConflict: [ :e | e useIncoming ];
			onUpgrade: [ :e | e useIncoming ];
			ignoreImage;
			load: 'Tests' ]
			on: MCMergeOrLoadWarning
			do: [ :e | e load ] ]
]
