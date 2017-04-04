#! /bin/bash

set -e

echo "Installing git-timetracking..."
pushd `git rev-parse --git-dir`/hooks > /dev/null

if [ -f commit-msg ] || [ -L commit-msg ]; then
    echo "A prepare-commit-msg file already exists."
    read -p "Overwrite? [y/N] " -n 1 -r < /dev/tty
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    rm -f post-commit
fi

if [ -d "git-timetracking" ]; then
    pushd "git-timetracking" > /dev/null
    git pull origin
    popd > /dev/null
else
    git clone https://github.com/yuzu-co/git-timetracking.git
fi
ln -s git-timetracking/commit-msg commit-msg

popd > /dev/null

echo "Done!"
