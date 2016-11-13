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
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(fset 'package-desc-vers 'package--ac-desc-version)
					;(package-initialise)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flymake-cursor flymake-php ac-php auto-complete expand-region minimap quickrun jedi anything))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-added ((t (:background "black" :foreground "green"))))
 '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
 '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
 '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
 '(magit-hash ((t (:foreground "red")))))

;(require 'yasnippet)
