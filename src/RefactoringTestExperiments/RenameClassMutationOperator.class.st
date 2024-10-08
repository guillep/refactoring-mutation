Class {
	#name : 'RenameClassMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameClassMutationOperator >> appliesToNode: aNode [

	| model |
	aNode methodNode compiledMethod isExtension ifTrue: [ ^ false ].
	aNode isGlobalVariable ifFalse: [ ^ false ].
	model := RBNamespace onEnvironment: classEnvironment.
	(model classNamed: aNode name) ifNil: [ ^ false ].

	^ self canRefactor: aNode in: model
]

{ #category : 'instance creation' }
RenameClassMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := ReRenameClassRefactoring
		               model: (RBNamespace onEnvironment: classEnvironment)
		               rename: aMutation data name
		               to: 'Foo' , aMutation data name.
	refactoring execute
]

{ #category : 'testing' }
RenameClassMutationOperator >> canRefactor: aNode in: aModel [

	| refactoring |
	"Check if class is in environment."
	refactoring := ReRenameClassRefactoring
		               model: aModel
		               rename: aNode name
		               to: 'Foo' , aNode name.

	[
	refactoring
		prepareForExecution;
		checkPreconditions ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'printing' }
RenameClassMutationOperator >> description [
	
	^ 'Rename all classes found in method body mutation testing'
]

{ #category : 'private' }
RenameClassMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode stop with: 'Foo' , aNode name
]

{ #category : 'mutant generation' }
RenameClassMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

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
