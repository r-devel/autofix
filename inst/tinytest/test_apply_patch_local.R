parent <- tempdir()
withr::with_options(list(
  "git.user.name" = "Tester Tommy",
  "git.user.email" = "tester"
),
withr::with_tempdir(
  parent,
  {
    itemize_line <- 9
    file <- "man/hello.Rd"
    tmp_dir <- parent
    test_pkg_name <- "brokenitemize"

    patch_function <- function(repo_path){
      pattern <- "\\\\itemize"
      R_lines <- readLines(file.path(repo_path, file))
      expect_match(R_lines[itemize_line], pattern, info = "Expect issue to fix does not exist.")
      R_lines[itemize_line] <- gsub(pattern, "\\\\describe", R_lines[itemize_line])
      writeLines(R_lines, file.path(file.path(repo_path, file)))
      return(TRUE)
    }

    apply_patch_local(
      repo_url = "git@github.com:Rautofix/brokenitemize.git",
      issue_id = "itemize",
      patch_function = patch_function,
      repo_parent_dir = parent
    )
    expect_false(
      any(grepl("\\\\itemize", readLines(file.path(tmp_dir, test_pkg_name, file))))
    )
  }
)
)