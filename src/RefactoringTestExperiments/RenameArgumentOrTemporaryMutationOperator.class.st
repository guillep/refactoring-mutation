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
	model := RBNamespace onEnvironment: classEnvironment.

	^ self canRefactor: aNode in: model
]

{ #category : 'instance creation' }
RenameArgumentOrTemporaryMutationOperator >> applyMutation: aMutation [

	| refactoring |
	(aMutation inputFor: #name) ifNil: [ ^ nil ].
	(aMutation inputFor: #interval) ifNil: [ ^ nil ].
	refactoring := RBRenameArgumentOrTemporaryRefactoring
		  model: (RBNamespace onEnvironment: classEnvironment)
		  renameTemporaryFrom: (aMutation inputFor: #interval) 
		  to: (aMutation inputFor: #name)
		  in: aMutation data methodNode compiledMethod origin
		  selector: aMutation data methodNode selector.
	
	refactoring execute
]

{ #category : 'testing' }
RenameArgumentOrTemporaryMutationOperator >> canRefactor: aNode in: aModel [

	| refactoring |
	"Check if class is in environment."
	refactoring := self createRefactoringWith: aNode on: aModel.
	refactoring ifNil: [ ^ false ].

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

{ #category : 'private' }
RenameArgumentOrTemporaryMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode stop with: 'foo' , aNode name
]
