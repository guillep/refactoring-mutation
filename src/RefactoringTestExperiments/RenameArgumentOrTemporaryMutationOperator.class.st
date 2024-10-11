Class {
	#name : 'RenameArgumentOrTemporaryMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#instVars : [
		'sourceIntervalStrategy',
		'nameStrategy'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameArgumentOrTemporaryMutationOperator >> appliesToNode: aNode [

	| model |
	aNode methodNode compiledMethod isExtension ifTrue: [ ^ false ].
	(aNode isTempVariable or: [ aNode isArgumentVariable ]) ifFalse: [ ^ false ].
	model := RBNamespace onEnvironment: classEnvironment.

	^ self canRefactor: aNode in: model
]

{ #category : 'instance creation' }
RenameArgumentOrTemporaryMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := self createRefactoringWith: aMutation data on: (RBNamespace onEnvironment: classEnvironment).
	
	refactoring execute
]

{ #category : 'testing' }
RenameArgumentOrTemporaryMutationOperator >> canRefactor: aNode in: aModel [

	| refactoring |
	"Check if class is in environment."
	refactoring := self createRefactoringWith: aNode on: aModel.

	[
	refactoring
		prepareForExecution;
		checkPreconditions ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'mutant generation' }
RenameArgumentOrTemporaryMutationOperator >> createRefactoringWith: aNode on: aModel [

	| refactoring name |
	refactoring := RBRenameArgumentOrTemporaryRefactoring
		  model: aModel
		  renameTemporaryFrom: (self sourceIntervalStrategyFor: aNode)
		  to: ''
		  in: aNode methodNode compiledMethod origin
		  selector: aNode methodNode selector.
	name := self nameStrategyFor: aNode and: refactoring.
	refactoring newName: name.
	^ refactoring
]

{ #category : 'printing' }
RenameArgumentOrTemporaryMutationOperator >> description [
	
	^ 'Rename all arguments and temporaries found in method body mutation testing'
]

{ #category : 'private' }
RenameArgumentOrTemporaryMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode stop with: 'foo' , aNode name
]

{ #category : 'mutant generation' }
RenameArgumentOrTemporaryMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

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

{ #category : 'as yet unclassified' }
RenameArgumentOrTemporaryMutationOperator >> nameStrategy: aStrategy [

	nameStrategy := aStrategy 
]

{ #category : 'as yet unclassified' }
RenameArgumentOrTemporaryMutationOperator >> nameStrategyFor: aNode and: aRefactoring [

	^ nameStrategy forNode: aNode and: aRefactoring 
]

{ #category : 'as yet unclassified' }
RenameArgumentOrTemporaryMutationOperator >> sourceIntervalStrategy: aStrategy [

	sourceIntervalStrategy := aStrategy 
]

{ #category : 'as yet unclassified' }
RenameArgumentOrTemporaryMutationOperator >> sourceIntervalStrategyFor: aNode [

	^ sourceIntervalStrategy forNode: aNode
]
