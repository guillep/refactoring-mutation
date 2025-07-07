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
	#classInstVars : [
		'logger',
		'showResults',
		'runUnion'
	],
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
	report printCsvOn: logger.
	"report printOn: logger."
	"((report mutationAnalysis generalResult terminatedMutants collect: [ :m | m exception ]) groupedBy: [ :e | e class name ]) printOn: logger." "groups error by class"
	self showAnalysisResults ifTrue: [
		"report mutationAnalysis generalResult inspect."
		"report coverage inspect."
		"report previewCoverageInDrTests"
	].
	^ report
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> classesToMutate [

	^ self mutationPackageNames flatCollect: [ :package |
		  (PackageOrganizer default packageNamed: package) definedClasses
			  reject: [ :cls | cls isManifest ] ]
]

{ #category : 'logging' }
RefactoringMutationTestingScripts class >> configureCSVLoggerFor: aTestName [

	| file |
	file := FileReference
		        fileSystem: FileSystem disk
		        path: Path * (aTestName , '-Refazzing.csv').
	logger := file writeStream.
	logger
		nextPutAll: 'Refactoring,no mutants,killed,alive,terminated,score,method coverage,covered/total no methods,node coverage,covered/total no nodes';
		cr.
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> logger: aWriteStream [ 
	logger := aWriteStream
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> mutationPackageNames [ 

	^ self subclassResponsibility 
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> operator: operator inputs: inputStrategies on: classEnvironment [

	^ { operator new
		  classEnvironment: classEnvironment;
		  strategies: inputStrategies }
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
RefactoringMutationTestingScripts class >> run [

	<script>
	[
		self configureCSVLoggerFor: 'Artefact-testing'.
		showResults := false. "Don't open dialogs showing coverage and mutation results"
		runUnion := false.
		self runFor: ArtefactRefactoringMutationTestingScripts 
	] ensure: [
		logger close 
	]
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runAddArgument [

	| testClasses classesToMutate classEnvironment operators report validInputs invalidInputs validNameInvalidPerm invalidNameValidPerm allValidOperator validOperatorInvalidInputs allInvalidOperator allInvalidInputs |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.
	validInputs := MethodNameStrategy validAddArgMethodNames , MethodNamePermutationsStrategy validAddArgPermutations.
	allInvalidInputs := MethodNameStrategy invalidAddArgMethodNames , MethodNamePermutationsStrategy invalidAddArgPermutations.
	validNameInvalidPerm := MethodNameStrategy validAddArgMethodNames , MethodNamePermutationsStrategy invalidAddArgPermutations.
	invalidNameValidPerm := MethodNameStrategy invalidAddArgMethodNames , MethodNamePermutationsStrategy validAddArgPermutations.
	invalidInputs := invalidNameValidPerm , validNameInvalidPerm , allInvalidInputs.
	
	allValidOperator := self operator: AddArgumentMutationOperator inputs: validInputs on: classEnvironment.
	logger nextPutAll: 'Add Argument Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: allValidOperator.
	
	validOperatorInvalidInputs := self operator: AddArgumentMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Add Argument Refactoring Fuzzed,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: validOperatorInvalidInputs.

	allInvalidOperator := self operator: AddArgumentInvalidBehPresMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Add Argument Fuzzed with Ignored Behavior Preserving Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: allInvalidOperator.

	allInvalidOperator := self operator: AddArgumentInvalidPreconditionMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Add Argument Fuzzed with Ignored Failed Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: allInvalidOperator.

	self shouldRunUnion ifFalse: [ ^ self ].
	operators := allValidOperator, validOperatorInvalidInputs , allInvalidOperator.
	logger nextPutAll: 'Add Argument Union Of All Above,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: operators.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	| testClasses classesToMutate classEnvironment operators report validInput invalidInput validOperator validOperatorInvalidInput invalidOperator |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.

	validInput := SourceIntervalStrategy validIntervals.
	invalidInput := SourceIntervalStrategy invalidIntervals.
	
	validOperator := self operator: CompositeExtractMethodMutationOperator inputs: validInput on: classEnvironment.
	logger nextPutAll: 'Composite Extract Method Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: validOperator.
	
	validOperatorInvalidInput := self operator: CompositeExtractMethodMutationOperator inputs: invalidInput on: classEnvironment.
	logger nextPutAll: 'Composite Extract Method Fuzzed Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: validOperatorInvalidInput.

	invalidOperator := self operator: CompositeExtractMethodInvalidBehPresMutationOperator inputs: invalidInput on: classEnvironment.
	logger nextPutAll: 'Composite Extract Method Fuzzed with Ignored Behavior Preserving Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: invalidOperator.

	invalidOperator := self operator: CompositeExtractMethodPreconditionsMutationOperator inputs: invalidInput on: classEnvironment.
	logger nextPutAll: 'Composite Extract Method Fuzzed with Ignored Failed Preconditions,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: invalidOperator.

	self shouldRunUnion ifFalse: [ ^ self ].
	operators := validOperator , validOperatorInvalidInput, invalidOperator.
	logger nextPutAll: 'Composite Extract Method Union of All Above,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: operators.
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

	| testClasses classesToMutate classEnvironment operators report validInput invalidInput validOperator validOperatorInvalidInput invalidOperator |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.

	validInput := SourceIntervalStrategy validIntervals.
	invalidInput := SourceIntervalStrategy invalidIntervals.
	
	validOperator := self operator: ExtractMethodMutationOperator inputs: validInput on: classEnvironment.
	logger nextPutAll: 'Extract Method Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: validOperator.
	
	validOperatorInvalidInput := self operator: ExtractMethodMutationOperator inputs: invalidInput on: classEnvironment.
	logger nextPutAll: 'Extract Method Fuzzed Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: validOperatorInvalidInput.

	invalidOperator := self operator: ExtractMethodInvalidBehPresMutationOperator inputs: invalidInput on: classEnvironment.
	logger nextPutAll: 'Extract Method Fuzzed with Ignored Behavior Preserving Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: invalidOperator.

	invalidOperator := self operator: ExtractMethodNoPreconditionMutationOperator inputs: invalidInput on: classEnvironment.
	logger nextPutAll: 'Extract Method Fuzzed with Ignored Failed Precondition,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: invalidOperator.

	self shouldRunUnion ifFalse: [ ^ self ].
	operators := validOperator , validOperatorInvalidInput, invalidOperator.
	logger nextPutAll: 'Extract Method Union of All Above,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: operators.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runFor: class [

	class logger: logger.
	class runAddArgument.
	class runCompositeExtractMethod.
	class runExtractMethod.
	class runInlineMethod.
	class runRenameArgOrTemp.
	class runRenameClass.
	class runRenameMethod.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runInlineMethod [

	| operators report validInputs invalidInputs validOperator validOperatorInvalidInput invalidOperator |
	"We have to operate on the entire system since Inline Method depends on superclasses which can be Object, Collection, etc.
	If we scope it to a package or list of classes, that scope should include every superclass of every class that you want to inline."
	
	validInputs := SourceIntervalStrategy validIntervals.
	invalidInputs := SourceIntervalStrategy invalidIntervals.
	
	validOperator := self operator: InlineMethodMutationOperator inputs: validInputs on: nil.
	logger nextPutAll: 'Inline Method Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: validOperator.
	
	validOperatorInvalidInput := self operator: InlineMethodMutationOperator inputs: invalidInputs on: nil.
	logger nextPutAll: 'Inline Method Fuzzed Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: validOperatorInvalidInput.

	invalidOperator := self operator: InlineMethodBehPresMutationOperator inputs: invalidInputs on: nil.
	logger nextPutAll: 'Inline Method Fuzzed with Ignored Behavior Preserving Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: invalidOperator.
		
	invalidOperator := self operator: InlineMethodInvalidInputMutationOperator inputs: invalidInputs on: nil.
	logger nextPutAll: 'Inline Method Fuzzed with Ignored Failed Preconditions,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: invalidOperator.

	self shouldRunUnion ifFalse: [ ^ self ].
	operators := validOperator , validOperatorInvalidInput , invalidOperator.
	logger nextPutAll: 'Inline Method Union of All Above,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: operators.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameArgOrTemp [

	| testClasses classesToMutate classEnvironment operators report validInputs validNameInvalidInterval validIntervalInvalidName allInvalidInputs invalidInputs validOperator validOperatorInvalidInputs invalidOperator |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.

	validInputs := SourceIntervalStrategy validIntervals , NameStrategy validVarNames.
	validNameInvalidInterval := NameStrategy validVarNames , SourceIntervalStrategy invalidIntervals.
	validIntervalInvalidName := SourceIntervalStrategy validIntervals , NameStrategy invalidGlobalAndVarNames.
	allInvalidInputs := SourceIntervalStrategy invalidIntervals , NameStrategy invalidGlobalAndVarNames.
	invalidInputs := validNameInvalidInterval , validIntervalInvalidName , allInvalidInputs.
	
	validOperator := self operator: RenameArgumentOrTemporaryMutationOperator inputs: validInputs on: classEnvironment.
	logger nextPutAll: 'Rename Arg or Temp Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: validOperator.
		
	validOperatorInvalidInputs := self operator: RenameArgumentOrTemporaryMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Arg or Temp Fuzzed Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: validOperatorInvalidInputs.

	invalidOperator := self operator: RenameArgOrTempBehPresMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Arg or Temp Fuzzed with Ignored Behavior Preserving Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: invalidOperator.

	invalidOperator := self operator: RenameArgOrTempInvalidInputMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Arg or Temp Fuzzed with Ignoring Failed Preconditions,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: invalidOperator.

	self shouldRunUnion ifFalse: [ ^ self ].
	operators := validOperator, validOperatorInvalidInputs, invalidOperator.
	logger nextPutAll: 'Rename Arg or Temp Union of All Above,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: operators.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameClass [

	| testClasses classesToMutate classEnvironment operators report validInputs invalidInputs validOperator validOperatorInvalidInputs invalidOperator |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses , { Object }.

	validInputs := NameStrategy validGlobalNames.
	invalidInputs := NameStrategy invalidGlobalAndVarNames.
	
	validOperator := self operator: RenameClassMutationOperator inputs: validInputs on: classEnvironment.
	logger nextPutAll: 'Rename Class Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: validOperator.

	validOperatorInvalidInputs := self operator: RenameClassMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Class Refactoring Fuzzed,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: validOperatorInvalidInputs.

	invalidOperator := self operator: RenameClassInvalidBehPresMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Class Fuzzed with Ignored Behavior Preserving Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: invalidOperator.

	invalidOperator := self operator: RenameClassWithoutPreconditionsMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Class Fuzzed with Ignored Failed Preconditions,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: invalidOperator.

	self shouldRunUnion ifFalse: [ ^ self ].
	operators := validOperator , validOperatorInvalidInputs , invalidOperator.
	logger nextPutAll: 'Rename Class Union of All Above,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameMethod [

	| testClasses classesToMutate classEnvironment operators report validInputs invalidInputs validNameInvalidPerm invalidNameValidPerm allValidOperator validOperatorInvalidInputs allInvalidOperator allInvalidInputs |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.
		
	validInputs := MethodNameStrategy validRenameMethodNames , MethodNamePermutationsStrategy validRenameMethodPermutations.
	allInvalidInputs := MethodNameStrategy invalidRenameMethodNames , MethodNamePermutationsStrategy invalidRenameMethodPermutations .
	validNameInvalidPerm := MethodNameStrategy validRenameMethodNames , MethodNamePermutationsStrategy invalidRenameMethodPermutations.
	invalidNameValidPerm := MethodNameStrategy invalidRenameMethodNames , MethodNamePermutationsStrategy validRenameMethodPermutations.
	invalidInputs := invalidNameValidPerm , validNameInvalidPerm , allInvalidInputs.

	allValidOperator := self operator: RenameMethodMutationOperator inputs: validInputs on: classEnvironment.
	logger nextPutAll: 'Rename Method Refactoring,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: allValidOperator.

	validOperatorInvalidInputs := self operator: RenameMethodMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Method Refactoring Fuzzed,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: validOperatorInvalidInputs.

	allInvalidOperator := self operator: RenameMethodInvalidBehPresMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Method Fuzzed with Ignored Behavior Preserving Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: allInvalidOperator.

	allInvalidOperator := self operator: RenameMethodInvalidPreconditionsMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Method Fuzzed with Ignored Failed Preconditions,'.
		report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: allInvalidOperator.		

	self shouldRunUnion ifFalse: [ ^ self ].
	operators := allValidOperator, validOperatorInvalidInputs , allInvalidOperator.
	logger nextPutAll: 'Rename Method Union Of All Above,'.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: operators.
]

{ #category : 'asserting' }
RefactoringMutationTestingScripts class >> shouldRunUnion [

	^ runUnion ifNil: [ runUnion := false ]
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> showAnalysisResults [

	^ showResults ifNil: [ showResults := true ]
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
