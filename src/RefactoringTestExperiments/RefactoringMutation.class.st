Class {
	#name : 'RefactoringMutation',
	#superclass : 'MTMethodMutation',
	#instVars : [
		'shouldApplyPreconditions'
	],
	#category : 'RefactoringTestExperiments-Core',
	#package : 'RefactoringTestExperiments',
	#tag : 'Core'
}

{ #category : 'installing' }
RefactoringMutation >> doNotApplyPreconditions [

	shouldApplyPreconditions := false
]

{ #category : 'installing' }
RefactoringMutation >> initialize [

	super initialize.
	shouldApplyPreconditions := true
]

{ #category : 'installing' }
RefactoringMutation >> install [

	operator applyMutation: self
]

{ #category : 'accessing' }
RefactoringMutation >> shouldApplyPreconditions [

	^ shouldApplyPreconditions
]

{ #category : 'installing' }
RefactoringMutation >> uninstall [

	"super uninstall."
	RBRefactoryChangeManager instance undoLastRefactoring.
	"since we reuse the same model between refactorings, we need to clean it on uninstall"
	operator reinitializeModel
]
