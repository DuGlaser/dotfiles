#! /bin/bash

if type cargo > /dev/null 2>&1; then
	echo "Rust is already installed."
	exit 0
fi

rm -rf rust
mkdir rust
cd rust || exit

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o sh.rustup.rs
chmod +x sh.rustup.rs
./sh.rustup.rs -y

cd ../
rm -rf rust
