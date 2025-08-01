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
ArtefactRefactoringMutationTestingScripts class >> mutationPackageNames [ 

	^ { 'Artefact-Core' }
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

{ #category : 'accessing' }
ArtefactRefactoringMutationTestingScripts class >> repositoryNames [

	^ { 'Artefact' }
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runAddArgument [

	<script>
	[
		self configureCSVLoggerFor: 'Artefact-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
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
ArtefactRefactoringMutationTestingScripts class >> runInlineMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Artefact-InlineMethod'.
		super runInlineMethod ] ensure: [ logger close ]
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

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runRenameMethod [
	<script>
	
	super runRenameMethod 
]

{ #category : 'accessing' }
ArtefactRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'Artefact-Core-Tests' }
]
