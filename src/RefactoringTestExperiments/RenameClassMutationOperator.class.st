Class {
	#name : 'RenameClassMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#instVars : [
		'model'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameClassMutationOperator >> appliesToNode: aNode [

	(aNode isGlobalVariable )
		ifFalse: [ ^ false ].

	^ self canRefactor: aNode
]

{ #category : 'instance creation' }
RenameClassMutationOperator >> applyMutation: aMutation [

	| refactoring |
	refactoring := ReRenameClassRefactoring 
						model: model 
						rename: aMutation data name
						to: 'Foo' , aMutation data name.
	refactoring execute.
]

{ #category : 'testing' }
RenameClassMutationOperator >> canRefactor: aNode [

	| refactoring |
	model := RBNamespace onEnvironment: environment.
	"Check if class is in environment."
	(model classNamed: aNode name) ifNil: [ ^ false ].
	refactoring := ReRenameClassRefactoring 
		               model: model
		rename: aNode name to: 'Foo' , aNode name.

	[ refactoring prepareForExecution; checkPreconditions ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'printing' }
RenameClassMutationOperator >> description [
	
	^ 'Rename all classes found in method body mutation testing'
]

{ #category : 'accessing' }
RenameClassMutationOperator >> environment: anEnvironment [

	environment := anEnvironment 
]

{ #category : 'private' }
RenameClassMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode first to: aNode last with: 'Foo' , aNode name
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
