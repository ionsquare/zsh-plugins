# This file must be sourced after p9k

# TODO check if this actually needs to be exported or not
P9K_PROMPT_VCS=vcs
# ===== Custom shortening of git branch ==========
function +vi-git-modbranch() {
  local branch
  branch=$hook_com[branch]
  branch=$(echo $branch | sed 's@matthewh/\([^/]*\)/.*@\1@g')
  if [[ $hook_com[branch] != "$branch" ]]; then
    hook_com[branch]="[$branch]"
  fi
}

# git-modbranch must be setbefore the p9k theme is sourced
POWERLEVEL9K_VCS_GIT_HOOKS=(git-modbranch vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)
