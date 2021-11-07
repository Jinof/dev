# DEV

> This is a repo for dev docker which contains pre installed dev enviroment

## Now supportted dev environments

- [x] oh my zsh (with zsh-autosuggestions zsh-syntax-highlighting)
- [x] neovim (support lsp with nvim-lspconfig using gopls, rust-analyzer, ccls))
- [x] golang
- [x] rust

## Usage

```bash
docker pull jinof/dev:latest
docker run --name dev -v path/to/source:/root/source -it jinof/dev:latest /bin/zsh
```
Next time you want to open your container

```bash
docker exec -it dev /bin/zsh
```
