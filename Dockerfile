FROM ubuntu:latest

# For tzdata
ENV DEBIAN_FRONTEND="noninteractive" TZ="Asia/Shanghai"

COPY cargo-config /root/.cargo/config
COPY init.vim /root/.config/nvim/init.vim
COPY install.vim .

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get upgrade \
	# dev tools
	zsh git curl net-tools -y \
	# language tools
	llvm ccls clang golang -y \
	# oh my zsh
	&& sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
	&& git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
	&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
	&& sed -i 's/plugins=(git)/plugins=(git cp history z rsync colorize nvm zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc \
	# golang
	&& go env -w GO111MODULE=on \
	&& go env -w GOPROXY="https://goproxy.cn,direct" \
	# rust
	&& export RUSTUP_DIST_SERVER="https://rsproxy.cn" && export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup" \
	&& curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh -s -- -q -y \
	&& curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > /usr/bin/rust-analyzer && chmod +x /usr/bin/rust-analyzer \
	# neovim 
	&& curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && chmod u+x nvim.appimage \
	&& ./nvim.appimage --appimage-extract \
	&& ./squashfs-root/AppRun --version \
	&& ln -s /squashfs-root/AppRun /usr/bin/nvim \
	&& nvim -es -u install.vim -i NONE -c "PlugInstall" -c "qa"

