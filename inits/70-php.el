; バックアップファイルを作らない
;(setq flycheck-phpcs-standard "PSR2")
;(setq php-mode-coding-style 'psr2)
(setq flycheck-phpcs-standard "PSR2")
(setq php-mode-coding-style 'psr2)
(require 'php-mode)




;(setq make-backup-files nil)
;(setq auto-save-default nil)
;(setq next-line-add-newlines nil)



(defun my-php-mode-setup ()
  "My PHP-mode hook."
  (subword-mode 1)
  (setq show-trailing-whitespace t)

  (setq-local page-delimiter "\\_<\\(class\\|function\\|namespace\\)\\_>.+$")

  (require 'flycheck-phpstan)
  (flycheck-mode t)
  (add-to-list 'flycheck-disabled-checkers 'php-phpmd)
  (add-to-list 'flycheck-disabled-checkers 'php-phpcs))



; タグジャンプ設定
(add-hook 'helm-gtags-mode-hook
      '(lambda ()
         ;;入力されたタグの定義元へジャンプ
;         (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
         (local-set-key (kbd "M-o") 'helm-gtags-find-tag)
         ;;入力タグを参照する場所へジャンプ
         (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
         ;;入力したシンボルを参照する場所へジャンプ
         (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
         ;;タグ一覧からタグを選択し, その定義元にジャンプする
         (local-set-key (kbd "M-l") 'helm-gtags-select)
         ;;ジャンプ前の場所に戻る
         (local-set-key (kbd "M-p") 'helm-gtags-pop-stack)))
(add-hook 'php-mode-hook 'helm-gtags-mode)



; 関数名補完設定

(add-hook 'php-mode-hook
          '(lambda ()

	     ;;laravel
	     ;;(require 'company-php)
	     ;;(company-mode t)
	     ;;(ac-php-core-eldoc-setup) ;; enable eldoc
	     ;;(make-local-variable 'company-backends)
	     ;;(add-to-list 'company-backends 'company-ac-php-backend)

	     (auto-complete-mode t)
             (require 'ac-php)
             (setq ac-sources  '(ac-source-php ) )
             (yas-global-mode 1)

             (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
             (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back

	     (defun ywb-php-lineup-arglist-intro (langelem)
	       (save-excursion
                (goto-char (cdr langelem))
                (vector (+ (current-column) c-basic-offset))))
	     (defun ywb-php-lineup-arglist-close (langelem)
	       (save-excursion
		 (goto-char (cdr langelem))
		 (vector (current-column))))
	     (c-set-style "stroustrup")    ; インデントは4文字分基本スタイル
	     (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro) ; 配列のインデント関係
	     (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close) ; 配列のインデント関係
	     (c-set-offset 'arglist-cont-nonempty' 4) ; 配列のインデント関係

	     (c-set-offset 'case-label' 4) ; case はインデントする
	     (make-local-variable 'tab-width)
	     (make-local-variable 'indent-tabs-mode)
	     (setq tab-width 4)
	     (setq indent-tabs-mode nil)
	     (setq flycheck-phpcs-standard "PSR2")
	     ))

; 構文エラーチェック設定
(add-hook 'after-init-hook #'global-flycheck-mode)





;;phpmd settings
(setq flycheck-phpmd-rulesets '())
(add-to-list 'flycheck-phpmd-rulesets (expand-file-name "~/.phpmd.xml"))
;;(setq flycheck-php-phpmd-executable "/usr/local/bin/phpmd")
