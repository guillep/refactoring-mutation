"
I am a mutation specifically designed for testing refactorings.
My `install` method will apply the refactoring on the system, and my `uninstall` will undo the last applied refactoring.
In addition, I have `shouldApplyPreconditions` flag which you can use to tell me wether I should check preconditions when executing.
This flag is used when you want to test if refactoring preconditions are overrly strong or to find preconditions that don't exist by executing the refactoring even though refactoring itself can say that you should not do it.
"
Class {
	#name : 'RefactoringMutation',
	#superclass : 'MTMethodMutation',
	#instVars : [
		'shouldApplyPreconditions',
		'inputs',
		'refactoring'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
RefactoringMutation class >> for: aCompiledMethod using: anOperator nodeNumber: anInteger ofClass: aClass withData: aNode inputs: aCollection [

	^ (self
		  for: aCompiledMethod
		  using: anOperator
		  nodeNumber: anInteger
		  ofClass: aClass
		  withData: aNode)
		  inputs: aCollection;
		  yourself
]

{ #category : 'installing' }
RefactoringMutation >> doNotApplyPreconditions [

	shouldApplyPreconditions := false
]

{ #category : 'installing' }
RefactoringMutation >> initialize [

	super initialize.
	shouldApplyPreconditions := true
]

{ #category : 'as yet unclassified' }
RefactoringMutation >> inputFor: aSymbol [ 

	^ inputs at: aSymbol
]

{ #category : 'accessing' }
RefactoringMutation >> inputs: aDictionary [

	inputs := aDictionary
]

{ #category : 'installing' }
RefactoringMutation >> install [

	operator applyMutation: self
]

{ #category : 'accessing' }
RefactoringMutation >> refactoring [

	^ refactoring
]

{ #category : 'accessing' }
RefactoringMutation >> refactoring: aRefactoring [

	refactoring := aRefactoring 
]

{ #category : 'accessing' }
RefactoringMutation >> shouldApplyPreconditions [

	^ shouldApplyPreconditions
]

{ #category : 'installing' }
RefactoringMutation >> uninstall [

	"super uninstall."
	RBRefactoryChangeManager instance undoLastRefactoring.
]
