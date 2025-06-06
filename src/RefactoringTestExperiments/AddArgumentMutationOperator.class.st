Class {
	#name : 'AddArgumentMutationOperator',
	#superclass : 'RefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'private' }
AddArgumentMutationOperator >> affectedNodesFor: aParseTree [
	"Redefine to only affect nodes in the body"

	| selected |
	selected := aParseTree body allChildren select: [ :aNode |
		            self appliesToNode: aNode ].
	(self appliesToNode: aParseTree methodNode) ifTrue: [
		selected add: aParseTree methodNode ].

	^ selected
]

{ #category : 'instance creation' }
AddArgumentMutationOperator >> applyMutation: aMutation [

	| failing |
	aMutation refactoring prepareForExecution.
	aMutation shouldCheckApplicability ifTrue: [
			failing := aMutation refactoring failedApplicabilityPreconditions.
			aMutation failedApplicabilityPreconditions: failing.
			failing ifNotEmpty: [ RBRefactoringError signal ].
			aMutation shouldCheckBehaviorPreserving ifTrue: [
					failing := aMutation refactoring
						           failedBreakingChangePreconditions.
					aMutation failedBehaviorPreservingPreconditions: failing.
					failing ifNotEmpty: [ RBRefactoringWarning signal ] ] ].
	aMutation refactoring privateTransform.
	aMutation refactoring performChanges
]

{ #category : 'refactoring' }
AddArgumentMutationOperator >> createRefactoringWith: aMutation [

	(aMutation inputFor: #methodName) ifNil: [ ^ nil ].
	(aMutation inputFor: #permutations) ifNil: [ ^ nil ].	
	^ RBAddParameterRefactoring 
		  model: (RBNamespace onEnvironment: classEnvironment)
		  addParameterToMethod: aMutation data selector
		  in: aMutation data compiledMethod origin
		  newSelector: (aMutation inputFor: #methodName)
		  permutation: (aMutation inputFor: #permutations)
		  newArgs: { RBArgumentName name: 'aFoo' value: 'nil' }.
]

{ #category : 'printing' }
AddArgumentMutationOperator >> description [
	
	^ 'Add argument to every method'
]

{ #category : 'private' }
AddArgumentMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	| sep |
	sep := aCompiledMethod selector isUnary ifTrue: [ '' ] ifFalse: [ ' ' ].
	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode selectorAndArgumentNames size with: aNode selectorAndArgumentNames , sep , 'foo: aFoo'
]
