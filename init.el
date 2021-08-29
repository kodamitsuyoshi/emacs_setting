;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; My init.el.

;;; Code:

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://mirrors.163.com/elpa/gnu/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; ここにいっぱい設定を書く



;(defun set-exec-path-from-shell-PATH ()
;  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

;This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
;  (interactive)
;  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;    (setenv "PATH" path-from-shell)
;    (setq exec-path (split-string path-from-shell path-separator))))

;(set-exec-path-from-shell-PATH)





(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :preface
  (defun c/redraw-frame nil
	(interactive)
	(redraw-frame))

  :bind (("M-ESC ESC" . c/redraw-frame))
  :custom '((user-full-name . "Mitsuyoshi Koda")
			(user-mail-address . "3nan.mkoda@gmail.com")
			;(user-login-name . "conao3")
			(create-lockfiles . nil)
			(debug-on-error . t)
			(init-file-debug . t)
			(frame-resize-pixelwise . t)
			(enable-recursive-minibuffers . t)
			(history-length . 1000)
			(history-delete-duplicates . t)
			;(scroll-preserve-screen-position . t)
			;(scroll-conservatively . 100)
			;(mouse-wheel-scroll-amount . '(1 ((control) . 5)))
			(ring-bell-function . 'ignore)
			(text-quoting-style . 'straight)
			(truncate-lines . t)
			;; (use-dialog-box . nil)
			;; (use-file-dialog . nil)
			;; (menu-bar-mode . t)
			;; (tool-bar-mode . nil)
			(scroll-bar-mode . nil)
			(indent-tabs-mode . nil))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (keyboard-translate ?\C-h ?\C-?))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 1))
    :global-minor-mode global-auto-revert-mode)





