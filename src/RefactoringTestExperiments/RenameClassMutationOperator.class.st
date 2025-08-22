Class {
	#name : 'RenameClassMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'printing' }
RenameClassMutationOperator >> createRefactoringWith: aMutation [

	| model name |
	model := RBNamespace onEnvironment: classEnvironment.
	(aMutation strategy appliesToNode: aMutation data) ifFalse: [ ^ nil ].
	name := (aMutation strategy nameFor: aMutation and: model) ifNil: [ ^ nil ].
	^ ReRenameClassRefactoring
		  model: model
		  rename: aMutation data name
		  to: name
]

{ #category : 'printing' }
RenameClassMutationOperator >> description [
	
	^ 'Rename all classes found in method body mutation testing'
]

{ #category : 'private' }
RenameClassMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode sourceInterval first to: aNode sourceInterval last with: 'Foo' , aNode name
]
