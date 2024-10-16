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

{ #category : 'accessing' }
RefactoringMutationOperator >> classEnvironment: aRBEnvironment [

	classEnvironment := aRBEnvironment 
]

{ #category : 'accessing' }
RefactoringMutationOperator >> strategies: strategiesList [

	strategies := strategiesList
]
