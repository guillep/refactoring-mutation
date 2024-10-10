"
I am a helper class that just defines 'Artefact' as target project and defines delegate method that invoke scripts from my superclass.
"
Class {
	#name : 'ArtefactRefactoringMutationTestingScripts',
	#superclass : 'RefactoringMutationTestingScripts',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
ArtefactRefactoringMutationTestingScripts class >> mutationPackageName [ 

	^ 'Artefact-Core'
]

{ #category : 'cleaning' }
ArtefactRefactoringMutationTestingScripts class >> reload [
	<script>
	
	super reload.
	EpMonitor disableDuring: [
		[
		Metacello new
			baseline: 'Artefact';
			repository: 'github://pharo-contributions/Artefact:development/src';
			onConflict: [ :e | e useIncoming ];
			onUpgrade: [ :e | e useIncoming ];
			ignoreImage;
			load ]
			on: MCMergeOrLoadWarning
			do: [ :e | e load ] ]
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runAddArgument [
	<script>

	super runAddArgument
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>

	super runCompositeExtractMethod
]

{ #category : 'coverage' }
ArtefactRefactoringMutationTestingScripts class >> runCoverage [
	<script>

	super runCoverage
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>

	super runExtractMethod 
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	
	super runRenameArgOrTemp 
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runRenameClass [
	<script>

	super runRenameClass 
]

{ #category : 'accessing' }
ArtefactRefactoringMutationTestingScripts class >> testPackageName [

	^ 'Artefact-Core-Tests'
]
