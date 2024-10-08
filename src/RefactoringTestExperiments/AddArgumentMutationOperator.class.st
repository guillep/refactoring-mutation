Class {
	#name : 'AddArgumentMutationOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
	#instVars : [
		'environment'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
AddArgumentMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	| selected |
	selected := aParseTree body allChildren select: [ :aNode |
		            self appliesToNode: aNode ].
	(self appliesToNode: aParseTree methodNode) ifTrue: [
		selected add: aParseTree methodNode ].

	^ selected
]

{ #category : 'instance creation' }
AddArgumentMutationOperator >> appliesToNode: aNode [

	| model |
	aNode methodNode compiledMethod isExtension ifTrue: [ ^ false ].
	aNode isMethod ifFalse: [ ^ false ].
	aNode selector = #initialize ifTrue: [ ^ false ].
	model := RBNamespace onEnvironment: environment.

	^ self canRefactor: aNode in: model
]

{ #category : 'instance creation' }
AddArgumentMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := self createRefactoringWith: aMutation data on: (RBNamespace onEnvironment: environment).
	
	refactoring execute
]

{ #category : 'testing' }
AddArgumentMutationOperator >> canRefactor: aNode in: aModel [

	| refactoring |
	refactoring := self createRefactoringWith: aNode on: aModel.

	[
	refactoring
		prepareForExecution;
		checkPreconditions ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'as yet unclassified' }
AddArgumentMutationOperator >> createRefactoringWith: aNode on: aModel [
	| permutations |
	permutations := (1 to: aNode arguments size) asOrderedCollection.
	permutations add: -1.
	
	^ RBAddParameterRefactoring 
		  model: aModel
		  addParameterToMethod: aNode selector
		  in: aNode compiledMethod origin
		  newSelector: aNode selector , #foo:
		  permutation: permutations
		  newArgs: { RBArgumentName name: 'aFoo' value: 'nil' }
]

{ #category : 'printing' }
AddArgumentMutationOperator >> description [
	
	^ 'Rename all arguments and temporaries found in method body mutation testing'
]

{ #category : 'accessing' }
AddArgumentMutationOperator >> environment: aRBEnvironment [

	environment := aRBEnvironment 
]

{ #category : 'private' }
AddArgumentMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	| sep |
	sep := aCompiledMethod selector isUnary ifTrue: [ '' ] ifFalse: [ ' ' ].
	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode selectorAndArgumentNames size with: aNode selectorAndArgumentNames , sep , 'foo: aFoo'
]

{ #category : 'mutant generation' }
AddArgumentMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| affectedNodes |
	((aCompiledMethod hasPragmaNamed: #ignoreForMutations) or: [
		 aCompiledMethod hasPragmaNamed: #ignoreForCoverage ]) ifTrue: [
		^ #(  ) ].

	affectedNodes := self affectedNodesFor: aParseTree.
	^ affectedNodes collectWithIndex: [ :affectedNode :index |
		  RefactoringMutation
			  for: aCompiledMethod
			  using: self
			  nodeNumber: index
			  ofClass: aCompiledMethod methodClass
			  withData: affectedNode ]
]
