;; スタートアップページを表示しない
(setq inhibit-startup-message t)
(server-start)

;; ツールバーを消す
(tool-bar-mode 0)


;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))
