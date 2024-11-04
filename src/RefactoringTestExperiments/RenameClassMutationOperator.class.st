Class {
	#name : 'RenameClassMutationOperator',
	#superclass : 'SubMethodRefactoringMutationOperator',
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RenameClassMutationOperator >> applyMutation: aMutation [

	aMutation refactoring prepareForExecution.
	aMutation shouldApplyPreconditions ifTrue: [ 
		aMutation refactoring checkPreconditions ].
	aMutation refactoring privateTransform.
	aMutation refactoring performChanges.
]

{ #category : 'printing' }
RenameClassMutationOperator >> description [
	
	^ 'Rename all classes found in method body mutation testing'
]

{ #category : 'private' }
RenameClassMutationOperator >> modifiedSourceFor: aCompiledMethod with: aParseTree number: aNumber newExpression: aNode [

	^ aCompiledMethod sourceCode copyReplaceFrom: aNode start to: aNode stop with: 'Foo' , aNode name
]
