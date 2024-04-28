
rm ~/.bash_profile ~/.bashrc ~/.vimrc ~/.tmux.conf

echo "linking non-OS-specific configs"

ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

if [ "$(uname -s)" = "Darwin" ]; then
    echo "linking alacritty config"
    rm ~/.config/alacritty/alacritty.toml
    rm ~/.config/alacritty/.alacritty.toml
    ln -s ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
fi
    
