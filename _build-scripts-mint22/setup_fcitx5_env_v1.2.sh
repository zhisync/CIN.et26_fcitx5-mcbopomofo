#!/bin/bash
# Script Name: setup_fcitx5_env
# Version: 1.2
# Description: Install Fcitx5, Chewing, Cangjie and dependencies for Linux Mint 22.3

echo "--- 正在移除 Fcitx4 與相關組件 ---"
sudo apt purge -y fcitx fcitx-bin fcitx-data fcitx-modules fcitx-config-common
sudo apt autoremove -y

echo "--- 正在更新軟體源 ---"
sudo apt update

echo "--- 正在安裝 Fcitx5 核心與常用輸入法 (新酷音、倉頡) ---"
# fcitx5-chinese-addons 包含了新酷音、倉頡、拼音等
# fcitx5-table-extra 包含了更完整的倉頡三代/五代與其他查表輸入法
sudo apt install -y \
    fcitx5 \
    fcitx5-chinese-addons \
    fcitx5-table-extra \
    fcitx5-frontend-gtk2 \
    fcitx5-frontend-gtk3 \
    fcitx5-frontend-qt5 \
    fcitx5-config-qt

echo "--- 配置環境變數 ---"
# 使用 .pam_environment 是為了讓 Session 啟動時自動載入變數
if [ ! -f ~/.pam_environment ]; then
    touch ~/.pam_environment
fi

# 檢查並寫入環境變數 (避免重複寫入)
for var in "GTK_IM_MODULE DEFAULT=fcitx" "QT_IM_MODULE  DEFAULT=fcitx" "XMODIFIERS    DEFAULT=@im=fcitx" "SDL_IM_MODULE DEFAULT=fcitx"; do
    if ! grep -q "$var" ~/.pam_environment; then
        echo "$var" >> ~/.pam_environment
    fi
done

echo "--- 安裝完成 ---"
echo "已安裝：Fcitx5 核心、新酷音 (Chewing)、倉頡 3/5 代。"
echo "請登出並重新登入後，再執行第二個腳本安裝『小麥輸入法』。"
