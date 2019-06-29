#!/usr/bin/env bash

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  NORMAL="$(tput sgr0)"
else
  GREEN=""
  YELLOW=""
  NORMAL=""
fi

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd > /dev/null
}

version_found() {
    APP=$1
    VERSION=$2

    echo "Checking $APP $VERSION"

    if [[ "$(${APP} --version)" == *${VERSION}* ]]; then
        return 0
    fi
    return 1
}

install_app() {
    TGT=$1
    VER=$2

    if ! version_found "${TGT}" "${VER}"; then
        pushd /tmp
        echo "${GREEN}Installing $(basename ${TGT})${NORMAL}"
        $3
        popd
    else
        echo "${YELLOW}Skipping install of $(basename ${TGT})${NORMAL}"
    fi
}



if [[ $OSTYPE == darwin* ]]; then
    OS=darwin
    OS2=osx
    OS3=apple-darwin
elif [[ $OSTYPE == linux* ]]; then
    OS=linux
    OS2=${OS}
    OS3=unknown-linux-musl
fi
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  ARCH=amd64
  ARCH2=x64
  ARCH3=x86_64
else
  ARCH=386
  ARCH2=x32
  ARCH3=i686
fi

# extract - https://github.com/gesquive/extract
VER=v1.1.0
TGT=/usr/local/bin/extract
install_extract() {
    wget -c https://raw.githubusercontent.com/gesquive/extract/${VER}/extract.sh -O ${TGT} \
        && chmod +x ${TGT}
}
install_app "${TGT}" "${VER}" install_extract

# email - https://github.com/gesquive/email
VER=v0.5.1
TGT=/usr/local/bin/email
install_email() {
    wget -c https://github.com/gesquive/email/releases/download/${VER}/email-${VER}-${OS}-${ARCH}.tar.gz \
        && tar -xvzf email-${VER}-${OS}-${ARCH}.tar.gz \
        && install -m 755 ${OS}-${ARCH}/email ${TGT}
}
install_app "${TGT}" "${VER}" install_email

# git-user - https://github.com/gesquive/git-user
VER=v2.0.5
TGT=/usr/local/bin/git-user
install_gituser() {
    if [ ${OS} == darwin ]; then
        brew tap gesquive/git-user https://github.com/gesquive/git-user.git
        brew install gesquive/git-user/git-user
    else
        wget -c https://github.com/gesquive/git-user/releases/download/${VER}/git-user-${VER}-${OS2}-${ARCH2}.tar.gz \
            && tar -xvzf git-user-${VER}-${OS2}-${ARCH2}.tar.gz \
            && ./git-user-${VER}-${OS2}-${ARCH2}/install.sh
    fi
}
install_app "${TGT}" "${VER}" install_gituser

# serve - https://github.com/jpillora/serve
VER=1.7.5
TGT=/usr/local/bin/serve
install_serve() {
    wget -c https://github.com/jpillora/serve/releases/download/${VER}/serve_${OS}_${ARCH}.gz \
        && gunzip -fk serve_${OS}_${ARCH}.gz \
        && install -m 755 serve_${OS}_${ARCH} ${TGT}
}
install_app "${TGT}" "${VER}" install_serve

# forge - https://github.com/gesquive/forge
VER=v0.1.2
TGT=/usr/local/bin/forge
install_forge() {
    wget -c https://github.com/gesquive/forge/releases/download/${VER}/forge-${VER}-${OS}-${ARCH}.tar.gz \
        && tar -xvzf forge-${VER}-${OS}-${ARCH}.tar.gz \
        && install -m 755 forge ${TGT}
}
install_app "${TGT}" "${VER}" install_forge

# ripgrep - https://github.com/BurntSushi/ripgrep
VER=0.7.1
TGT=/usr/local/bin/rg
install_ripgrep() {
    wget -c https://github.com/BurntSushi/ripgrep/releases/download/${VER}/ripgrep-${VER}-${ARCH3}-${OS3}.tar.gz \
        && tar -xvzf ripgrep-${VER}-${ARCH3}-${OS3}.tar.gz \
        && install -m 775 ripgrep-${VER}-${ARCH3}-${OS3}/rg ${TGT} \
        && install ripgrep-${VER}-${ARCH3}-${OS3}/rg.1 /usr/local/share/man/man1/rg.1
}
install_app "${TGT}" "${VER}" install_ripgrep

# lf - https://github.com/gokcehan/lf
VER=nightly
TGT=/usr/local/bin/lf
install_lf() {
    wget -c https://github.com/gokcehan/lf/releases/download/${VER}/lf-${OS}-${ARCH}.tar.gz \
        && tar -xvzf lf-${OS}-${ARCH}.tar.gz \
        && install -m 755 lf ${TGT}
}
install_app "${TGT}" "${VER}" install_lf

# Future possible installs!
# ngrok - https://github.com/inconshreveable/ngrok
# fwd - https://github.com/kintoandar/fwd
# teleconsole - https://github.com/gravitational/teleconsole

# progress - https://github.com/Xfennec/progress
# git-substatus - https://github.com/gesquive/git-substatus
# upto - https://github.com/driv/upto
# lsd - https://github.com/Peltoche/lsd
# uxy - https://github.com/sustrik/uxy
# z - https://github.com/rupa/z
