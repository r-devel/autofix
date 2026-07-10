# auto_fix_cran_notes

## Overall Workflow

`autofix_all.R` should create fixed branches for all notes that are configured to be fixable automatically.

### Step 1: identify packages with fixable issues

`identify_patchable_packages` should return dataframe with two columns: `note_category` and `repo_url`. `note_category` is the unique id of the fixable note (e.g. `itemize`)

### Step 2: clone-fix-push

This logic work is handled by `apply_patch_local`.

`apply_patch_local` clones a repo, runs the patch function, and commits.

It assumes that for each `note_category` there exists a "patch function" that takes as an input the local path of the source code for a package that has this type of issue. The "patch function" edits the source code in such a way to eliminate the note. The `patch_functions` object will be a list of of such functions with names corresponding to the `note_category` that a patch function applies to.

### Step 3: auto PR or PR link

`apply_patch_remote` forks, pushs the fix to the fork, and either creates
a PR against the main package repo or generates a URL that allows
a human to create such a PR.

## Work Items 0->1 Autopatchable Notes

This section lists everything that needs to be done to make one note (`itemize`) autofixable.

### Git/Github Automation

- [ ] Rename issue_id to note_category throughout code.
- [ ] Get `apply_patch_local` fully working (Such that the test in `test_apply_patch_local` is passing.)
- [ ] Get `apply_patch_remote` working (automated testing might need mocking)
- [ ] Modify `autofix_all.R` so it runs without error.
- [ ] Create a github action to run `autofix_all.R`

### Patching

Work in progress toward these goals can be found at: https://github.com/r-devel/auto_fix_cran_notes

- [ ] **Build `identify_patchable_packages`** Put existing logic to identify packages with `itemize` issue that can be fixed automatically
- [ ] **Create `patch_functions` list** create a list of length 1 where the value of the element is 
- [ ] **Create a working `fix_itemize` function** This function should take as an input the path to a local copy of the package source and modify that source to fix the `itemize` issue. If a fix was successfully applied, it should return `TRUE`. If not (e.g. if the issue was already fixed), it should return `FALSE`.


## Adding Autopatchable note categories

Steps to make a new note autopatchable (once there is at least one)

- **Hard Part:** Develop a patch function that fixes the issue on local source files for an arbitary impacted package.
- Add the new patch function to this repo (ideally along with appropriate tests)
- Add the the new patch function to the patch_functions list
- Modify `identify_patchable_packages` function so it includes packages impacted by the newly autopatchable function in its return dataframe.


## Additional Possible Features

- Support git hosts beyond github.
