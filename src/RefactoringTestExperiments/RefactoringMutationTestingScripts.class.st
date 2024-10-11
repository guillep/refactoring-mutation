"
I am a class that contains helpful tests while performing mutation testing of refactorings.

You should not use me directly, but instead you should call scripts defined in my subclasses.

In order to run the scripts from subclasses you will need to define:

- `mutationPackageName` - name of the package that you want to mutate
- `testPackageName` - name of the package that contains tests that you wish to run when doing mutation testing

Look at my subclasses to see how are they configured to run mutation tests for specific projects.

The easiest way to test a new project is to Duplicate one of my existing subclasses and redefine above mentioned methods.
You can invoke Duplicate class refactoring by doing right click on the class -> Refactorings -> Duplicate class.
"
Class {
	#name : 'RefactoringMutationTestingScripts',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> mutationPackageName [ 

	^ self subclassResponsibility 
]

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
	result inspect.
]

{ #category : 'cleaning' }
RefactoringMutationTestingScripts class >> reload [
	"Does first part of reload which is unload and forget the repository."

	self unloadAndForget 
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> repositoryName [ 

	^ self subclassResponsibility 
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runAddArgument [

	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reload.
	testClasses := ((PackageOrganizer default packageNamed: self testPackageName) definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: self mutationPackageName) definedClasses reject: [ :cls | cls isManifest ]) asArray.
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
RefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reload.
	testClasses := ((PackageOrganizer default packageNamed: self testPackageName) definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: self mutationPackageName ) definedClasses reject: [ :cls | cls isManifest ]) asArray.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
					  budget: (MTPercentageOfMutantsBudget for: 5);
		            operators: { CompositeExtractMethodMutationOperator new classEnvironment: classEnvironment }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: ReCompositeExtractMethodRefactoring methods.  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	coverage inspect.
	"a DTCoverageResult methods: 8 (67%) nodes: 18 (45%)"

	"To inspect the results"
	analysis generalResult inspect.
	"596 mutants, 19 killed, 577 alive, 0 terminated. Mutation Score: 3%."
	self previewCoverageInDrTests: coverage.
]

{ #category : 'coverage' }
RefactoringMutationTestingScripts class >> runCoverage [
	"Calculate the coverage of the `mutationPackageName` running tests from `testPackageName`."

	| testClasses classesToMutate collector suite coverage |
	testClasses := ((PackageOrganizer default packageNamed: self testPackageName) definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: self mutationPackageName ) definedClasses reject: [ :cls | cls isManifest ]) asArray.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: (classesToMutate flatCollect: [ :cls | cls methods ]).  "Configure with the methods to watch."
	suite := TestSuite named: self mutationPackageName.
	suite addTests: (testClasses flatCollect: [ :cls | cls selectors collect: [ :sel | cls selector: sel ] ]).
	coverage := collector runOn: [ suite run ].  "Setup, execute and teardown."
	coverage inspect.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runExtractMethod [

	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reload.
	testClasses := ((PackageOrganizer default packageNamed: self testPackageName) definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: self mutationPackageName) definedClasses reject: [ :cls | cls isManifest ]) asArray.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: { ExtractMethodMutationOperator new classEnvironment: classEnvironment" .
									 ExtractMethodNoPreconditionMutationOperator new classEnvironment: classEnvironment" }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: RBExtractMethodRefactoring methods.  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	coverage inspect.
	"a DTCoverageResult methods: 8 (67%) nodes: 18 (45%)"

	"To inspect the results"
	analysis generalResult inspect.
	"596 mutants, 19 killed, 577 alive, 0 terminated. Mutation Score: 3%."
	self previewCoverageInDrTests: coverage.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameArgOrTemp [

	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reload.
	testClasses := ((PackageOrganizer default packageNamed: self testPackageName) definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: self mutationPackageName) definedClasses reject: [ :cls | cls isManifest ]) asArray.
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

	| testClasses classesToMutate classEnvironment analysis collector coverage |
	self reload.
	testClasses := ((PackageOrganizer default packageNamed: self testPackageName ) definedClasses select: [ :cls | cls isTestCase ]) asArray.
	classesToMutate := ((PackageOrganizer default packageNamed: self mutationPackageName ) definedClasses reject: [ :cls | cls isManifest ]) asArray.
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

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> testPackageName [ 

	^ self subclassResponsibility 
]

{ #category : 'cleaning' }
RefactoringMutationTestingScripts class >> unloadAndForget [

	(IceRepository repositoryNamed: self repositoryName)
		ifNil: [ self inform: 'Project not found: ' , name ]
		ifNotNil: [ :found |
			found
				unload;
				forget ]
]
