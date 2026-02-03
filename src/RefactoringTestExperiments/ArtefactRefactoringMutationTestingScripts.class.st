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
			repository: 'github://pharo-contributions/Artefact:0865285a1b21cac534ab3d3620d87b1b1c05c5aa/src';
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
ArtefactRefactoringMutationTestingScripts class >> runAll [

	<script>
	self runAddArgument.
	self runCompositeExtractMethod.
	self runExtractMethod.
	self runInlineMethod.
	self runRenameArgOrTemp.
	self runRenameClass.
	self runRenameMethod
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Artefact-CompositeExtractMethod'.
		super runCompositeExtractMethod ] ensure: [ logger close ]
]

{ #category : 'coverage' }
ArtefactRefactoringMutationTestingScripts class >> runCoverage [
	<script>

	super runCoverage
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runExtractMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Artefact-ExtractMethod'.
		super runExtractMethod ] ensure: [ logger close ]
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
	[
		self configureCSVLoggerFor: 'Artefact-RenameArgOrTemp'.
		super runRenameArgOrTemp ] ensure: [ logger close ]
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runRenameClass [

	<script>
	[
		self configureCSVLoggerFor: 'Artefact-RenameClass'.
		super runRenameClass ] ensure: [ logger close ]
]

{ #category : 'running' }
ArtefactRefactoringMutationTestingScripts class >> runRenameMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Artefact-RenameMEthod'.
		super runRenameMethod ] ensure: [ logger close ]
]

{ #category : 'accessing' }
ArtefactRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'Artefact-Core-Tests' }
]
