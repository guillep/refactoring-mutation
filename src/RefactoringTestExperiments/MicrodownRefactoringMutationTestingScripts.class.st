"
I am a helper class that just defines 'Microdown' as target project and defines delegate method that invoke scripts from my superclass.
"
Class {
	#name : 'MicrodownRefactoringMutationTestingScripts',
	#superclass : 'RefactoringMutationTestingScripts',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
MicrodownRefactoringMutationTestingScripts class >> mutationPackageNames [

	^ { 'Microdown' }
]

{ #category : 'cleaning' }
MicrodownRefactoringMutationTestingScripts class >> reload [
	<script>

	super reload.
	EpMonitor disableDuring: [
		[
		Metacello new
			baseline: 'Microdown';
			repository: 'github://Pillar-markup/Microdown:dev/src';
			onConflict: [ :e | e useIncoming ];
			onUpgrade: [ :e | e useIncoming ];
			ignoreImage;
			load: 'Microdown-Tests' ]
			on: MCMergeOrLoadWarning
			do: [ :e | e load ] ].
	BeautifulComments class compile: 'renderComment: aString of: aClassOrPackage 

    ^ aString' classified: #rendering.
]

{ #category : 'accessing' }
MicrodownRefactoringMutationTestingScripts class >> repositoryNames [ 

	^ { 'Microdown' }
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runAddArgument [

	<script>
	[
		self configureCSVLoggerFor: 'Microdown-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runAll [

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
MicrodownRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Microdown-CompositeExtractMethod'.
		super runCompositeExtractMethod ] ensure: [ logger close ]
]

{ #category : 'coverage' }
MicrodownRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Microdown-ExtractMethod'.
		super runExtractMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runInlineMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Microdown-InlineMethod'.
		super runInlineMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	[
		self configureCSVLoggerFor: 'Microdown-RenameArgOrTemp'.
		super runRenameArgOrTemp ] ensure: [ logger close ]
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	[
		self configureCSVLoggerFor: 'Microdown-RenameClass'.
		super runRenameClass ] ensure: [ logger close ]
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runRenameMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Microdown-RenameMethod'.
		super runRenameMethod ] ensure: [ logger close ]
]

{ #category : 'accessing' }
MicrodownRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'Microdown-Tests' }
]

{ #category : 'cleaning' }
MicrodownRefactoringMutationTestingScripts class >> unloadAndForget [
	<script>
	super unloadAndForget 
]
