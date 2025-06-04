Class {
	#name : 'RefactoringCoverageScripts',
	#superclass : 'Object',
	#classInstVars : [
		'logger',
		'showResults'
	],
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'printing' }
RefactoringCoverageScripts class >> printCoverage: coverage on: aStream [

	aStream nextPut: Character space.
	aStream nextPutAll: 'Method coverage: '.
	aStream print:
		(100.0 * coverage methods size / coverage collector methods size)
			rounded.
	aStream nextPut: Character space.
	aStream nextPutAll: '% ('.
	aStream print: coverage methods size.
	aStream nextPutAll: '/'.
	aStream print: coverage collector methods size.
	aStream nextPutAll: ')'.
	aStream nextPut: Character space.
	aStream nextPutAll: 'Node Coverage: '.
	aStream print:
		(100.0 * coverage nodes size / coverage collector nodes size)
			rounded.
	aStream nextPutAll: '% ('.
	aStream print: coverage nodes size.
	aStream nextPutAll: '/'.
	aStream print: coverage collector nodes size.
	aStream nextPutAll: ')'.
	aStream cr.
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runAddArgumentCoverage [

	<script>
	logger nextPutAll: 'Add Argument(Parameter)'.
	self runCoverageFor: { RBAddParameterRefactoring } with: { RBAddParameterParametrizedTest }
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runCompositeExtractMethodCoverage [

	<script>
	logger nextPutAll: 'Composite Extract Method'.
	self 
		runCoverageFor: { ReCompositeExtractMethodRefactoring } 
		with: {
			ReSemanticsOfCompositeExtractMethodRefactoringTest.
			RBExtractMethodTransformationTest }
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runCoverageFor: refactoringClasses with: testClasses [

	| collector suite coverage |
	collector := DTCoverageCollector new. "Instantiate"
	collector methods: (refactoringClasses flatCollect: [ :cls | cls methods ]).  "Configure with the methods to watch."
	suite := TestSuite named: 'refactoring coverage'.
	suite addTests: (testClasses flatCollect: [ :cls | cls methods select: [ :m | m isTestMethod ] thenCollect: [ :m | cls selector: m selector ] ]).
	coverage := collector runOn: [ suite run ].  "Setup, execute and teardown."
	self printCoverage: coverage on: logger.
	showResults ifTrue: [ coverage inspect ]
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runCoverageForAll [

	<script>
	| file |
	file := FileReference fileSystem: FileSystem disk path: Path * 'RefactoringCoverage.log'.
	logger := file writeStream.
	showResults := false. "Don't open dialogs showing coverage and mutation results"
	self runAddArgumentCoverage.
	self runCompositeExtractMethodCoverage.
	self runExtractMethodCoverage.
	self runInlineMethodCoverage.
	self runRenameArgOrTempCoverage.
	self runRenameClassCoverage.
	self runRenameMethodCoverage.
	logger close.
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runExtractMethodCoverage [

	<script>
	logger nextPutAll: 'Extract Method'.
	self runCoverageFor: { RBExtractMethodRefactoring } with: { RBExtractMethodRefactoringTest }
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runInlineMethodCoverage [

	<script>
	logger nextPutAll: 'Inline Method'.
	self runCoverageFor: { RBInlineMethodRefactoring } with: { RBInlineMethodParametrizedTest }
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runRenameArgOrTempCoverage [

	<script>
	logger nextPutAll: 'Rename Argument or Temporary'.
	self runCoverageFor: { RBRenameArgumentOrTemporaryRefactoring } with: { RBRenameTemporaryParametrizedTest }
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runRenameClassCoverage [

	<script>
	logger nextPutAll: 'Rename Class'.
	self runCoverageFor: { ReRenameClassRefactoring } with: { RBRenameClassRefactoringTest }
]

{ #category : 'running' }
RefactoringCoverageScripts class >> runRenameMethodCoverage [

	<script>
	logger nextPutAll: 'Rename Method'.
	self runCoverageFor: { ReRenameMethodRefactoring } with: { RBRenameMethodRefactoringTest . RBRenameMethodParametrizedTest }
]
