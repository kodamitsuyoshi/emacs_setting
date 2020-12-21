;; ------------------------------------------------------------------------
;; @ auto-complete.el

;; 自動補完機能
;; https://github.com/m2ym/auto-complete

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(when (require 'auto-complete-config nil t)
;;  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;  (setq ac-ignore-case t)
;;  (ac-config-default))
(require 'auto-complete)
(require 'auto-complete-config)
(require 'fuzzy) ;; fuzzy search (heaby)
(setq ac-use-fuzzy t)
(global-auto-complete-mode t)
(ac-config-default)
(setq ac-delay 0) ;; 補完候補表示までの時間
(setq ac-auto-show-menu 0.05) ;; ヒント表示までの時間
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)
(setq ac-menu-height 25) ;; ちょっと大きめにとりましょう！
(setq ac-auto-start 3) ;; 個人的には3でもいいかも
(setq ac-ignore-case t)
(define-key ac-completing-map (kbd "<tab>") 'ac-complete)

;; ac-source（要するにどうやって補完候補を選ぶか）
(setq-default ac-sources 'ac-source-words-in-same-mode-buffers)
(setq-default ac-sources (push 'ac-source-yasnippet ac-sources))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;(require 'company)
;(global-company-mode) ; 全バッファで有効にする
;(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
;(setq company-idle-delay 0) ; デフォルトは0.5
;(setq company-minimum-prefix-length 3) ; デフォルトは4
;(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
;(setq completion-ignore-case t)
;(setq company-dabbrev-downcase nil)
;(global-set-key (kbd "C-M-i") 'company-complete)
;(define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
;(define-key company-active-map (kbd "C-p") 'company-select-previous)
;(define-key company-search-map (kbd "C-n") 'company-select-next)
;(define-key company-search-map (kbd "C-p") 'company-select-previous)
;(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
;(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
;(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
;(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
;(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
;
;;; yasnippetとの連携
;(defvar company-mode/enable-yas t
;  "Enable yasnippet for all backends.")
;(defun company-mode/backend-with-yas (backend)
;  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
;      backend
;    (append (if (consp backend) backend (list backend))
;            '(:with company-yasnippet))))
;(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
;
