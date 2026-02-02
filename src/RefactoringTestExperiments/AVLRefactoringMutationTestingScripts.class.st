"
I am a helper class that just defines 'Microdown' as target project and defines delegate method that invoke scripts from my superclass.
"
Class {
	#name : 'AVLRefactoringMutationTestingScripts',
	#superclass : 'RefactoringMutationTestingScripts',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
AVLRefactoringMutationTestingScripts class >> mutationPackageNames [

	^ { 'Containers-AVL-Tree' }
]

{ #category : 'cleaning' }
AVLRefactoringMutationTestingScripts class >> reload [

	<script>
	super reload.
	EpMonitor disableDuring: [
		Metacello new
  			baseline: 'ContainersAVLTree';
  			repository: 'github://pharo-containers/AVL:main';
  			load ]
]

{ #category : 'accessing' }
AVLRefactoringMutationTestingScripts class >> repositoryNames [

	^ { 'AVL' }
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runAddArgument [

	<script>
	[
		self configureCSVLoggerFor: 'AVL-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runAll [

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
AVLRefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	<script>
	[
		self configureCSVLoggerFor: 'AVL-CompositeExtractMethod'.
		super runCompositeExtractMethod ] ensure: [ logger close ]
]

{ #category : 'coverage' }
AVLRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>
	[
		self configureCSVLoggerFor: 'AVL-ExtractMethod'.
		super runExtractMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runInlineMethod [

	<script>
	[
		self configureCSVLoggerFor: 'AVL-InlineMethod'.
		super runInlineMethod ] ensure: [ logger close ]
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	[
		self configureCSVLoggerFor: 'AVL-RenameArgOrTemp'.
		super runRenameArgOrTemp ] ensure: [ logger close ]
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	[
		self configureCSVLoggerFor: 'AVL-RenameClass'.
		super runRenameClass ] ensure: [ logger close ]
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runRenameMethod [

	<script>
	[
		self configureCSVLoggerFor: 'AVL-RenameMethod'.
		super runRenameMethod ] ensure: [ logger close ]
]

{ #category : 'accessing' }
AVLRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'Containers-AVL-Tree-Tests' }
]

{ #category : 'cleaning' }
AVLRefactoringMutationTestingScripts class >> unloadAndForget [ 
	<script>
	
	super unloadAndForget 
]
