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
		'showResults'
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
	report printOn: logger.
	((report mutationAnalysis generalResult terminatedMutants collect: [ :m | m exception ]) groupedBy: [ :e | e class name ]) printOn: logger. "groups error by class"
	logger cr.
	self showAnalysisResults ifTrue: [
		report mutationAnalysis generalResult inspect.
		report coverage inspect.
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

{ #category : 'running' }
RefactoringMutationTestingScripts class >> compositeExtractMethodPreconditionsOperators: classEnvironment [

	^ {
		  (CompositeExtractMethodMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   EmptyIntervalStrategy new.
					   NegativeIntervalStrategy new.
					   OutOfBoundsIntervalStrategy new }).
		  (CompositeExtractMethodMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: { (MultipleNodeIntervalsStrategy new offset: 2) }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> compositeExtractMethodTransformationOperators: classEnvironment [

	^ { (CompositeExtractMethodMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: { NodeSourceIntervalStrategy new }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> extractMethodPreconditionsOperators: classEnvironment [

	^ {
		  (ExtractMethodNoPreconditionMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   EmptyIntervalStrategy new.
					   NegativeIntervalStrategy new.
					   OutOfBoundsIntervalStrategy new }).
		  (ExtractMethodNoPreconditionMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: { (MultipleNodeIntervalsStrategy new offset: 2) }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> extractMethodTransformationOperators: classEnvironment [

	^ { (ExtractMethodMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: { NodeSourceIntervalStrategy new }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> inlineMethodPreconditionsOperators [

	^ { (InlineMethodInvalidInputMutationOperator new strategies:
		   (SourceIntervalStrategy subclasses 
				select: [ :each | each name ~= 'NodeSourceIntervalStrategy' ]
				thenCollect: [ :each | each new ])) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> inlineMethodTransformationOperators [

	^ { InlineMethodMutationOperator new strategies:
		   { NodeSourceIntervalStrategy new } }
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

{ #category : 'running' }
RefactoringMutationTestingScripts class >> renameArgOrTempPreconditionsOperators: classEnvironment [

	^ {
		  (RenameArgumentOrTemporaryMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   NodeSourceIntervalStrategy new.
					   "Name strategies"
					   UniqueGlobalNameStrategy new.
					   ExistingClassGlobalNameStrategy new.
					   ExistingNonClassGlobalNameStrategy new.
					   ExistingTraitGlobalNameStrategy new.
					   NameWithSpaceStrategy new.
					   PseudoVariableSelfAsNameStrategy new.
					   PseudoVariableSuperAsNameStrategy new }).
		  "Invalid name strategies"
		  (RenameArgOrTempInvalidInputMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   NodeSourceIntervalStrategy new.
					   "Name strategies"
					   ExistingInstanceVariableNameStrategy new.
					   ExistingTempOrArgNameStrategy new.
					   NameStartingWithNumberStrategy new.
					   NameWithDotStrategy new.
					   NameWithSemicolonStrategy new.
					   SameVariableNameStrategy new }).
		  "Interval strategies"
		  (RenameArgOrTempInvalidInputMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   NegativeIntervalStrategy new.
					   EmptyIntervalStrategy new.
					   OutOfBoundsIntervalStrategy new.
					   (MultipleNodeIntervalsStrategy new offset: 2).
					   "Name strategies"
					   UniqueTempNameStrategy new }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> renameArgOrTempTransformationOperators: classEnvironment [

	^ { (RenameArgumentOrTemporaryMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   NodeSourceIntervalStrategy new.
					   UniqueTempNameStrategy new }) }
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> repositoryNames [

	^ self subclassResponsibility 
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> run [

	<script>
	| file |
	file := FileReference fileSystem: FileSystem disk path: Path * 'Soup-Refazzing.log'.
	logger := file writeStream.
	logger nextPutAll: 'Starting Soup testing'.
	showResults := false. "Don't open dialogs showing coverage and mutation results"
	self runFor: SoupRefactoringMutationTestingScripts.
	logger close.
	
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
	allInvalidInputs := MethodNameStrategy invalidMethodNames , MethodNamePermutationsStrategy invalidAddArgPermutations.
	validNameInvalidPerm := MethodNameStrategy validAddArgMethodNames , MethodNamePermutationsStrategy invalidAddArgPermutations.
	invalidNameValidPerm := MethodNameStrategy invalidMethodNames , MethodNamePermutationsStrategy validAddArgPermutations.
	invalidInputs := invalidNameValidPerm , validNameInvalidPerm , allInvalidInputs.
	
	allValidOperator := self operator: AddArgumentMutationOperator inputs: validInputs on: classEnvironment.
	logger nextPutAll: 'Add Argument Refactoring:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: allValidOperator.
	
	validOperatorInvalidInputs := self operator: AddArgumentMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Add Argument Refactoring Fuzzed:'; cr.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: validOperatorInvalidInputs.
	
	allInvalidOperator := self operator: AddArgumentInvalidPreconditionMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Add Argument Fuzzed with Ignored Failed Preconditions'; cr.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: allInvalidOperator.

	operators := allValidOperator, validOperatorInvalidInputs , allInvalidOperator.
	logger nextPutAll: 'Add Argument Union Of All Above:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: operators.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runCompositeExtractMethod [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.

	operators := self compositeExtractMethodTransformationOperators:
		             classEnvironment.
	logger nextPutAll: 'Composite Extract Method Transformation Operators only:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: operators.
	"report previewCoverageInDrTests."
	
	operators := operators , (self compositeExtractMethodPreconditionsOperators:
		             classEnvironment).
	logger nextPutAll: 'Composite Extract Method with Preconditions Operators:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"
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
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.

	operators := self extractMethodTransformationOperators:
		             classEnvironment.
	logger nextPutAll: 'Extract Method Transformation Operators only:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"

	operators := operators , (self extractMethodPreconditionsOperators: classEnvironment).
	logger nextPutAll: 'Extract Method with Precondition Operators:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"
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

	| operators report |
	"We have to operate on the entire system since Inline Method depends on superclasses which can be Object, Collection, etc.
	If we scope it to a package or list of classes, that scope should include every superclass of every class that you want to inline."
	operators := self inlineMethodTransformationOperators.
	logger nextPutAll: 'Inline Method Transformation Operators only:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"
		
	operators := operators , (self inlineMethodPreconditionsOperators).
	logger nextPutAll: 'Inline Method with Precondition Operators:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameArgOrTemp [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.

	operators := self renameArgOrTempTransformationOperators:
		             classEnvironment.
	logger nextPutAll: 'Rename Arg or Temp Transformation Operators:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"
	
	operators := operators , (self renameArgOrTempPreconditionsOperators: classEnvironment).
	logger nextPutAll: 'Rename Arg or Temp with Precondition Operators:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: operators.
	"report previewCoverageInDrTests"
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
	logger nextPutAll: 'Rename Class Refactoring:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: validOperator.

	validOperatorInvalidInputs := self operator: RenameClassMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Class Refactoring Fuzzed:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: validOperatorInvalidInputs.

	invalidOperator := self operator: RenameClassWithoutPreconditionsMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Class Fuzzed with Ignored Failed Preconditions:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: invalidOperator.
	
	operators := validOperator , validOperatorInvalidInputs , invalidOperator.
	logger nextPutAll: 'Rename Class Union of All Above:'; cr.
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
	allInvalidInputs := MethodNameStrategy invalidMethodNames , MethodNamePermutationsStrategy invalidRenameMethodPermutations .
	validNameInvalidPerm := MethodNameStrategy validRenameMethodNames , MethodNamePermutationsStrategy invalidRenameMethodPermutations.
	invalidNameValidPerm := MethodNameStrategy invalidMethodNames , MethodNamePermutationsStrategy validRenameMethodPermutations.
	invalidInputs := invalidNameValidPerm , validNameInvalidPerm , allInvalidInputs.

	allValidOperator := self operator: RenameMethodMutationOperator inputs: validInputs on: classEnvironment.
	logger nextPutAll: 'Rename Method Refactoring:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: allValidOperator.

	validOperatorInvalidInputs := self operator: RenameMethodMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Method Refactoring Fuzzed:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: validOperatorInvalidInputs.

	allInvalidOperator := self operator: RenameMethodInvalidPreconditionsMutationOperator inputs: invalidInputs on: classEnvironment.
	logger nextPutAll: 'Rename Method Fuzzed with Ignored Failed Preconditions'; cr.
		report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: allInvalidOperator.		
		
	operators := allValidOperator, validOperatorInvalidInputs , allInvalidOperator.
	logger nextPutAll: 'Rename Method Union Of All Above:'; cr.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: operators.
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
