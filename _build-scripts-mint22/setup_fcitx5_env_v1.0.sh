#!/bin/bash
# Script Name: setup_fcitx5_env
# Version: 1.0
# Description: Install Fcitx5 environment and remove Fcitx4 on Linux Mint 22.3

echo "--- 正在移除 Fcitx4 與相關組件 ---"
sudo apt purge -y fcitx fcitx-bin fcitx-data fcitx-modules fcitx-config-common
sudo apt autoremove -y

echo "--- 正在安裝 Fcitx5 核心組件 ---"
sudo apt update
sudo apt install -y fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk2 fcitx5-frontend-gtk3 fcitx5-frontend-qt5 fcitx5-config-qt

echo "--- 配置環境變數 ---"
# 確保輸入法能在各類視窗程式中正常運行
if ! grep -q "GTK_IM_MODULE=fcitx" ~/.pam_environment; then
    cat <<EOF >> ~/.pam_environment
GTK_IM_MODULE DEFAULT=fcitx
QT_IM_MODULE  DEFAULT=fcitx
XMODIFIERS    DEFAULT=@im=fcitx
SDL_IM_MODULE DEFAULT=fcitx
EOF
fi

echo "--- 安裝完成 ---"
echo "請登出並重新登入，確保環境變數生效後，再執行第二個腳本安裝小麥輸入法。"
