# refactoring-mutation

## Examples

You can use `ExtractMethodMutationOperator` and `ExtractMethodNoPreconditionMutationOperator` as follows.

```smalltalk
testClasses := { UUIDPrimitivesTest }.
classesToMutate := {
	                   UUID.
	                   UUIDGenerator }.

analysis := MTAnalysis new
	            classesToMutate: classesToMutate;
	            testClasses: testClasses;
	            operators: { ExtractMethodMutationOperator new }.

analysis run.

"To inspect the results"
analysis generalResult inspect
```

```smalltalk
testClasses := { UUIDPrimitivesTest }.
classesToMutate := {
	                   UUID.
	                   UUIDGenerator }.

analysis := MTAnalysis new
	            classesToMutate: classesToMutate;
	            testClasses: testClasses;
	            operators: { ExtractMethodNoPreconditionMutationOperator new }.

analysis run.

"To inspect the results"
analysis generalResult inspect
```

## ExtractMethodMutationOperator
It is a semantic preserving mutation that systematically applies an extract method on each node it can.
As it is semantic preserving, it should not break any tests.
This means
 - alive mutants mean *the refactoring works well for this case*
 - killed mutants mean *there is a bug in the refactoring implementation*
 - terminated mutant (the mutant could not be installed and run) *there is a bug in the refactoring implementation*


## ExtractMethodNoPreconditionMutationOperator
It is a non-semantic preserving mutation that systematically applies an extract method on each node where it should not.
For this, we take into account refactoring preconditions.
If preconditions are met then we do not apply the refactoring.
If preconditions are not met we apply the refactoring.

As it is non-semantic preserving, it behaves as normal mutations during mutation analysis.
This means
 - alive mutants mean that either
    - a test is missing
    - or the code is equivalent (for example, if the extraction is on dead code)
    - or the refactoring precondition is more conservative than it should (the refactoring is actually ok to perform but was being cancelled by a very conservative precondition)
 - killed mutants mean that preconditions protect us from a runtime mis-behavior. *the refactoring precondition is ok and prevents breaking the code in this way*
 - terminated mutant (the mutant could not be installed and run) protect us from a compile-time mis-behavior. *the refactoring precondition is ok and prevents breaking the code in this way*

