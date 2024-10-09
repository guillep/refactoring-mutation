Class {
	#name : 'RefactoringMutationTestingScripts',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'coverage' }
RefactoringMutationTestingScripts class >> previewCoverageInDrTests: coverage [

	| dr result notExecuted methodsSize |
	dr := DrTests open.
	dr pluginsDropList selectIndex: 2.
	dr currentPlugin: (dr pluginsDropList selectedItem new).
	result := DTTestCoverageResult new.
	notExecuted := coverage uncoveredMethods.
	methodsSize := coverage methods size + coverage uncoveredMethods size.
	result
		percent: 1s2 - (notExecuted size / methodsSize asScaledDecimal: 2);
		methodList: notExecuted;
		partiallyCoveredMethods: coverage partiallyCoveredMethods.
	dr pluginResult: result.
	dr updateWithPluginResult: result.
]

{ #category : 'cleaning' }
RefactoringMutationTestingScripts class >> reloadMicrodown [

	EpMonitor disableDuring: [
		(IceRepository repositoryNamed: 'Microdown')
			ifNil: [ self inform: 'Project not found: ' , name ]
			ifNotNil: [ :found |
				found
					unload;
					forget ].
		[
		Metacello new
			baseline: 'Microdown';
			repository: 'github://Pillar-markup/Microdown:dev/src';
			onConflict: [ :e | e useIncoming ];
			onUpgrade: [ :e | e useIncoming ];
			ignoreImage;
			load: 'Tests' ]
			on: MCMergeOrLoadWarning
			do: [ :e | e load ] ]
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runAddArgument [
	<script>
	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reloadMicrodown.
	testClasses := ((PackageOrganizer default packageNamed: 'Microdown-Tests') definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: 'Microdown') definedClasses reject: [ :cls | cls isManifest ]) asArray.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: { AddArgumentMutationOperator new classEnvironment: classEnvironment }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: RBAddParameterRefactoring methods.  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	coverage inspect.
	"a DTCoverageResult methods: 8 (67%) nodes: 18 (45%)"

	"To inspect the results"
	analysis generalResult inspect.
	"596 mutants, 19 killed, 577 alive, 0 terminated. Mutation Score: 3%."
	
	self previewCoverageInDrTests: coverage
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameArgOrTemp [
	<script>
	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reloadMicrodown.
	testClasses := ((PackageOrganizer default packageNamed: 'Microdown-Tests') definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: 'Microdown') definedClasses reject: [ :cls | cls isManifest ]) asArray.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: { RenameArgumentOrTemporaryMutationOperator new classEnvironment: classEnvironment }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: RBRenameArgumentOrTemporaryRefactoring methods.  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	coverage inspect.
	" a DTCoverageResult methods: 8 (67%) nodes: 20 (50%)"

	"To inspect the results"
	analysis generalResult inspect.
	"678 mutants, 231 killed, 446 alive, 1 terminated. Mutation Score: 34%."
	self previewCoverageInDrTests: coverage.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameClass [
	<script>
	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reloadMicrodown.
	testClasses := ((PackageOrganizer default packageNamed: 'Microdown-Tests') definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: 'Microdown') definedClasses reject: [ :cls | cls isManifest ]) asArray.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: { RenameClassMutationOperator new classEnvironment: classEnvironment }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: ReRenameClassRefactoring methods.  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	coverage inspect.
	" a DTCoverageResult methods: 8 (67%) nodes: 20 (50%)"

	"To inspect the results"
	analysis generalResult inspect.
	"678 mutants, 231 killed, 446 alive, 1 terminated. Mutation Score: 34%."
	self previewCoverageInDrTests: coverage.
]
