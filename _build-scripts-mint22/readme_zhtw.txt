感謝小麥作者，也感謝這篇文章 Ubuntu繁體中文輸入法？改用Fcitx5來輸入中文吧！ https://ivonblog.com/posts/ubuntu-fcitx5/ 對編譯指令多作了一些詮釋。
Linux Mint Cinnamon 22.3 內定的輸入法框架是 fcitx4 吧，而且沒有包含小麥，我根據上面提到的文章，詢問 gemini, 寫出這二個 scripts, 可以成功編譯。

step1 setup_fcitx5_env_v1.0.sh，這個腳本負責移除舊版 Fcitx4 (如果有的話)、安裝 Fcitx5 核心組件，並設定必要的環境變數。
step2  install_mcbopomofo_v1.2.sh 編譯指令，並加入了相依套件的自動檢查
step3 左下角選單：開始/管理/Fcitx5啟動中文輸入法。或加入開機的 rc 檔。
