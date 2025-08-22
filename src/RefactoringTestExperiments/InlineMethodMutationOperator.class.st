Class {
	#name : 'InlineMethodMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'mutant generation' }
InlineMethodMutationOperator >> createRefactoringWith: aMutation [

	| refactoring options model interval |
	interval := (aMutation strategy forNode: aMutation data and: model) ifNil: [ ^ nil ].
	model := RBNamespace new. "We have to operate on the entire system since Inline Method depends on superclasses which can be Object, Collection, etc."
	"IF we scope it to a package or list of classes, that scope should include every superclass of every class that you want to inline."
	refactoring := RBInlineMethodRefactoring
						  model: model
		               inline: interval
		               inMethod: aMutation originalMethod selector
		               forClass: aMutation originalMethod methodClass name.

	options := refactoring options copy.
	options at: #shouldNotCreateExtraBindings put: [ :a :b | false ].
	refactoring options: options.
	^ refactoring
]

{ #category : 'printing' }
InlineMethodMutationOperator >> description [
	
	^ 'Inline a message send'
]

{ #category : 'instance creation' }
InlineMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode sourceInterval first to: aNode sourceInterval last with: ' INLINED '
]
