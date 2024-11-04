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

	super runAddArgument
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>

	super runCompositeExtractMethod
]

{ #category : 'coverage' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>

	super runExtractMethod 
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runInlineMethod [
	<script>

	super runInlineMethod 
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	
	super runRenameArgOrTemp 
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	
	super runRenameClass
]

{ #category : 'running' }
AIAlgorithmsRefactoringMutationTestingScripts class >> runRenameMethod [
	<script>
	
	super runRenameMethod 
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
