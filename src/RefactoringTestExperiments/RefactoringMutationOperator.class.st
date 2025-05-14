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

{ #category : 'instance creation' }
RefactoringMutationOperator >> appliesToNode: aMutant [
	| aNode refactoring |
	aNode := aMutant data.
	(aNode methodNode compiledMethod origin isKindOf: TraitedMetaclass)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass class)
		ifTrue: [ ^ false ].
	(aNode methodNode compiledMethod origin isKindOf: TraitedClass)
		ifTrue: [ ^ false ].
	aNode methodNode compiledMethod origin isTrait ifTrue: [ ^ false ].

	refactoring := self createRefactoringWith: aMutant.
	refactoring ifNil: [ ^ false ]. "if we cannot create refactoring given node is not applicable"
	aMutant refactoring: refactoring.
	[ aMutant refactoring prepareForExecution ]
		on: RBRefactoringError
		do: [ ^ false ].
	^ true
]

{ #category : 'testing' }
RefactoringMutationOperator >> canRefactor: aRefactoringMutation [

	aRefactoringMutation refactoring ifNil: [ ^ false ]. "if we cannot create refactoring given node is not applicable"
	[
	aRefactoringMutation refactoring
		prepareForExecution;
		checkPreconditions ]
		on: RBRefactoringError , RBRefactoringWarning
		do: [ ^ false ].
	^ true
]

{ #category : 'mutant generation' }
RefactoringMutationOperator >> cartesianProductForInputs: inputs [
	"I return cartesian product for given inputs. Look at the example bellow."

	"RenameClassMutationOperator new cartesianProductForInputs: ({OrderedCollection new add: (#a -> 1); yourself . OrderedCollection new add: (#b -> 'r'); add: (#b -> 's'); yourself}) >>> {{#a->1. #b->'r'}. {#a->1. #b->'s'}}"

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

{ #category : 'mutant generation' }
RefactoringMutationOperator >> createRefactoringWith: aMutation [

	^ self subclassResponsibility 
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
		(strategy appliesToNode: affectedNode)
			ifTrue: [ 
				results := strategy forNode: affectedNode and: model.
				results collect: [ :r | strategy key -> r ] ]
			ifFalse: [ OrderedCollection with: strategy key -> nil ]
	].
	inputs := (inputs groupedBy: [ :assoc | assoc key ]) values.
	inputs := self cartesianProductForInputs: inputs.
	inputs := inputs collect: [ :input | Dictionary newFrom: input  ].
	^ inputs
]

{ #category : 'mutant generation' }
RefactoringMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| mutants |
	((aCompiledMethod hasPragmaNamed: #ignoreForMutations) or: [
		 aCompiledMethod hasPragmaNamed: #ignoreForCoverage ]) ifTrue: [
		^ #(  ) ].
	
	mutants := (aParseTree allChildren collectWithIndex: [ :aNode :index |
		| inputsList |
		inputsList := self getInputsForNode: aNode.
		"We create a mutation for each combination of inputs"
		inputsList collect: [ :inputs |
		  RefactoringMutation
			  for: aCompiledMethod
			  using: self
			  nodeNumber: index
			  ofClass: aCompiledMethod methodClass
			  withData: aNode
			  inputs: inputs ]])
		flattened.
	mutants := mutants select: [ :mutant |
		(self appliesToNode: mutant) and: [ mutant refactoring isNotNil ]
	].
	mutants := mutants select: [ :mutant |
		self canRefactor: mutant
	].
	^ mutants
]

{ #category : 'accessing' }
RefactoringMutationOperator >> strategies: strategiesList [

	strategies := strategiesList
]
