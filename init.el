;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun my-load-current-buffer-file ()
  "Load current buffer file"
  (interactive)
  (basic-save-buffer)
  (load (buffer-file-name)))

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key [f7] 'my-load-current-buffer-file)))





;; ~/.emacs.d/site-lisp 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(require 'init-loader)
(setq init-loader-show-log-after-init t)
(init-loader-load "~/.emacs.d/inits")
;(setq init-loader-show-log-after-init t)

;;----- Macの日本語関係
(when (fboundp 'mac-input-source)
  (defun my-mac-selected-keyboard-input-source-chage-function ()
    (let ((mac-input-source (mac-input-source)))
      (set-cursor-color
       (if (string-match "com.apple.inputmethod.Kotoeri.Roman" mac-input-source)
	   "Yellow" "Red"))))
  (add-hook 'mac-selected-keyboard-input-source-change-hook
            'my-mac-selected-keyboard-input-source-chage-function))



(when (functionp 'mac-auto-ascii-mode)  ;; ミニバッファにf入力時、自動的に英語モード
  (mac-auto-ascii-mode 1))
(require 'package)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(fset 'package-desc-vers 'package--ac-desc-version)
					;(package-initialise)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(fuzzy company counsel tern-auto-complete company-tern js2-mode add-node-modules-path flycheck flymake-json php-refactor-mode doom-themes magit web-mode company-php smartrep multiple-cursors jedi auto-compile ac-php-core coffee-mode helm helm-gtags flymake-cursor flymake-php ac-php auto-complete expand-region minimap quickrun anything)))
		 ;;-- jedi

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anything-grep-file ((t (:foreground "color-219" :underline t))))
 '(custom-comment-tag ((t (:foreground "color-229"))))
 '(custom-variable-obsolete ((t (:foreground "color-82"))))
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :slant italic))))
 '(font-lock-comment-face ((t (:foreground "yellow" :slant italic))))
 '(font-lock-function-name-face ((t (:foreground "color-49"))))
 '(font-lock-string-face ((t (:foreground "green"))))
 '(font-lock-type-facE ((t (:foreground "green1" :weight extra-bold))))
 '(font-lock-variable-name-face ((t (:distant-foreground "green" :foreground "yellow" :weight normal))))
 '(magit-diff-added ((t (:background "black" :foreground "green"))))
 '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
 '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
 '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
 '(magit-hash ((t (:foreground "red"))))
 '(minibuffer-prompt ((t (:foreground "color-51"))))
 '(shadow ((t (:foreground "brightwhite"))))
 '(web-mode-comment-face ((t (:foreground "#D9333F"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
 '(web-mode-doctype-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground "#D9333F")))))

;(require 'yasnippet)
(set-face-foreground 'dired-directory "yellow" )

