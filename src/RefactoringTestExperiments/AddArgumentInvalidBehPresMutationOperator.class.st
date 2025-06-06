Class {
	#name : 'AddArgumentInvalidBehPresMutationOperator',
	#superclass : 'AddArgumentMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'mutant generation' }
AddArgumentInvalidBehPresMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutations |
	mutations := super mutationsFor: aCompiledMethod with: aParseTree.
	"Checks applicability but skips behavior preserving ones"
	mutations do: [ :e | e doNotCheckBehaviorPreserving ].
	^ mutations
]
