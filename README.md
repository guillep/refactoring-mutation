# Equivalence Modulo Refactoring Testing for Pharo's Refactoring Engine

This project contains mutation operators and scripts for utilising mutation-testing refactoring behavior in Pharo using MuTalk.

## Requirements

- Pharo (this code is typically used with recent Pharo versions)
- Metacello

## Load (file-based)

1. Obtain the project sources (e.g., unzip the artifact or copy the folder).
2. In Pharo, load from the local `src/` directory:

```smalltalk
Metacello new
  baseline: 'RefactoringTestExperiments';
  repository: 'tonel:///path/to/refactoring-mutation/src';
  load.
```

Notes:

- The repository uses Tonel format (`.class.st` files), hence the `tonel://` URL.
- Replace `/path/to/refactoring-mutation/src` with the local path on your machine.

## Run the provided scripts (per target project)

Most experiments in this project are meant to be executed via script classes.

- Scripts live on the class side of subclasses of `RefactoringMutationTestingScripts`.
- There is one scripts class per target project (see classes named like `*RefactoringMutationTestingScripts`).
- You can run everything for a project (`runAll`) or a single refactoring script (for example `runExtractMethod`, `runInlineMethod`, `runRenameMethod`, ...).
- Each script writes a CSV report to the image directory (next to the `.image` file) with a name like `<label>-Refazzing.csv`.

Example (evaluate in a Playground):

```smalltalk
"Run all refactoring experiments for one target project"
AVLRefactoringMutationTestingScripts runAll.

"Or run a single refactoring experiment"
AVLRefactoringMutationTestingScripts runExtractMethod.
```

## Example: run an analysis programmatically

You can use `ExtractMethodMutationOperator` and `ExtractMethodNoPreconditionMutationOperator` as follows:

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

"Inspect results"
analysis generalResult inspect.
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

"Inspect results"
analysis generalResult inspect.
```
