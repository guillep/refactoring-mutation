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
		'logger'
	],
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'running' }
RefactoringMutationTestingScripts class >> addArgumentPreconditionsOperators: classEnvironment [

	^ {
		  (AddArgumentMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   MethodNameAdditionalArgumentStrategy new.
					   NoPermutationsStrategy new.
					   SwapFirstTwoPermutationStrategy new }). "good name bad permutations"
		  (AddArgumentMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   SameNameStrategy new.
					   SuperClassMethodNameStrategy new.
					   SwapMethodArgumentsStrategy new.
					   UniqueMethodNameStrategy new.
					   AddArgumentPermutationsStrategy new }) "good permutations bad name" }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> addArgumentTransformationOperators: classEnvironment [

	^ { (AddArgumentMutationOperator new
		   classEnvironment: classEnvironment;
		   strategies: {
				   MethodNameAdditionalArgumentStrategy new.
				   AddArgumentPermutationsStrategy new }) }
]

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

	^ { (InlineMethodMutationOperator new strategies:
		   (SourceIntervalStrategy subclasses 
				select: [ :each | each name ~= 'NodeSourceIntervalStrategy' ]
				thenCollect: [ :each | each new ])) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> inlineMethodTransformationOperators [

	^ { InlineMethodMutationOperator new strategies:
		   (NodeSourceIntervalStrategy new) }
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

{ #category : 'running' }
RefactoringMutationTestingScripts class >> renameClassPreconditionsOperators: classEnvironment [

	^ { (RenameClassMutationOperator new
		   classEnvironment: classEnvironment;
		   strategies: {
				   ExistingNonClassGlobalNameStrategy new.
				   ExistingClassGlobalNameStrategy new.
				   ExistingTraitGlobalNameStrategy new.
				   SubclassGlobalNameStrategy new.
				   SuperclassGlobalNameStrategy new }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> renameClassTransformationOperators: classEnvironment [

	^ { (RenameClassMutationOperator new
		   classEnvironment: classEnvironment;
		   strategies: { UniqueGlobalNameStrategy new }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> renameMethodPreconditionsOperators: classEnvironment [

	^ { (RenameMethodMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
						NoPermutationsStrategy new.
						"Name strategies"
						MethodNameAdditionalArgumentStrategy new.
					   MethodNameDifferentArityStrategy new.
					   SameNameStrategy new.
					   SuperClassMethodNameStrategy new.
						SwapMethodArgumentsStrategy new. }) }
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> renameMethodTransformationOperators: classEnvironment [

	^ { (RenameMethodMutationOperator new
			   classEnvironment: classEnvironment;
			   strategies: {
					   UniqueMethodNameStrategy new.
					   NoPermutationsStrategy new }) }
]

{ #category : 'accessing' }
RefactoringMutationTestingScripts class >> repositoryNames [

	^ self subclassResponsibility 
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> run [

	<script>
	logger := NonInteractiveTranscript onFileNamed: 'Refazzing.log'.
	self runAllFor: AIAlgorithmsRefactoringMutationTestingScripts.
	logger close.
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runAddArgument [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.
	"Run with transformation operators only"
	operators := self addArgumentTransformationOperators: classEnvironment.
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: operators.
	logger traceCr: 'Add Argument Transformation Operators only:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests."
	
	"Run with transformation and preconditions operators"
	operators := operators , (self addArgumentPreconditionsOperators: classEnvironment).
	report := self
		          calculateRefactoringCoverageFor:
		          { RBAddParameterRefactoring }
		          using: operators.
	logger traceCr: 'Add Argument with Preconditions Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
]

{ #category : 'as yet unclassified' }
RefactoringMutationTestingScripts class >> runAllFor: class [

	class runAddArgument.
	class runCompositeExtractMethod.
	class runExtractMethod.
	class runInlineMethod.
	class runRenameArgOrTemp.
	class runRenameClass.
	class runRenameMethod.
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
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: operators.
	logger traceCr: 'Composite Extract Method Transformation Operators only:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests."
	
	operators := operators , (self compositeExtractMethodPreconditionsOperators:
		             classEnvironment).
	report := self
		          calculateRefactoringCoverageFor:
		          { ReCompositeExtractMethodRefactoring }
		          using: operators.
	logger traceCr: 'Composite Extract Method with Preconditions Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
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
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: operators.
	logger traceCr: 'Extract Method Transformation Operators only:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"

	operators := operators , (self extractMethodPreconditionsOperators: classEnvironment).
	report := self
		          calculateRefactoringCoverageFor:
		          { RBExtractMethodRefactoring }
		          using: operators.
	logger traceCr: 'Extract Method with Precondition Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
]

{ #category : 'as yet unclassified' }
RefactoringMutationTestingScripts class >> runFor: class [

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
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: operators.
	logger traceCr: 'Inline Method Transformation Operators only:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
		
	operators := operators , (self inlineMethodPreconditionsOperators).
	report := self
		          calculateRefactoringCoverageFor:
		          { RBInlineMethodRefactoring }
		          using: operators.
	logger traceCr: 'Inline Method with Precondition Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
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
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: operators.
	logger traceCr: 'Rename Arg or Temp Transformation Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
	
	operators := operators , (self renameArgOrTempPreconditionsOperators: classEnvironment).
	report := self
		          calculateRefactoringCoverageFor:
		          { RBRenameArgumentOrTemporaryRefactoring }
		          using: operators.
	logger traceCr: 'Rename Arg or Temp with Precondition Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameClass [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses , { Object }.

	operators := self renameClassTransformationOperators:
		             classEnvironment.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: operators.
	logger traceCr: 'Rename Class Transformation Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
	
	operators := operators , (self renameClassPreconditionsOperators: classEnvironment).
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameClassRefactoring }
		          using: operators.
	logger traceCr: 'Rename Class with Precondition Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
]

{ #category : 'running' }
RefactoringMutationTestingScripts class >> runRenameMethod [

	| testClasses classesToMutate classEnvironment operators report |
	self reload.
	testClasses := self testClasses.
	classesToMutate := self classesToMutate.
	"classesToMutate := classesToMutate reject: [ :cls | cls methods contains: [ :method | method isExtension ] ]."
	classEnvironment := RBClassEnvironment classes:
		                    classesToMutate , testClasses.

	operators := self renameMethodTransformationOperators:
		             classEnvironment.
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: operators.
	logger traceCr: 'Rename Method Transformation Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
	
	operators := operators , (self renameMethodPreconditionsOperators: classEnvironment).
	report := self
		          calculateRefactoringCoverageFor:
		          { ReRenameMethodRefactoring }
		          using: operators.
	logger traceCr: 'Rename Method with Precondition Operators:'.
	logger traceCr: report.
	logger traceCr: report coverage.
	"report previewCoverageInDrTests"
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