(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))
(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

;(leaf cus-edit
;  :doc "tools for customizing Emacs and Lisp packages"
;  :tag "builtin" "faces" "help"
;  :cus `((custom-file . ,(locate-user-emacs-file "custom.el"))))


;; スタートアップページを表示しない
(leaf leaf-convert
  :setq ((inhibit-startup-message . t)
	 (backup-directory-alist quote
				 ((".*" . "~/.ehist")))
	 (version-control . t)
	 (kept-new-versions . 5)
	 (kept-old-versions . 1)
	 (delete-old-versions . t)
	 (create-lockfiles))
  :config
;  (tool-bar-mode 0)
;  (menu-bar-mode 0)
  (setq frame-title-format (format "%%f - Emacs@%s"
				   (system-name)))
  (keyboard-translate 8 127))




;;; 種類ごとの色
(leaf leaf-convert
  :config
  (add-hook 'font-lock-mode-hook
	    '(lambda nil
	       (set-face-foreground 'font-lock-comment-face "#f69933")
	       (set-face-foreground 'font-lock-string-face "LightSalmon")
	       (set-face-foreground 'font-lock-keyword-face "#66e6e6")
	       (set-face-foreground 'font-lock-builtin-face "LightSteelBlue")
	       (set-face-foreground 'font-lock-function-name-face "LightSkyBlue")
	       (set-face-foreground 'font-lock-variable-name-face "LightGoldenrod")
	       (set-face-foreground 'font-lock-type-face "PaleGreen")
	       (set-face-foreground 'font-lock-constant-face "Aquamarine")
	       (set-face-foreground 'font-lock-warning-face "Pink"))))




(when (functionp 'mac-auto-ascii-mode)  ; ミニバッファに入力時、自動的に英語モード
  (mac-auto-ascii-mode 1))

;愛してる小手川
;;;　エディタの設定
(leaf *editor-settings
  :hook ((after-save-hook . executable-make-buffer-file-executable-if-script-p))
  :setq ((next-line-add-newlines)
		 (font-lock-support-mode quote jit-lock-mode))
  :config
  (set-frame-parameter nil 'alpha 98)
  (size-indication-mode t)
  (global-font-lock-mode t)
  (keyboard-translate 8 127)
  (add-hook 'doc-view-mode-hook
			(lambda nil
			  (linum-mode -1)))
  (add-hook 'pdf-view-mode-hook
			(lambda nil
			  (linum-mode -1))))

;; Backup setting
;; バッファのバックアップの設定
(leaf *backup-settings
  :config
  (setq make-backup-files nil) ;変更ファイルのバックアップ
  (setq version-control nil) ;変更ファイルの番号つきバックアップ
  (setq auto-save-list-file-name nil) ;編集中ファイルのバックアップ
  (setq auto-save-list-file-prefix nil)
  (setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))) ;編集中ファイルのバックアップ先
  (setq auto-save-timeout 30) ;編集中ファイルのバックアップ間隔（秒）
  (setq auto-save-interval 500) ;編集中ファイルのバックアップ間隔（打鍵）
  (setq kept-old-versions 1) ;バックアップ世代数
  (setq kept-new-versions 2)
  (setq trim-versions-without-asking nil) ;上書き時の警告表示
  (setq delete-old-versions t) ;古いバックアップファイルの削除
  )

;;; Scroll setting
;; スクロールに関する設定
(leaf *scroll-settings
  :config
  (setq scroll-preserve-screen-position t) ;スクロール時のカーソル位置の維持
  ;; smooth-scroll
  ;; スクロールがスムーズになる
  (leaf smooth-scroll
    :ensure t
    :config
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
    (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
    (setq scroll-step 1) ;; keyboard scroll one line at a time
    )
  )



;; Tab, Space setting
;; タブ，スペースに関する設定
(leaf *tab-space-settings
  :config
  (setq-default tab-width 4 indent-tabs-mode t) ;タブにスペースを使用する
  (setq-default tab-width 4 indent-tabs-mode t) ;タブにスペースを使用する
  )



;; deliminator-settings
;; 括弧に関する設定
(leaf *deliminator-settings
  :config
  ;; rainbow-delimiters
  ;; 括弧を虹色に設定してくれる
  (leaf rainbow-delimiters
    :ensure t
    :hook
    (prog-mode-hook . rainbow-delimiters-mode)
    )
  ;; paren
  ;; 括弧を色付きにしてくれる
  (leaf paren
    :ensure t
    :hook
    (after-init-hook . show-paren-mode)
    :custom-face
    (show-paren-match . '((nil (:background "#44475a" :foreground "#f1fa8c"))))
    :custom ((show-paren-style . 'mixed)
             (show-paren-when-point-inside-paren . t)
             (show-paren-when-point-in-periphery . t))
    )
  )




;;; symbol-voerlay
;; 同じ名前のところを強調する
(leaf symbol-overlay
  :ensure t
  :bind (("M-i" . symbol-overlay-put)
         (symbol-overlay-map
          ((kbd "C-p") . symbol-overlay-jump-prev) ;; 次のシンボルへ
          ((kbd "C-n") . symbol-overlay-jump-next) ;; 前のシンボルへ
          ((kbd "C-g") . symbol-overlay-remove-all) ;; ハイライトキャンセル
          ))
  :hook ((prog-mode-hook . symbol-overlay-mode)
         (markdown-mode-hook . symbol-overlay-mode))
  )


;;; which-key
;; キーバインド覚えなくて良くするやつ
(leaf which-key
  :ensure t
  :hook (after-init-hook . which-key-mode)
  :config
  (which-key-setup-minibuffer)
  (setq which-key-idle-secondary-delay 0)
  )



;;; highlight-indent-guides
;(leaf highlight-indent-guides
;  :ensure t yaml-mode
;  :custom
;  (highlight-indent-guides-method . 'character)
;  (highlight-indent-guides-auto-enabled . nil)
;  :hook
;  (prog-mode-hook . highlight-indent-guides-mode)
;  (yaml-mode-hook . highlight-indent-guides-mode)
;  (text-mode-hook . highlight-indent-guides-mode)
;  (web-mode-hook . highlight-indent-guides-mode)
;  :config
;  (set-face-background 'highlight-indent-guides-odd-face "darkgray")
;  (set-face-background 'highlight-indent-guides-even-face "dimgray")
;  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
;  ) 
;;; hs-minor-mode
;(leaf hs-minor-mode
;  :ensure t
;  :hook
;  (prog-mode-hook . (lambda () (hs-minor-mode 1))) 
;  :bind (("C-c C-f" . hs-toggle-hiding)
;         ("C-c C-a" . hs-show-all)
;         ("C-c C-g" . hs-hide-all))
;)






(leaf ivy
  :custom ((ivy-re-builders-alist quote
								  ((t . ivy--regex-fuzzy)
								   (swiper . ivy--regex-plus)))
		   (ivy-use-selectable-prompt . t)
		   (ivy-mode . t)
		   (counsel-mode . t))
  :config
  (leaf-handler-package ivy ivy nil)
  (leaf *ivy-requirements
	:config
	(leaf swiper)

	(leaf counsel
	  :bind (([remap isearch-forward]
			  . counsel-imenu)
			 ("C-x C-r" . counsel-recentf))
	  :config
	  (leaf-handler-package counsel counsel nil))))

(leaf helm
  :ensure t
  ;; :require helm-config
  :config
  (leaf helm-swoop
    :ensure t
    :load-path `,(locate-user-emacs-file "site-lisp/helm-swoop")
    :custom (helm-swoop-pre-input-function
             . (lambda ()
                 (if mark-active
                     (buffer-substring-no-properties (mark) (point))
                   "")))
    :bind ((helm-swoop-map   ("C-s" . helm-multi-swoop-all-from-helm-swoop))
           ("C-c s" . helm-swoop)
           ("C-c f" . hydra-helm-swoop/body))))
  
