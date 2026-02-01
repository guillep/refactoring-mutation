"
I am a helper class that just defines 'Microdown' as target project and defines delegate method that invoke scripts from my superclass.
"
Class {
	#name : 'GraphAlgorithmsRefactoringMutationTestingScripts',
	#superclass : 'RefactoringMutationTestingScripts',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> mutationPackageNames [

	^ { 'AI-Algorithms-Graph' }
]

{ #category : 'cleaning' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> reload [

	<script>
	super reload.
	EpMonitor disableDuring: [
		Metacello new
			repository: 'github://pharo-ai/graph-algorithms';
			baseline: 'AIGraphAlgorithms';
			load ]
]

{ #category : 'accessing' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> repositoryNames [ 

	^ { 'graph-algorithms' }
]

{ #category : 'running' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runAddArgument [

	<script>
	[
		self configureCSVLoggerFor: 'GraphAlgs-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
]

{ #category : 'running' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runAll [

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
GraphAlgorithmsRefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	<script>
	[
		self configureCSVLoggerFor: 'GraphAlgs-CompositeEM'.
		super runCompositeExtractMethod ] ensure: [ logger close ]
]

{ #category : 'coverage' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runExtractMethod [

	<script>
	[
		self configureCSVLoggerFor: 'GraphAlgs-ExtractMethod'.
		super runExtractMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runInlineMethod [

	<script>
	[
		self configureCSVLoggerFor: 'GraphAlgs-InlineMethod'.
		super runInlineMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runRenameArgOrTemp [

	<script>
	[
		self configureCSVLoggerFor: 'GraphAlgs-RenameArgOrTemp'.
		super runRenameArgOrTemp ] ensure: [ logger close ]
]

{ #category : 'running' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runRenameClass [

	<script>
	[
		self configureCSVLoggerFor: 'GraphAlgs-RenameClass'.
		super runRenameClass ] ensure: [ logger close ]
]

{ #category : 'running' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> runRenameMethod [

	<script>
	[
		self configureCSVLoggerFor: 'GraphAlgs-RenameMethod'.
		super runRenameMethod ] ensure: [ logger close ]
]

{ #category : 'accessing' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'AI-Algorithms-Graph-Tests' }
]

{ #category : 'cleaning' }
GraphAlgorithmsRefactoringMutationTestingScripts class >> unloadAndForget [
	<script>
	
	super unloadAndForget 
]
