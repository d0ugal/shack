set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

# Status Chars
set __fish_git_prompt_char_dirtystate '+'
set __fish_git_prompt_char_stashstate '↩'


function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  if set -q VIRTUAL_ENV
    printf ' ('
    set_color 777777
    printf '%s' (basename "$VIRTUAL_ENV")
    set_color yellow
    printf '::'
    set_color 777777
    printf '%s' (expr substr (python --version 2>&1) 8 20)
    set_color normal
    printf ')'
  end

  printf '%s ' (__fish_git_prompt)

  set_color normal
end

function dirclean
  git clean -fxd
  find . -type f -name "*.py[co]" -delete -print
  find . -path '*/__pycache__/*' -delete -print
  find . -type d -name "__pycache__" -delete -print
  find . -path '*/.tox/*' -delete -print
  find . -type d -name ".tox" -delete -print
end

function venv-new
  if set -q argv[2]
    pyenv virtualenv $argv
    venv-activate $argv[2]
  else if set -q argv[1]
    pyenv virtualenv (expr substr (python --version 2>&1) 8 20) $argv
    venv-activate $argv[1]
  else
    echo "Pass '$version $name' or '$name'"
  end
end

function venv-activate
  pyenv activate $argv
end

function venv-deactivate
  pyenv deactivate $argv
  venv-tmp-cleanup
end

function venv-rm
  echo "Uninstalling $argv"
  pyenv uninstall -f $argv
end

function venv-ls
  for val in (pyenv versions | grep envs)
    echo (basename $val)
  end
end

function venv-tmp2
  set venv_tmp_name "tmp-"(random)
  pyenv virtualenv (expr substr (python2 --version 2>&1) 8 20) $venv_tmp_name
  venv-activate $venv_tmp_name
end

function venv-tmp
  set venv_tmp_name "tmp-"(random)
  pyenv virtualenv (expr substr (python --version 2>&1) 8 20) $venv_tmp_name
  venv-activate $venv_tmp_name
end

function venv-tmp-cleanup
  for val in (pyenv versions | grep "/envs/tmp-")
    venv-rm (basename $val)
  end
end

set -x PATH "$HOME/.pyenv/bin" "$HOME/bin" "$HOME/.local/bin" "$HOME/.local/bin-2.7" "/usr/local/heroku/bin" "$HOME/go/bin" $PATH
set -x EDITOR "nvim"
alias vim nvim
alias vimdiff "nvim -d"

status --is-interactive; and source (pyenv init -|psub)

source (pyenv virtualenv-init - | psub)
