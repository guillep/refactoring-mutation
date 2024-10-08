Class {
	#name : 'RefactoringMutationOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
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

{ #category : 'class initialization' }
RefactoringMutationOperator class >> reset [
	<script>
	blackListClasses := nil.
	blackListMethodNames := nil
]
