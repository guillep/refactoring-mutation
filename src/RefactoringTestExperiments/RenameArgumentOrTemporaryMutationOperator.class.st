Class {
	#name : 'RenameArgumentOrTemporaryMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'mutant generation' }
RenameArgumentOrTemporaryMutationOperator >> createRefactoringWith: aMutant [

	| model aNode name interval |
	model := RBNamespace onEnvironment: classEnvironment.
	aNode := aMutant data.
	"if input is not supplied, take valid values"
	name := (aMutant inputFor: #name) ifNil: [ #uniqueFooName ].
	interval := (aMutant inputFor: #interval) ifNil: [ aNode sourceInterval ].
	^ RBRenameArgumentOrTemporaryRefactoring
		  model: model
		  renameTemporaryFrom: interval
		  to: name
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
