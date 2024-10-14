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
			load: 'Tests' ]
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

	super runAddArgument
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runCompositeExtractMethod [
	<script>

	super runCompositeExtractMethod
]

{ #category : 'coverage' }
MicrodownRefactoringMutationTestingScripts class >> runCoverage [
	<script>
	
	super runCoverage
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runExtractMethod [
	<script>

	super runExtractMethod 
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runInlineMethod [
	<script>

	super runInlineMethod 
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	
	super runRenameArgOrTemp 
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	
	super runRenameClass
]

{ #category : 'running' }
MicrodownRefactoringMutationTestingScripts class >> runRenameMethod [
	<script>
	
	super runRenameMethod 
]

{ #category : 'accessing' }
MicrodownRefactoringMutationTestingScripts class >> testPackageNames [

	^ { 'Microdown-Tests' }
]
