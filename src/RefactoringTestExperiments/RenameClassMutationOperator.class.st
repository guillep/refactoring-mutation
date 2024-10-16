Class {
	#name : 'RenameClassMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameClassMutationOperator >> appliesToNode: aNode [

	| model |
	aNode methodNode compiledMethod isExtension ifTrue: [ ^ false ].
	aNode isGlobalVariable ifFalse: [ ^ false ].
	model := RBNamespace onEnvironment: classEnvironment.
	(model classNamed: aNode name) ifNil: [ ^ false ].

	^ self canRefactor: aNode in: model
]

{ #category : 'instance creation' }
RenameClassMutationOperator >> applyMutation: aMutation [

	| refactoring |
	(aMutation inputFor: #name) ifNil: [ ^ nil ].
	refactoring := ReRenameClassRefactoring
		               model: (RBNamespace onEnvironment: classEnvironment)
		               rename: aMutation data name
		               to: (aMutation inputFor: #name).
	refactoring prepareForExecution.
	aMutation shouldApplyPreconditions ifTrue: [ 
		refactoring checkPreconditions ].
	refactoring privateTransform.
	refactoring performChanges.
]

{ #category : 'testing' }
RenameClassMutationOperator >> canRefactor: aNode in: aModel [

	| refactoring |
	"Check if class is in environment."
	refactoring := ReRenameClassRefactoring
		               model: aModel
		               rename: aNode name
		               to: 'Foo' , aNode name.

	[
	refactoring
		prepareForExecution;
		checkPreconditions ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'mutant generation' }
RenameClassMutationOperator >> cartesianProductForInputs: inputs [
	"I return cartesian product for given inputs. Look at the example bellow."

	"RenameClassMutationOperator new getInputsFromStrategies: ({OrderedCollection new add: (#a -> 1); yourself . OrderedCollection new add: (#b -> 'r'); add: (#b -> 's'); yourself}) >>> {{#a->1. #b->'r'}. {#a->1. #b->'s'}}"

	| arrayOfArray n p cartesianProduct |
	arrayOfArray := inputs.
	n := arrayOfArray size.
	p := arrayOfArray
		     inject: 1
		     into: [ :product :array | product * array size ].
	cartesianProduct := (Array new: p) collect: [ :i | Array new: n ].
	1 to: p do: [ :iSol |
		| packetIndex |
		packetIndex := iSol - 1.
		n to: 1 by: -1 do: [ :iVar |
			| ni valuesOfIVar |
			ni := (valuesOfIVar := arrayOfArray at: iVar) size.
			(cartesianProduct at: iSol)
				at: iVar
				put: (valuesOfIVar at: packetIndex \\ ni + 1).
			packetIndex := packetIndex // ni ] ].
	^ cartesianProduct
]

{ #category : 'printing' }
RenameClassMutationOperator >> description [
	
	^ 'Rename all classes found in method body mutation testing'
]

{ #category : 'private' }
RenameClassMutationOperator >> getInputsForNode: affectedNode [
	"Given a node I return a list of dictionaries where each dictionary contains required inputs for the refactoring."

	| model inputs |
	model := classEnvironment 
		ifNil: [ RBNamespace new ]
		ifNotNil: [ RBNamespace onEnvironment: classEnvironment ].
	inputs := strategies flatCollect: [ :strategy |
		| results |
		results := strategy forNode: affectedNode and: model.
		results collect: [ :r | strategy key -> r ]
	].
	inputs := (inputs groupedBy: [ :assoc | assoc key ]) values.
	inputs := self cartesianProductForInputs: inputs.
	inputs := inputs collect: [ :input | Dictionary newFrom: input  ].
	^ inputs
]

{ #category : 'private' }
RenameClassMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode stop with: 'Foo' , aNode name
]

{ #category : 'mutant generation' }
RenameClassMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| affectedNodes |
	((aCompiledMethod hasPragmaNamed: #ignoreForMutations) or: [
		 aCompiledMethod hasPragmaNamed: #ignoreForCoverage ]) ifTrue: [
		^ #(  ) ].

	affectedNodes := self affectedNodesFor: aParseTree.
	^ ((affectedNodes collectWithIndex: [ :affectedNode :index |
		| inputsList |
		inputsList := self getInputsForNode: affectedNode.
		"We create a mutation for each combination of inputs"
		inputsList collect: [ :inputs |
		  RefactoringMutation
			  for: aCompiledMethod
			  using: self
			  nodeNumber: index
			  ofClass: aCompiledMethod methodClass
			  withData: affectedNode
			  inputs: inputs ] ]) 
		flattened)
		reject: [ :mutant | mutant isNil ]
		"Mutants that are nil have inputs that are nil which would create malformed refactoring"
]
