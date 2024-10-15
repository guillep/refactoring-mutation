Class {
	#name : 'RenameArgumentOrTemporaryMultipleIntervalsMutationOperator',
	#superclass : 'RenameArgumentOrTemporaryMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'mutant generation' }
RenameArgumentOrTemporaryMultipleIntervalsMutationOperator >> applyMutation: aMutation [

	| refactoring name node |
	node := (aMutation data at: #node).
	refactoring := RBRenameArgumentOrTemporaryRefactoring
		  model: (RBNamespace onEnvironment: classEnvironment)
		  renameTemporaryFrom: (aMutation data at: #interval)
		  to: ''
		  in: node methodNode compiledMethod origin
		  selector: node methodNode selector.
	name := self nameStrategyFor: node and: refactoring.
	refactoring newName: name.
	
	refactoring execute
]

{ #category : 'mutant generation' }
RenameArgumentOrTemporaryMultipleIntervalsMutationOperator >> createRefactoringWith: aNode on: aModel [

	| refactoring name |
	refactoring := RBRenameArgumentOrTemporaryRefactoring
		  model: aModel
		  renameTemporaryFrom: aNode sourceInterval "here we set good one, but we will send bad when applying"
		  to: ''
		  in: aNode methodNode compiledMethod origin
		  selector: aNode methodNode selector.
	name := self nameStrategyFor: aNode and: refactoring.
	name ifNil: [ ^ nil ].
	refactoring newName: name.
	^ refactoring
]

{ #category : 'mutant generation' }
RenameArgumentOrTemporaryMultipleIntervalsMutationOperator >> mutationsFor: aCompiledMethod with: aParseTree [

	| affectedNodes |
	((aCompiledMethod hasPragmaNamed: #ignoreForMutations) or: [
		 aCompiledMethod hasPragmaNamed: #ignoreForCoverage ]) ifTrue: [
		^ #(  ) ].

	affectedNodes := self affectedNodesFor: aParseTree.
	^ (affectedNodes collectWithIndex: [ :affectedNode :index |
		(sourceIntervalStrategy forNode: affectedNode) collect: 
			[ :interval |
				| data |
			 	data := Dictionary new.
			 	data at: 'node' put: affectedNode.
			 	data at: 'interval' put: interval.
			  	RefactoringMutation
					for: aCompiledMethod
					using: self
					nodeNumber: index
					ofClass: aCompiledMethod methodClass
				 	withData: data ] ]) flattened
]
