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
RefactoringMutationTestingScripts class >> calculateRefactoringCoverageFor: refactoringsList using: operators [

	| testClasses classesToMutate analysis collector coverage report |
	self reload.
	testClasses := self testPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses select: [ :cls | cls isTestCase ])].
	classesToMutate := self mutationPackageNames flatCollect: [ :package | ((PackageOrganizer default packageNamed: package) definedClasses reject: [ :cls | cls isManifest ])].

	analysis := MTAnalysis new
		            classesToMutate: classesToMutate;
		            testClasses: testClasses;
		            operators: operators.

	"Calculate coverage of refactoring code while running mutation testing."
	collector := DTCoverageCollector new.
	collector methods: (refactoringsList flatCollect: [ :ref | ref methods ]).
	coverage := collector runOn: [ analysis run ].
	
	report := RefactoringMutationReport new mutationAnalysis: analysis; coverage: coverage.
	report mutationAnalysis generalResult inspect.
	report coverage inspect.
	^ report
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> classesToMutate [

	^ self mutationPackageNames flatCollect: [ :package |
		  (PackageOrganizer default packageNamed: package) definedClasses
			  reject: [ :cls | cls isManifest ] ]
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

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> repositoryNames [

	^ self subclassResponsibility 
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runAddArgument [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	operators := { 
		AddArgumentMutationOperator new 
			classEnvironment: classEnvironment;
			strategies: { 
				MethodNameAdditionalArgumentStrategy new .
				AddArgumentPermutationsStrategy new .
			 }.
		AddArgumentMutationOperator new 
			classEnvironment: classEnvironment;
			strategies: { "good name bad permutations"
				MethodNameAdditionalArgumentStrategy new .
				NoPermutationsStrategy new .
				SwapFirstTwoPermutationStrategy new .
			 } .
		AddArgumentMutationOperator new 
			classEnvironment: classEnvironment;
			strategies: { "good permutations bad name"
				SameNameStrategy new .
				SuperClassMethodNameStrategy new .
				SwapMethodArgumentsStrategy new .
				UniqueMethodNameStrategy new .
				AddArgumentPermutationsStrategy new .
			} 
	}.

	report := self calculateRefactoringCoverageFor: { RBAddParameterRefactoring } using: operators .
	report previewCoverageInDrTests.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	operators := { CompositeExtractMethodMutationOperator new  
		classEnvironment: classEnvironment;
		strategies: {
			EmptyIntervalStrategy new .
			NegativeIntervalStrategy new .
			OutOfBoundsIntervalStrategy new .
		} .
		CompositeExtractMethodMutationOperator new 
			classEnvironment: classEnvironment;
			strategies: {
				MultipleNodeIntervalsStrategy new offset: 2.
			} .
		CompositeExtractMethodMutationOperator new 
			classEnvironment: classEnvironment;
			strategies: {
				NodeSourceIntervalStrategy new .
			}
	}.

	report := self calculateRefactoringCoverageFor: { ReCompositeExtractMethodRefactoring } using: operators .
	report previewCoverageInDrTests.
]

{ #category : 'coverage' }
RefactoringMutationTestingScripts class >> runCoverage [
	"Calculate the coverage of the `mutationPackageName` running tests from `testPackageName`."

	| testClasses classesToMutate collector suite coverage |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: (classesToMutate flatCollect: [ :cls | cls methods ]).  "Configure with the methods to watch."
	suite := TestSuite named: self mutationPackageNames.
	suite addTests: (testClasses flatCollect: [ :cls | cls methods select: [ :m | m isTestMethod ] thenCollect: [ :m | cls selector: m selector ] ]).
	coverage := collector runOn: [ suite run ].  "Setup, execute and teardown."
	coverage inspect.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runExtractMethod [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	operators := { ExtractMethodNoPreconditionMutationOperator new 
		classEnvironment: classEnvironment;
		strategies: {
			EmptyIntervalStrategy new .
			NegativeIntervalStrategy new .
			OutOfBoundsIntervalStrategy new .
		} .
		ExtractMethodNoPreconditionMutationOperator new 
			classEnvironment: classEnvironment;
			strategies: {
				MultipleNodeIntervalsStrategy new offset: 2.
			} .
		ExtractMethodMutationOperator new 
			classEnvironment: classEnvironment;
			strategies: {
				NodeSourceIntervalStrategy new .
			}
	}.

	report := self calculateRefactoringCoverageFor: { RBExtractMethodRefactoring } using: operators .
	report previewCoverageInDrTests.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runInlineMethod [

	| operators report |
	"We have to operate on the entire system since Inline Method depends on superclasses which can be Object, Collection, etc.
	If we scope it to a package or list of classes, that scope should include every superclass of every class that you want to inline."
	operators := { InlineMethodMutationOperator new
		strategies: (SourceIntervalStrategy subclasses collect: [ :each | each new ])
	}.
	report := self
		calculateRefactoringCoverageFor: { RBInlineMethodRefactoring }
		using: operators.
	report previewCoverageInDrTests; inspect
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameArgOrTemp [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	operators := { 
		RenameArgumentOrTemporaryMutationOperator new
			classEnvironment: classEnvironment;
			strategies: { 
				"Interval strategies"
				NodeSourceIntervalStrategy new .
				"Name strategies"
				UniqueTempNameStrategy new .
				UniqueGlobalNameStrategy new .
				ExistingClassGlobalNameStrategy new .
				ExistingNonClassGlobalNameStrategy new .
				ExistingTraitGlobalNameStrategy new .
				NameWithSpaceStrategy new .
				PseudoVariableSelfAsNameStrategy new .
				PseudoVariableSuperAsNameStrategy new .
		  }.
		RenameArgOrTempInvalidSourceMutationOperator new
			classEnvironment: classEnvironment;
			strategies: { 
				"Interval strategies"
				NodeSourceIntervalStrategy new .
				"Name strategies"
				ExistingInstanceVariableNameStrategy new .
				ExistingTempOrArgNameStrategy new .
				NameStartingWithNumberStrategy new .
				NameWithDotStrategy new .
				NameWithSemicolonStrategy new .
				SameVariableNameStrategy new .
		  } .
		RenameArgOrTempInvalidSourceMutationOperator new
			classEnvironment: classEnvironment;
			strategies: { 
				"Interval strategies"
				NegativeIntervalStrategy new .
				EmptyIntervalStrategy new .
				OutOfBoundsIntervalStrategy new .
				MultipleNodeIntervalsStrategy new offset: 2 . 
				"Name strategies"
				UniqueTempNameStrategy new .
		  }
	}.

	report := self calculateRefactoringCoverageFor: { RBRenameArgumentOrTemporaryRefactoring } using: operators .
	report previewCoverageInDrTests.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameClass [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses , { Object }.

	operators := { RenameClassWithoutPreconditionsMutationOperator new 
		classEnvironment: classEnvironment; 
		strategies: { 
			ExistingNonClassGlobalNameStrategy new . 
			UniqueGlobalNameStrategy new .
			ExistingClassGlobalNameStrategy new .
			ExistingTraitGlobalNameStrategy new .
			SubclassGlobalNameStrategy new .
			SuperclassGlobalNameStrategy new .
		} }.

	report := self calculateRefactoringCoverageFor: { ReRenameClassRefactoring } using: operators .
	report previewCoverageInDrTests.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameMethod [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes: classesToMutate , testClasses.

	operators := {
		RenameMethodMutationOperator new
			classEnvironment: classEnvironment;
			strategies: {
				UniqueMethodNameStrategy new .
				NoPermutationsStrategy new.
				SwapMethodArgumentsStrategy new.
			}.
		RenameMethodMutationOperator new
			classEnvironment: classEnvironment;
			strategies: {
				MethodNameDifferentArityStrategy new .
				SameNameStrategy new .
				SuperClassMethodNameStrategy new .
			}
		  }.

	report := self calculateRefactoringCoverageFor: { ReRenameMethodRefactoring . RBChangeMethodNameRefactoring } using: operators .
	report previewCoverageInDrTests.
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> testClasses [

	^ self testPackageNames flatCollect: [ :package |
		  (PackageOrganizer default packageNamed: package) definedClasses
			  select: [ :cls | cls isTestCase ] ]
]

{ #category : 'accessing' }
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