(leaf deepl
  :load-path `, (locate-user-emacs-file "site-lisp/deepl.el"))


(leaf-keys (("C-h"     . backward-delete-char)
            ("C-c M-a" . align-regexp)
            ("C-c ;"   . comment-region)
            ("C-c M-;" . uncomment-region)
            ("C-/"     . undo)
            ("C-c M-r" . replace-regexp)
            ("C-c r"   . replace-string)
            ("<home>"  . beginning-of-buffer)
            ("<end>"   . end-of-buffer)
            ("C-c M-l" . toggle-truncate-lines)))

; display line numbers
(leaf leaf-convert
  :when (version<= "26.0.50" emacs-version)
  :config
  (global-display-line-numbers-mode)
  (set-face-attribute 'line-number nil :foreground "DarkOliveGreen" :background "#131521")
  (set-face-attribute 'line-number-current-line nil :foreground "gold"))




;;;;;;;;;;;;;;;;;;;;;
;; IDE environment ;;
;;;;;;;;;;;;;;;;;;;;;
(leaf *lsp-basic-settings  
  :url "https://github.com/emacs-lsp/lsp-mode#supported-languages"
  :url "https://github.com/MaskRay/ccls/wiki/lsp-mode#find-definitionsreferences"
  :doc "lsp is language server protocol"
  :when (version<= "25.1" emacs-version)
  :ensure flycheck
  :config
  ;; lsp-mode
  
  (leaf lsp-mode
    :ensure t
    :commands lsp
    :custom
    ((lsp-enable-snippet . t)
     (lsp-enable-indentation . nil)
     (lsp-prefer-flymake . nil)
     (lsp-document-sync-method . 'incremental)
     (lsp-inhibit-message . t)
     (lsp-message-project-root-warning . t)
     (create-lockfiles . nil)
     (lsp-file-watch-threshold .nil))
    :preface (global-unset-key (kbd "C-l"))
    :bind
    (("C-l C-l"  . lsp)
     ("C-l h"    . lsp-describe-session)
     ("C-l t"    . lsp-goto-type-definition)
     ("C-l r"    . lsp-rename)
     ("C-l <f5>" . lsp-restart-workspace)
     ("C-l l"    . lsp-lens-mode))
    :hook
    (prog-major-mode-hook . lsp-prog-major-mode-enable)
    )
  ;; lsp-ui
  (leaf lsp-ui
    :ensure t 
    :commands lsp-ui-mode
    :after lsp-mode
    :custom
    ;; lsp-ui-doc
    (lsp-ui-doc-enable . t)
    (lsp-ui-doc-header . t)
    (lsp-ui-doc-include-signature . t)
    (lsp-ui-doc-position . 'top)
    (lsp-ui-doc-max-width . 60)
    (lsp-ui-doc-max-height . 20)
    (lsp-ui-doc-use-childframe . t)
    (lsp-ui-doc-use-webkit . nil)
    ;; lsp-ui-flycheck
    (lsp-ui-flycheck-enable . t)
    ;; lsp-ui-sideline
    (lsp-ui-sideline-enable . nil)
    (lsp-ui-sideline-ignore-duplicate . t)
    (lsp-ui-sideline-show-symbol . nil)
    (lsp-ui-sideline-show-hover . nil)
    (lsp-ui-sideline-show-diagnostics . nil)
    (lsp-ui-sideline-show-code-actions . nil)
    ;; lsp-ui-imenu
    (lsp-ui-imenu-enable . nil)
    (lsp-ui-imenu-kind-position . 'top)
    ;; lsp-ui-peek
    (lsp-ui-peek-enable . t)
    (lsp-ui-peek-always-show . t)
    (lsp-ui-peek-peek-height . 30)
    (lsp-ui-peek-list-width . 30)
    (lsp-ui-peek-fontify . 'always)
    :hook
    (lsp-mode-hook . lsp-ui-mode)
    :bind
    (("C-l s"   . lsp-ui-sideline-mode)
     ("C-l C-d" . lsp-ui-peek-find-definitions)
     ("C-l C-r" . lsp-ui-peek-find-references))
    )
  ;; company-lsp
  (leaf company-lsp
    :url "https://github.com/tigersoldier/company-lsp"
    :commands company-lsp company
    :custom
    (company-lsp-cache-candidates . nil)
    (company-lsp-async . t)
    (company-lsp-enable-recompletion . t)
    (company-lsp-enable-snippet . t)
    :after
    (:all lsp-mode lsp-ui company yasnippet)
    ;; lsp-treema
    (leaf lsp-treemacs :ensure t)  
    )
  )

;;; company
(leaf company
  :commands global-company-mode
  :bind (("C-M-c" . company-complete)
		 (company-active-map :package company
							 ("C-n" . company-select-next)
							 ("C-p" . company-select-previous)
							 ("C-s" . company-filter-candidates)
							 ("C-i" . company-complete-selection)
							 ([tab]
							  . company-complete-selection))
		 (company-search-map :package company
							 ("C-n" . company-select-next)
							 ("C-p" . company-select-previous)))
  :hook ((after-init-hook . global-company-mode)
		 after-init-hook)
  :custom ((company-transformers quote
								 (company-sort-by-backend-importance))
		   (company-idle-delay . 0)
		   (company-echo-delay . 0)
		   (company-minimum-prefix-length . 2)
		   (company-selection-wrap-around . t)
		   (completion-ignore-case . t))
  :config
  (leaf-handler-package company company nil)
  (leaf-handler-package company company-irony nil)
  (leaf-handler-package company slime-company nil)
  (leaf-handler-package company company-c-headers nil)
  (leaf-handler-package company company-auctex nil)
  (leaf-handler-package company company-math nil)
  (with-eval-after-load 'company
	(let ((leaf--load-file-name "/Users/3nanm1/.emacs.d/init.el"))
	  (defun my-sort-uppercase (candidates)
		(let (case-fold-search
			  (re "\\`[[:upper:]]*\\'"))
		  (sort candidates
				(lambda (s1 s2)
				  (and
				   (string-match-p re s2)
				   (not (string-match-p re s1)))))))

	  (push 'my-sort-uppercase company-transformers)
	  (defvar company-mode/enable-yas t)
	  (defun company-mode/backend-with-yas (backend)
		(if (or
			 (not company-mode/enable-yas)
			 (and
			  (listp backend)
			  (member 'company-yasnippet backend)))
			backend
		  (append
		   (if (consp backend)
			   backend
			 (list backend))
		   '(:with company-yasnippet))))

	  (company-auctex-init)
	  (slime-setup
	   '(slime-fancy slime-company))
	  (add-to-list 'company-backends
				   '(company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-dabbrev-code company-gtags company-etags company-keywords company-oddmuse company-files company-dabbrev mapcar company-mode/backend-with-yas slime-company company-irony company-c-headers company-auctex company-math-symbols-unicode company-lsp company-elisp company-yasnippet)))))

;; company-box
(leaf company-box
  :ensure t
  :after (company all-the-icons)
  :hook ((company-mode-hook . company-box-mode))
  :custom
  (company-box-icons-alist . 'company-box-icons-all-the-icons)
  (company-box-doc-enable . nil))

;;; company-quickhelp
(leaf company-quickhelp
  :ensure t
  :hook (company-mode-hook . company-quickhelp-mode)
  )



;;; git-complete
;(leaf git-complete
;  :require t
;  :load-path `,(locate-user-emacs-file "site-lisp/git-complete.el")
;;  :(global-set-key (kbd "C-c C-c") 'git-complete)
  
;;  :ensure t
;;  :package popup
;;  :el-get (zk-phi/git-complete :branch "master")
;  :preface (global-unset-key (kbd "C-c C-c"))
;  :hook (after-init-hook . git-complete)
;  :custom (git-complete-enable-autopair . t)
;  :bind  ((kbd "C-c C-c") . git-complete)
;   ;:custom (git-complete-enable-autopair . t)

   
;  )


;;; flyspell-mode
;(leaf flyspell
;  :ensure t
;  :hook
;  (text-mode-hook . flyspell-mode)
;  (org-mode-hook . flyspell-mode)
;  (prog-mode-hook . flyspell-prog-mode) 
;  )

;;; ispell-check
;(leaf *ispell-check
;  :setq-default ((ispell-program-name . "aspell"))
;  :config
;  (with-eval-after-load '"ispell"
;	(setq ispell-local-dictionary "en_US")
;	(add-to-list 'ispell-skip-region-alist
;				 '("[^ -\377]+"))))

;;; yasnipet
(leaf *snipet-settings
  :config
  (leaf yasnippet
    :ensure t
    :hook (after-init . yas-global-mode)
    :bind
    ((yas-minor-mode-map
      ("C-x i n" . yas-new-snippet)
      ("C-x i v" . yas-visit-snippet-file)
      ("C-M-i"   . yas-insert-snippet))
     (yas-keymap
      ("<tab>" . nil)));; because of avoiding conflict with company keymap
    )
  )

;;; magit
(leaf magit
  :ensure t
  :bind ("C-x g" . magit-status)
  )


;;; smart-jump
(leaf smart-jump
  :ensure t ivy
  :bind
  ("C-c C-j" . smart-jump-go)
  :custom
  (dumb-jump-mode . t)
  (dumb-jump-selector . 'ivy)
  (dumb-jump-use-visible-window . nil)
  :config
  (smart-jump-setup-default-registers)
  )



;;;;;;;;;;;;;;;;;;;;;;;
;; Language settings ;;
;;;;;;;;;;;;;;;;;;;;;;;
;;; script-settings
(leaf executable
  :ensure t
  :hook
  (after-save-hook . executable-make-buffer-file-executable-if-script-p)
  )

;;; nxml-mode
;;xml
(leaf nxml-mode
  :mode (("\\.launch\\'")
         ("\\.xacro\\'")
         ("\\.urdf\\'")
         ("\\.config\\'")
         ("\\.sdf\\'")
         ("\\.world\\'")
         ("\\.test\\'"))
  )

;;; yaml-mode
;; yaml
(leaf yaml-mode
  :ensure t;
  :mode (("\\.yml\\'")
         ("\\.yaml\\'")
         ("\\.cnoid\\'")
         ("\\.body\\'")
         )
  )

;;; cmake-mode
(leaf cmake-mode
  :ensure t
  :mode
  ("CMakeLists\\.txt\\'" . cmake-mode)
  ("\\.cmake\\'" . cmake-mode)
  
  )

;;; C, C++ style
;; C, C++
(leaf c-c++
  :config
  (add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.pde\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
  ;; original cc-mode hooks
  
  (leaf cc-mode
    :require t
    :preface
    (defun ROS-c-mode-hook()
      (setq c-basic-offset 2)
      (setq indent-tabs-mode nil)
      (hide-ifdef-mode t)
      (hide-ifdefs)
      (c-set-offset 'substatement-open 0)
      (c-set-offset 'innamespace 0)
      (c-set-offset 'case-label '+)
      (c-set-offset 'brace-list-open 0)
      (c-set-offset 'brace-list-intro '+)
      (c-set-offset 'brace-list-entry 0)
      (c-set-offset 'member-init-intro 0)
      (c-set-offset 'statement-case-open 0)
      (c-set-offset 'arglist-intro '+)
      (c-set-offset 'arglist-cont-nonempty '+)
      (c-set-offset 'arglist-close '+)
      (c-set-offset 'template-args-cont '+))
    :hook
    (c-mode-common-hook . ROS-c-mode-hook)
    (c++-mode-common-hook . ROS-c-mode-hook)
    
    )
  ;; clang-format
  
  (leaf clang-format
    :ensure t
    :custom
    (clang-format-style-option . "llvm")    
    )
  ;; google-c-style
  
  (leaf google-c-style
    :ensure t
    :hook
    (c-mode-common-hook . google-set-c-style)
    (c++-mode-common-hook . google-set-c-style)
    )
  ;; lsp setting
  (leaf *lsp-setting
    :config
    ;; ccls
  
    (leaf ccls
      :ensure t
      :custom
      (ccls-executable .  "/usr/local/bin/ccls")
      ;; (ccls-sem-highlight-method . 'font-lock)
      ;; (ccls-use-default-rainbow-sem-highlight .)
      :hook ((c-mode-hook c++-mode-hook objc-mode-hook) .
             (lambda () (require 'ccls) (lsp))))
    )
  )




(leaf editorconfig
  :ensure t
  :config
  (editorconfig-mode 1)
 )



;;; php-mode
(leaf *php-mode-setting
;  :mode (("\\.php\\'" . php-mode))
  :preface
  (setq php-mode-coding-style 'psr2)
  ;(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

  :config
  (leaf flycheck
	:config
	(leaf-handler-package flycheck flycheck nil))

  (leaf flycheck-phpstan
	:config
	(leaf-handler-package flycheck-phpstan flycheck-phpstan nil))

  (leaf php-mode
	:preface
	(defun php-stan-php-mode-hook nil
	  "My PHP-mode hook."
	  (subword-mode 1)
	  (setq show-trailing-whitespace t)
	  (setq-local page-delimiter "\\_<\\(class\\|function\\|namespace\\)\\_>.+$")


	  (require 'flycheck)
	  
	  (flycheck-mode t)
	  (require 'flycheck-phpstan)
	  (setq flycheck-phpcs-standard "PSR2")
	  (setq phpstan-memory-limit "2G")
	  (flycheck-select-checker 'phpstan))

	(defun my-ac-company-php-mode-hook nil
	  "Hooks for php-mode"
	  (company-mode t)
	  (leaf company-php
		:ensure t)

	  (leaf ac-php
		:ensure t)
	  (ac-php-core-eldoc-setup)
	  
	  (set
	   (make-local-variable 'company-backends)
	   '((company-ac-php-backend company-dabbrev-code)
		 company-capf company-files))
	  (define-key php-mode-map
		(kbd "C-]")
		'ac-php-find-symbol-at-point)
	  (define-key php-mode-map
		(kbd "C-t")
		'ac-php-location-stack-back))

	:commands my-ac-company-php-mode-hook php-stan-php-mode-hook editorconfig-apply
	:hook ((php-mode-hook . my-ac-company-php-mode-hook)
		   (php-mode-hook . php-stan-php-mode-hook)
		   (php-mode-hook . editorconfig-apply))
	:config
		(provide 'php-config)))
;;; csharp-mode

(leaf csharp-mode
  :ensure t
  )

;;; platformio-mode

(leaf platformio-mode
  :ensure t
  )


;;; dockerfile mode

(leaf dockerfile-mode
  :ensure t
  :mode (("Dockerfile" . dockerfile-mode))
  )




;;; web-mode
;; Web modeの設定
(leaf web-mode
  :ensure t
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.[gj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html?\\'" . web-mode)
         )
  :custom
  (web-mode-engines-alist . '(("php"    . "\\.phtml\\'")
                              ("blade"  . "\\.blade\\.")))
  (web-mode-enable-current-element-highlight . t)
  :preface
  (defun my-web-mode-hook () "Hooks for Web mode." 
         (setq web-mode-markup-indent-offset 2) 
         (setq web-mode-markup-indent-offset 2)
         (setq web-mode-css-indent-offset 2)
         (setq web-mode-code-indent-offset 2)
         ) 
  :hook (web-mode-hook . my-web-mode-hook)
  )


;;---php------------------------------






(leaf imenu-list
  :ensure t
)




(provide 'init)

