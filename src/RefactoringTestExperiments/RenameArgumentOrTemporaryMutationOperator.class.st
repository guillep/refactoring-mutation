Class {
	#name : 'RenameArgumentOrTemporaryMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameArgumentOrTemporaryMutationOperator >> appliesToNode: aNode [

	| model |
	aNode methodNode compiledMethod isExtension ifTrue: [ ^ false ].
	(aNode isTempVariable or: [ aNode isArgumentVariable ]) ifFalse: [ ^ false ].
	model := RBNamespace onEnvironment: environment.

	^ self canRefactor: aNode in: model
]

{ #category : 'instance creation' }
RenameArgumentOrTemporaryMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := self createRefactoringWith: aMutation data on: (RBNamespace onEnvironment: environment).
	
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

{ #category : 'as yet unclassified' }
RenameArgumentOrTemporaryMutationOperator >> createRefactoringWith: aNode on: aModel [

	^ RBRenameArgumentOrTemporaryRefactoring
		  model: aModel
		  renameTemporaryFrom: aNode sourceInterval 
		  to: 'foo' , aNode name
		  in: aNode methodNode compiledMethod origin
		  selector: aNode methodNode selector
]

{ #category : 'printing' }
RenameArgumentOrTemporaryMutationOperator >> description [
	
	^ 'Rename all arguments and temporaries found in method body mutation testing'
]

{ #category : 'accessing' }
RenameArgumentOrTemporaryMutationOperator >> environment: aRBEnvironment [

	environment := aRBEnvironment 
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
