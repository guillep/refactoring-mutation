Class {
	#name : 'AddArgumentMutationTestingScript',
	#superclass : 'Object',
	#category : 'RefactoringTestExperiments-Scripts',
	#package : 'RefactoringTestExperiments',
	#tag : 'Scripts'
}

{ #category : 'as yet unclassified' }
AddArgumentMutationTestingScript class >> reloadMicrodown [

	(IceRepository repositoryNamed: 'Microdown')
		ifNil: [ self inform: 'Project not found: ' , name ]
		ifNotNil: [ :found |
			found
				unload;
				forget ].
	EpMonitor disableDuring: [
		[
		Metacello new
			baseline: 'Microdown';
			repository: 'github://Pillar-markup/Microdown:dev/src';
			onConflict: [ :e | e useIncoming ];
			onUpgrade: [ :e | e useIncoming ];
			ignoreImage;
			load ]
			on: MCMergeOrLoadWarning
			do: [ :e | e load ] ]
]

{ #category : 'running' }
AddArgumentMutationTestingScript class >> run [
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
		            operators: { AddArgumentMutationOperator new environment: classEnvironment }.

	collector := DTCoverageCollector new. "Instantiate"
	collector methods: RBAddParameterRefactoring methods.  "Configure with the methods to watch."
	coverage := collector runOn: [ analysis run ].  "Setup, execute and teardown."
	" a DTCoverageResult methods: 8 (67%) nodes: 20 (50%)"

	"To inspect the results"
	analysis generalResult inspect
	"678 mutants, 231 killed, 446 alive, 1 terminated. Mutation Score: 34%."
]
