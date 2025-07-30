Class {
	#name : 'RenameClassMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'printing' }
RenameClassMutationOperator >> createRefactoringWith: aMutation [

	(aMutation inputFor: #name) ifNil: [ ^ nil ].
	^ ReRenameClassRefactoring
		  model: (RBNamespace onEnvironment: classEnvironment)
		  rename: aMutation data name
		  to: (aMutation inputFor: #name)
]

{ #category : 'printing' }
RenameClassMutationOperator >> description [
	
	^ 'Rename all classes found in method body mutation testing'
]

{ #category : 'private' }
RenameClassMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode sourceInterval first to: aNode sourceInterval last with: 'Foo' , aNode name
]
