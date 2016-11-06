;; スタートアップページを表示しない
(setq inhibit-startup-message t)
(server-start)

;; ツールバーを消す
(tool-bar-mode 0)
;; メニューバーを非表示
;(menu-bar-mode 0)

;; スクロールバー非表示
(set-scroll-bar-mode 0)

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

;;バックキー定義
(keyboard-translate ?\C-h ?\C-?)


;; 行番号を表示する
(require 'linum)
;;(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#333"
                    :height 0.9)
(setq linum-format "%d ") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる


;; 括弧の範囲内を強調表示
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; 括弧の範囲色
(set-face-background 'show-paren-match-face "#1ABC9C")

;; 選択領域の色
;;(set-face-background 'region "#999")


(fset 'yes-or-no-p 'y-or-n-p)


;; 行間
(setq-default line-spacing 0)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode



;; ------------------------------------------------------------------------
;; @ redo+.el

;; redoできるようにする
;; http://www.emacswiki.org/emacs/redo+.el
(when (require 'redo+ nil t)
  (define-key global-map (kbd "C-_") 'redo))


(when (require 'minimap nil t )
 (define-key global-map (kbd "C-x _") 'minimap-mode))