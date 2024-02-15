Class {
	#name : 'ExtractMethodMutationOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	| selected statementSubsequences |
	selected := aParseTree body allChildren select: [ :aNode |
		            self appliesToNode: aNode ].
	(self appliesToNode: aParseTree body) ifTrue: [
		selected add: aParseTree body ].

	statementSubsequences := OrderedCollection new.
	selected select: [ :e | e isSequence ] thenDo: [ :seq |
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

	^ selected , statementSubsequences
]

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> appliesToNode: aNode [

	(aNode methodNode compiledMethod origin isKindOf: TraitedMetaclass)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass class)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass)
		ifTrue: [ ^ false ].
	aNode methodNode compiledMethod origin isTrait ifTrue: [ ^ false ].
	aNode sourceInterval ifEmpty: [ ^ false ].

	1 haltIf: [
		aNode methodNode compiledMethod origin isKindOf: TraitedClass ].

	^ self canRefactor: aNode
]

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> canRefactor: aNode [

	| refactoring options |
	refactoring := RBExtractMethodRefactoring
		               extract: aNode sourceInterval
		               from: aNode methodNode selector
		               in: aNode methodNode methodClass name.

	options := refactoring options copy.
	options at: #methodName put: [ :aMethodName :ref |
		1 halt.
		aMethodName
			selector: #foo;
			yourself ].
	options at: #extractAssignment put: [ :a :b | true ].
	refactoring options: options.

	[
	refactoring prepareForExecution.
	refactoring checkPreconditions ]
		on: RBRefactoringError , RBRefactoringWarning
		do: [ ^ false ].
	^ true
]

{ #category : 'printing' }
ExtractMethodMutationOperator >> description [
	
	^ 'Extract an expression/statement from the method into a separate method'
]

{ #category : 'instance creation' }
ExtractMethodMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [


	^ aCompiledMethod sourceCode copyReplaceFrom: aNode first to: aNode last with: ' EXTRACTED '
]

{ #category : 'private' }
ExtractMethodMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| affectedNodes |
	((aCompiledMethod hasPragmaNamed: #ignoreForMutations) or: [
		 aCompiledMethod hasPragmaNamed: #ignoreForCoverage ]) ifTrue: [
		^ #(  ) ].

	affectedNodes := self affectedNodesFor: aParseTree.
	^ affectedNodes collectWithIndex: [ :affectedNode :index |
		  ExtractMethodMutation
			  for: aCompiledMethod
			  using: self
			  nodeNumber: index
			  ofClass: aCompiledMethod methodClass
			  withData: affectedNode sourceInterval ]
]

{ #category : 'private' }
ExtractMethodMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree number: nodeIndex storeIn: accumulator [

	| affectedNode |
	self error.
	affectedNode := self affectedNodeFor: aParseTree at: nodeIndex.

	accumulator add: (ExtractMethodMutation
			 for: aCompiledMethod
			 using: self
			 nodeNumber: nodeIndex
			 ofClass: aCompiledMethod methodClass
			 withData: affectedNode sourceInterval).
	^ accumulator
]
