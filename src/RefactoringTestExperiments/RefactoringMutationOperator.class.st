Class {
	#name : 'RefactoringMutationOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
	#instVars : [
		'classEnvironment',
		'strategies'
	],
	#classInstVars : [
		'blackListClasses',
		'blackListMethodNames'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'black list' }
RefactoringMutationOperator class >> blackListClasses [

	^ blackListClasses ifNil: [ blackListClasses := { Object . Collection withAllSubclasses . Boolean withAllSubclasses . DateAndTime withAllSubclasses . SystemVersion } flattened ]
	
]

{ #category : 'black list' }
RefactoringMutationOperator class >> blackListMethodNames [

	^ blackListMethodNames ifNil: [ 
		blackListMethodNames := self blackListClasses flatCollectAsSet: 
			[ :cls |  cls selectors , cls class selectors ] ]
]

{ #category : 'testing' }
RefactoringMutationOperator class >> isAbstract [

	^ self == RefactoringMutationOperator
]

{ #category : 'class initialization' }
RefactoringMutationOperator class >> reset [
	<script>
	blackListClasses := nil.
	blackListMethodNames := nil
]

{ #category : 'mutant generation' }
RefactoringMutationOperator >> cartesianProductForInputs: inputs [
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

{ #category : 'accessing' }
RefactoringMutationOperator >> classEnvironment: aRBEnvironment [

	classEnvironment := aRBEnvironment 
]

{ #category : 'private' }
RefactoringMutationOperator >> getInputsForNode: affectedNode [
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

{ #category : 'mutant generation' }
RefactoringMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

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

{ #category : 'accessing' }
RefactoringMutationOperator >> strategies: strategiesList [

	strategies := strategiesList
]
