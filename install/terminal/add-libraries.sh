echo -e "Installing required libraries..." 

sudo dnf install -yq \
  make automake gcc gcc-c++ make kernel-devel \
  pkgconf autoconf bison clang openssl-devel bzip2-devel \
  openssl-devel zlib-devel libyaml-devel libffi-devel \
  readline-devel ncurses-devel ncurses-libs mupdf breezy \
  git-delta git-subtree libvirt vim-enhanced --skip-broken > /dev/null 2>&1
