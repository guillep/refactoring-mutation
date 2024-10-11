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
AVLRefactoringMutationTestingScripts class >> mutationPackageName [

	^ 'AVL-Tree'
]

{ #category : 'cleaning' }
AVLRefactoringMutationTestingScripts class >> reload [

	<script>
	super reload.
	"EpMonitor disableDuring: [
		["
		Metacello new
			baseline: 'AVLTree';
			repository: 'github://pharo-containers/AVL:main';
			load "] ]"
]

{ #category : 'accessing' }
AVLRefactoringMutationTestingScripts class >> repositoryName [ 

	^ 'AVL'
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runAddArgument [
	<script>

	super runAddArgument
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
AVLRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	
	super runRenameArgOrTemp 
]

{ #category : 'running' }
AVLRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	
	super runRenameClass
]

{ #category : 'accessing' }
AVLRefactoringMutationTestingScripts class >> testPackageName [

	^ 'AVL-Tree-Tests'
]
