#! /usr/bin/env bash

APT_PACKAGES=(
    build-essential
    curl
    fd-find
    lolcat
    neovim
    ripgrep
    snapd
    xsel
    xclip
)

main_dir()
{
    dirname "$(readlink -f "${BASH_SOURCE}")"
}

log()
{
    echo -e "$@"
}

succeed_or_failed()
{
    if [ "$1" -eq 0 ]; then
        log "\e[32m...Succeed\e[0m"
    else
        log "\e[31m...Failed\e[0m"
        exit "$1"
    fi
}

create_backup()
{
    local subject="$1"

    log "> Create backup of: ${subject}"
    cp -fa "${subject}" "${subject}.bak"
    succeed_or_failed "$?"
}

create_link()
{
    local source="$1"
    local target="$2"

    log "> Create symlink from: ${source} to ${target}"
    mkdir -p "$(dirname "${target}")"
    ln -sf "${source}" "${target}"
    succeed_or_failed "$?"
}

snap_is_installed()
{
    local snap="$1"

    sudo snap list | tail -n +2 | cut -d ' ' -f1 | grep -qPoe "^${snap}\$"
}

snap_install_or_refresh()
{
    local snap="$1"
    shift

    log "> Install or refresh snap: ${snap}"
    if snap_is_installed "${snap}"; then
        sudo snap refresh "${snap}"
    else
        sudo snap install "${snap}" "$@"
    fi
    succeed_or_failed "$?"
} 

apt_repository_exists()
{
    local repository="$1"

    add-apt-repository -L | grep -q "^deb .*${repository/ppa:/}"
}

apt_add_repository()
{
    local repository="$1"

    apt_repository_exists "${repository}" || {
        log "> Add PPA: ${repository}"
        sudo add-apt-repository -y "${repository}" &> /dev/null
        succeed_or_failed "$?"
    }
}

apt_refresh_cache()
{
    log "> Refresh Apt cache"
    sudo apt-get update &> /dev/null
    succeed_or_failed "$?"
}

apt_install_or_upgrade_packages()
{
    local packages=( $@ )

    for package in "${packages[@]}"; do
        log "> Install or upgrade package: ${package}"
        sudo apt-get install -y "${package}" &> /dev/null
        succeed_or_failed "$?"
    done
}

symlink_tmux()
{
    local paths=(
        "${HOME}"
        "${HOME}/.byobu"
    )

    for path in "${paths[@]}"; do
        [ -e "${path}/.tmux.conf" ] && {
            create_backup "${path}/.tmux.conf"

            create_link "$(main_dir)"/static/.tmux.conf "${path}"
        }
    done
}

neovim_symlink_config()
{
    local install_path="${HOME}"/.config/nvim

    [ ! -e "${install_path}" ] || create_backup "${install_path%/*}"
    unlink "${install_path}"
    create_link "$(main_dir)" "${install_path}"
}

neovim_as_default_editor()
{
    local exitcode=0
    local status=0

    log "> Set Neovim as default editor"
    sudo update-alternatives --quiet --install /usr/bin/vi vi /usr/bin/nvim 60 &> /dev/null
    status=$?
    exitcode=$((exitcode + status))
    sudo update-alternatives --quiet --skip-auto --config vi &> /dev/null
    status=$?
    exitcode=$((exitcode + status))
    sudo update-alternatives --quiet --install /usr/bin/vim vim /usr/bin/nvim 60 &> /dev/null
    status=$?
    exitcode=$((exitcode + status))
    sudo update-alternatives --quiet --skip-auto --config vim &> /dev/null
    status=$?
    exitcode=$((exitcode + status))
    sudo update-alternatives --quiet --install /usr/bin/editor editor /usr/bin/nvim 60 &> /dev/null
    status=$?
    exitcode=$((exitcode + status))
    sudo update-alternatives --quiet --skip-auto --config editor &> /dev/null
    status=$?
    exitcode=$((exitcode + status))
    succeed_or_failed "${exitcode}"

}

neovim_install()
{
    symlink_tmux
    neovim_symlink_config
    apt_add_repository "ppa:neovim-ppa/unstable"
    apt_refresh_cache    
    apt_install_or_upgrade_packages "${APT_PACKAGES[@]}"
    # snap_install_or_refresh "nvim" --edge --classic
    neovim_as_default_editor    
}

####

neovim_install
