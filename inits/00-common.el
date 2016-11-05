;; スタートアップページを表示しない
(setq inhibit-startup-message t)
(server-start)

;; ツールバーを消す
(tool-bar-mode 0)


;タイトルバーにファイル名を表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))


(setq backup-directory-alist '((".*" . "~/.ehist")))
;; 番号付けによる複数保存
(setq version-control     t)  ;; 実行の有無
(setq kept-new-versions   5)  ;; 最新の保持数
(setq kept-old-versions   1)  ;; 最古の保持数
(setq delete-old-versions t)  ;; 範囲外を削除



;; ロックファイル作らない
(setq create-lockfiles nil)
