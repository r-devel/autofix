#' @importFrom gert git_clone git_branch_create git_commit git_signature git_branch_checkout
#' @importFrom remotes parse_github_url
apply_patch_local <- function(
  repo_url, issue_id, patch_function, repo_parent_dir
) {
  clone_path <- file.path(repo_parent_dir, parse_github_url(repo_url)$repo)
  if (! dir.exists(clone_path)) git_clone(repo_url, clone_path)
  git_branch_checkout("main", repo=clone_path) #tmp to allow deletetion of other branches
  git_branch_create(
    branch = issue_id,
    checkout = TRUE,
    force = TRUE,
    repo = clone_path
  )
  did_patch <- patch_function(clone_path)
  if(did_patch) git_commit_all(
    glue::glue("fix {issue_id}"),
    author = if(!is.null(options("git.user.name"))) git_signature(
      options("git.user.name")$git.user.name,
      options("git.user.email")$git.user.email
    ) else NULL
  )
  return(clone_path)
}