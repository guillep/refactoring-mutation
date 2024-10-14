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

{ #category : 'running' }
RefactoringMutationTestingScripts class >> calculateRefactoringCoverageFor: refactoringsList [

	| testClasses classesToMutate analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: {
				InlineMethodMutationOperator new

		  }.

	collector := DTCoverageCollector new.
	collector methods: (refactoringsList flatCollect: [ :ref | ref methods ]).
	coverage := collector runOn: [ analysis run ].
	coverage inspect.
	
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
	Transcript traceCr: report.

	analysis generalResult inspect.
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> mutationPackageNames [ 

	^ self subclassResponsibility 
]

{ #category : 'cleaning' }
RefactoringMutationTestingScripts class >> reload [
	"Does first part of reload which is unload and forget the repository."

	self unloadAndForget 
]

{ #category : 'as yet unclassified' }
RefactoringMutationTestingScripts class >> repositoryNames [

	^ self subclassResponsibility 
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runAddArgument [

	| testClasses classesToMutate classEnvironment analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].
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
	
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	| testClasses classesToMutate classEnvironment analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].
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
	
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
]

{ #category : 'coverage' }
RefactoringMutationTestingScripts class >> runCoverage [
	"Calculate the coverage of the `mutationPackageName` running tests from `testPackageName`."

	| testClasses classesToMutate collector suite coverage |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: (classesToMutate flatCollect: [ :cls | cls methods ]).  "Configure with the methods to watch."
	suite := TestSuite named: self mutationPackageNames.
	suite addTests: (testClasses flatCollect: [ :cls | cls methods select: [ :m | m isTestMethod ] thenCollect: [ :m | cls selector: m selector ] ]).
	coverage := collector runOn: [ suite run ].  "Setup, execute and teardown."
	coverage inspect.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runExtractMethod [

	| testClasses classesToMutate classEnvironment analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].
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
	
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runInlineMethod [

	| testClasses classesToMutate analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].
	"We have to operate on the entire system since Inline Method depends on superclasses which can be Object, Collection, etc."
	"IF we scope it to a package or list of classes, that scope should include every superclass of every class that you want to inline."

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: {
				InlineMethodMutationOperator new

		  }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: (RBInlineMethodRefactoring methods).  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	coverage inspect.
	
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
	Transcript traceCr: report.
	
	"To inspect the results"
	analysis generalResult inspect.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameArgOrTemp [

	| testClasses classesToMutate classEnvironment analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: { 
		RenameArgumentOrTemporaryMutationOperator new
			classEnvironment: classEnvironment;
			sourceIntervalStrategy: NodeSourceIntervalStrategy new;
			nameStrategy: UniqueTempNameStrategy new .
		"RenameArgOrTempInvalidSourceMutationOperator new
			classEnvironment: classEnvironment;
			sourceIntervalStrategy: NegativeIntervalStrategy new;
			nameStrategy: UniqueTempNameStrategy new .
		RenameArgOrTempInvalidSourceMutationOperator new
			classEnvironment: classEnvironment;
			sourceIntervalStrategy: OutOfBoundsIntervalStrategy new;
			nameStrategy: UniqueTempNameStrategy new ."
		RenameArgOrTempInvalidSourceMutationOperator new
			classEnvironment: classEnvironment;
			sourceIntervalStrategy: NodeSourceIntervalStrategy new;
			nameStrategy: ExistingTempOrArgNameStrategy new .
		"RenameArgOrTempInvalidSourceMutationOperator new
			classEnvironment: classEnvironment;
			sourceIntervalStrategy: NodeSourceIntervalStrategy new;
			nameStrategy: NameWithSpaceStrategy new .
		RenameArgOrTempInvalidSourceMutationOperator new
			classEnvironment: classEnvironment;
			sourceIntervalStrategy: NodeSourceIntervalStrategy new;
			nameStrategy: PseudoVariableAsNameStrategy new ."
		  }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: RBRenameArgumentOrTemporaryRefactoring methods.  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."

	"To inspect the results"
	"analysis generalResult inspect."
	"678 mutants, 231 killed, 446 alive, 1 terminated. Mutation Score: 34%."
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
	Transcript traceCr: report.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameClass [

	| testClasses classesToMutate classEnvironment analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].
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
		
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameMethod [

	| testClasses classesToMutate classEnvironment analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: {
		"RenameMethodMutationOperator new
			classEnvironment: classEnvironment;
			nameStrategy: UniqueMethodNameStrategy new ."
		RenameMethodMutationOperator new
			classEnvironment: classEnvironment;
			nameStrategy: SwapMethodArgumentsStrategy new .
		"RenameMethodMutationOperator new
			classEnvironment: classEnvironment;
			nameStrategy: MethodNameDifferentArityStrategy new .
		RenameMethodMultipleNamesMutationOperator new
			classEnvironment: classEnvironment;
			nameStrategy: SuperClassMethodNameStrategy new ."

		  }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: (ReRenameMethodRefactoring methods , RBChangeMethodNameRefactoring methods).  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	coverage inspect.
	
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report previewCoverageInDrTests.
	Transcript traceCr: report.
	
	"To inspect the results"
	analysis generalResult inspect.
]

{ #category : 'tests' }
RefactoringMutationTestingScripts class >> testPackageNames [

	^ self subclassResponsibility 
]

{ #category : 'cleaning' }
RefactoringMutationTestingScripts class >> unloadAndForget [

	EpMonitor disableDuring: [
		self repositoryNames do: [ :repo |
		(IceRepository repositoryNamed: repo)
			ifNil: [ self inform: 'Project not found: ' , name ]
			ifNotNil: [ :found |
				found
					unload;
					forget ]
		]
	]
]
