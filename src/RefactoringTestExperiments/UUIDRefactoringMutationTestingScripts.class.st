"
I am a helper class that just defines 'Microdown' as target project and defines delegate method that invoke scripts from my superclass.
"
Class {
	#name : 'UUIDRefactoringMutationTestingScripts',
	#superclass : 'RefactoringMutationTestingScripts',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
UUIDRefactoringMutationTestingScripts class >> mutationPackageNames [

	^ { 'Network-UUID' }
]

{ #category : 'cleaning' }
UUIDRefactoringMutationTestingScripts class >> reload [

	<script>
	
]

{ #category : 'accessing' }
UUIDRefactoringMutationTestingScripts class >> repositoryNames [ 

	^ {  }
]

{ #category : 'running' }
UUIDRefactoringMutationTestingScripts class >> runAddArgument [

	<script>
	[
		self configureCSVLoggerFor: 'Soup-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
]

{ #category : 'running' }
UUIDRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-CompositeExtractMethod'.
		super runCompositeExtractMethod ] ensure: [ logger close ]
]

{ #category : 'coverage' }
UUIDRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
UUIDRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-ExtractMethod'.
		super runExtractMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
UUIDRefactoringMutationTestingScripts class >> runInlineMethod [

	<script>
	[
		self configureCSVLoggerFor: 'Soup-InlineMethod'.
		super runInlineMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
UUIDRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-RenameArgOrTemp'.
		super runRenameArgOrTemp ] ensure: [ logger close ]
]

{ #category : 'running' }
UUIDRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-RenameClass'.
		super runRenameClass ] ensure: [ logger close ]
]

{ #category : 'running' }
UUIDRefactoringMutationTestingScripts class >> runRenameMethod [
	<script>
	[
		self configureCSVLoggerFor: 'Soup-RenameMethod'.
		super runRenameMethod ] ensure: [ logger close ]
]

{ #category : 'accessing' }
UUIDRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'Network-Tests' }
]

{ #category : 'cleaning' }
UUIDRefactoringMutationTestingScripts class >> unloadAndForget [
	<script>
	
	super unloadAndForget 
]
