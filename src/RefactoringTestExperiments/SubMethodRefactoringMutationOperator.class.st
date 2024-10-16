Class {
	#name : 'SubMethodRefactoringMutationOperator',
	#superclass : 'RefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
SubMethodRefactoringMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	| selected |
	selected := aParseTree body allChildren select: [ :aNode |
		            self appliesToNode: aNode ].
	(self appliesToNode: aParseTree body) ifTrue: [
		selected add: aParseTree body ].

	^ selected , (self allSubsequencesOf: selected)
]

{ #category : 'instance creation' }
SubMethodRefactoringMutationOperator >> allSubsequencesOf: sequences [

	| statementSubsequences |
	statementSubsequences := OrderedCollection new.
	sequences select: [ :e | e isSequence ] thenDo: [ :seq |
		2 to: seq statements size do: [ :size |
			0 to: size - 1 do: [ :delta |
				| subsequences |
				subsequences := ((seq statements allButFirst: delta) groupsOf:
					                 size)
					                select: [ :e | e size = size ]
					                thenCollect: [ :statementSubsequence |
						                statementSubsequence first parent copy
							                statements:
							                (statementSubsequence collect: #copy) ].
				subsequences
					select: [ :each | self appliesToNode: each ]
					thenDo: [ :each | statementSubsequences add: each ] ] ] ].
	^ statementSubsequences
]

{ #category : 'instance creation' }
SubMethodRefactoringMutationOperator >> appliesToNode: aNode [

	(aNode methodNode compiledMethod origin isKindOf: TraitedMetaclass)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass class)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass)
		ifTrue: [ ^ false ].
	aNode methodNode compiledMethod origin isTrait ifTrue: [ ^ false ].
	aNode sourceInterval ifEmpty: [ ^ false ].

	^ self canRefactor: aNode
]

{ #category : 'testing' }
SubMethodRefactoringMutationOperator >> canRefactor: aNode [

	^ self subclassResponsibility
]

{ #category : 'printing' }
SubMethodRefactoringMutationOperator >> description [
	^ 'Sub method refactoring mutation operator'
]
