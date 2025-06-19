# dotfiles

GNU `stow` for managing symlinks and `git` for source control. Simple!

## install

- `brew install stow`
- `brew install antidote`

## apply

```bash
git clone git@github.com:samwyma/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

stow [folder-names]
stow bash hyper shell tmux vim zsh
```
