"
I am a helper class that just defines 'Microdown' as target project and defines delegate method that invoke scripts from my superclass.
"
Class {
	#name : 'SoupRefactoringMutationTestingScripts',
	#superclass : 'RefactoringMutationTestingScripts',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
SoupRefactoringMutationTestingScripts class >> mutationPackageNames [

	^ { 'Soup-Core' }
]

{ #category : 'cleaning' }
SoupRefactoringMutationTestingScripts class >> reload [

	<script>
	super reload.
	EpMonitor disableDuring: [
		Metacello new
			baseline: 'Soup';
			repository: 'github://pharo-contributions/Soup';
			load ]
]

{ #category : 'accessing' }
SoupRefactoringMutationTestingScripts class >> repositoryNames [ 

	^ { 'Soup' }
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runAddArgument [

	<script>
	[
		self configureCSVLoggerFor: 'Soup-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-CompositeExtractMethod'.
		super runCompositeExtractMethod ] ensure: [ logger close ]
]

{ #category : 'coverage' }
SoupRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-ExtractMethod'.
		super runExtractMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runInlineMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Soup-InlineMethod'.
		super runInlineMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-RenameArgOrTemp'.
		super runRenameArgOrTemp ] ensure: [ logger close ]
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-RenameClass'.
		super runRenameClass ] ensure: [ logger close ]
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runRenameMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-RenameMethod'.
		super runRenameMethod ] ensure: [ logger close ]
]

{ #category : 'accessing' }
SoupRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'Soup-Tests-Core' }
]

{ #category : 'cleaning' }
SoupRefactoringMutationTestingScripts class >> unloadAndForget [
	<script>
	
	super unloadAndForget 
]
