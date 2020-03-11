# nvim
new vim files for vim8 and neovim


## checkout on new machine

```bash
cd ~  
git clone --depth 1 https://github.com/volksen/vim.git ~/.vim   
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/vimrc ~/.gvimrc
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac  
vim -N -c "PackUpdate" -c "q!"
```
