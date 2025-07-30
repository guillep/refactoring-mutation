Class {
	#name : 'RenameArgumentOrTemporaryMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'mutant generation' }
RenameArgumentOrTemporaryMutationOperator >> createRefactoringWith: aMutant [

	| model aNode |
	(aMutant inputFor: #name) ifNil: [ ^ nil ].
	(aMutant inputFor: #interval) ifNil: [ ^ nil ].
	model := RBNamespace onEnvironment: classEnvironment.
	aNode := aMutant data.
	^ RBRenameArgumentOrTemporaryRefactoring
		  model: model
		  renameTemporaryFrom: (aMutant inputFor: #interval) 
		  to: (aMutant inputFor: #name)
		  in: aNode methodNode compiledMethod origin
		  selector: aNode methodNode selector
]

{ #category : 'printing' }
RenameArgumentOrTemporaryMutationOperator >> description [
	
	^ 'Rename all arguments and temporaries found in method body mutation testing'
]

{ #category : 'private' }
RenameArgumentOrTemporaryMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode sourceInterval first to: aNode sourceInterval last with: 'foo' , aNode name
]
