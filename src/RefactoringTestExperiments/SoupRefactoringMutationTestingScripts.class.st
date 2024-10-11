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
SoupRefactoringMutationTestingScripts class >> mutationPackageName [

	^ 'Soup-Core'
]

{ #category : 'cleaning' }
SoupRefactoringMutationTestingScripts class >> reload [

	<script>
	super reload.
	"EpMonitor disableDuring: [
		["
		Metacello new
			baseline: 'Soup';
			repository: 'github://pharo-contributions/Soup';
			"] ]"load
]

{ #category : 'accessing' }
SoupRefactoringMutationTestingScripts class >> repositoryName [ 

	^ 'Soup'
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runAddArgument [
	<script>

	super runAddArgument
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>

	super runCompositeExtractMethod
]

{ #category : 'coverage' }
SoupRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>

	super runExtractMethod 
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	
	super runRenameArgOrTemp 
]

{ #category : 'running' }
SoupRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	
	super runRenameClass
]

{ #category : 'accessing' }
SoupRefactoringMutationTestingScripts class >> testPackageName [

	^ 'Soup-Tests-Core'
]

{ #category : 'cleaning' }
SoupRefactoringMutationTestingScripts class >> unloadAndForget [
	<script>
	
	super unloadAndForget 
]
