#!/bin/bash
# Script Name: install_mcbopomofo
# Version: 1.2
# Description: Build and install McBopomofo for Fcitx5 (Auto-clean source folder)

set -e # 遇到錯誤立即停止執行

# 定義原始碼資料夾名稱
SOURCE_DIR="fcitx5-mcbopomofo"

echo "--- 正在清理舊有的原始碼資料夾 ---"
if [ -d "$SOURCE_DIR" ]; then
    echo "發現舊的 $SOURCE_DIR，正在遞迴刪除..."
    sudo rm -rf "$SOURCE_DIR"
    echo "清理完成。"
else
    echo "未發現舊資料夾，準備開始新安裝。"
fi

echo "--- 正在確認/安裝編譯所需開發套件 ---"
sudo apt update
sudo apt install -y \
    pkg-config fcitx5 libfcitx5core-dev libfcitx5config-dev libfcitx5utils-dev fcitx5-modules-dev \
    cmake extra-cmake-modules gettext libfmt-dev libicu-dev libjson-c-dev git

echo "--- 重新下載小麥輸入法原始碼 ---"
git clone https://github.com/openvanilla/fcitx5-mcbopomofo.git
cd "$SOURCE_DIR"

echo "--- 開始編譯 (Version 1.2) ---"
mkdir -p build
cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)

echo "--- 執行安裝 ---"
sudo make install
sudo update-icon-caches /usr/share/icons/*

echo "--- 恭喜！小麥輸入法編譯與安裝已完成 ---"
echo "您可以手動刪除 $(pwd -P) 資料夾，或留著下次執行本腳本自動清理。"
