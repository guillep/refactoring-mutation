"
I am a helper class that just defines 'Microdown' as target project and defines delegate method that invoke scripts from my superclass.
"
Class {
	#name : 'AIAlgorithmsRefactoringMutationTestingScripts',
	#superclass : 'RefactoringMutationTestingScripts',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
AIAlgorithmsRefactoringMutationTestingScripts class >> mutationPackageNames [

	^ { 'AI-Algorithms-Graph' }
]

{ #category : 'cleaning' }
AIAlgorithmsRefactoringMutationTestingScripts class >> reload [

	<script>
	super reload.
	EpMonitor disableDuring: [
		Metacello new
			repository: 'github://pharo-ai/graph-algorithms';
			baseline: 'AIGraphAlgorithms';
			load ]
]

{ #category : 'accessing' }
AIAlgorithmsRefactoringMutationTestingScripts class >> repositoryNames [ 

	^ { 'graph-algorithms' }
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runAddArgument [

	<script>
	[
		self configureCSVLoggerFor: 'AIAlgs-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runAll [

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
AIAlgorithmsRefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	<script>
	[
		self configureCSVLoggerFor: 'AIAlgs-CompositeEM'.
		super runCompositeExtractMethod ] ensure: [ logger close ]
]

{ #category : 'coverage' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runExtractMethod [

	<script>
	[
		self configureCSVLoggerFor: 'AIAlgs-ExtractMethod'.
		super runExtractMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runInlineMethod [

	<script>
	[
		self configureCSVLoggerFor: 'AIAlgs-InlineMethod'.
		super runInlineMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runRenameArgOrTemp [

	<script>
	[
		self configureCSVLoggerFor: 'AIAlgs-RenameArgOrTemp'.
		super runRenameArgOrTemp ] ensure: [ logger close ]
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runRenameClass [

	<script>
	[
		self configureCSVLoggerFor: 'AIAlgs-RenameClass'.
		super runRenameClass ] ensure: [ logger close ]
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runRenameMethod [

	<script>
	[
		self configureCSVLoggerFor: 'AIAlgs-RenameMethod'.
		super runRenameMethod ] ensure: [ logger close ]
]

{ #category : 'accessing' }
AIAlgorithmsRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'AI-Algorithms-Graph-Tests' }
]

{ #category : 'cleaning' }
AIAlgorithmsRefactoringMutationTestingScripts class >> unloadAndForget [
	<script>
	
	super unloadAndForget 
]
