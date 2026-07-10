library(autofix)

#TODO:
# Rename issue_id to note_category
# Fresh repo or rename to autofix

options("git.user.name") <- "Autofix Bot"
options("git.user.email") <- "katrinabrock266@gmail.com"

potential_patches <- identify_patchable_pkgs()

lapply(seq_len(nrow(potential_patches)), \(i){
  apply_patch_remote(
    potential_patches[i, "source_url"],
    potential_patches[i, "issue_id"],
    patch_functions[[potential_pathes[i, "issue_id"]]]
  )
})
