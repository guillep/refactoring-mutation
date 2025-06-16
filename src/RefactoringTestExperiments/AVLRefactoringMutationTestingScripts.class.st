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
		self configureLoggerFor: 'AVL-AddArg'.
		super runAddArgument ] ensure: [ logger close ]
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>

	super runCompositeExtractMethod
]

{ #category : 'coverage' }
AVLRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>

	super runExtractMethod 
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runInlineMethod [
	<script>

	super runInlineMethod 
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	
	super runRenameArgOrTemp 
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	
	super runRenameClass
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runRenameMethod [

	<script>
	[
		self configureLoggerFor: 'AIAlgorithms-RenameMethod'.
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
