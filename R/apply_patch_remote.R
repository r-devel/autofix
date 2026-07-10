apply_patch_remote <- function(source_url, issue_id, patch_function,
fork_repo_name = extract_gh_reponame_from_url(repo_url),
org = "Rautofix", create_pr = FALSE) {
  fork_url <- gh_fork(source_url, org)
  apply_patch_local(fork_url, issue_id, patch_function)
  gh_push_branch(clone_path, fork_url, issue_id)
  if (create_pr) {
    gh_open_pr(
      description = "This is an automatically opened PR.",
      fork_url,
      source_url,
      issue_id
    )
  } else {
    print(generate_gh_pr_url())
  }
}