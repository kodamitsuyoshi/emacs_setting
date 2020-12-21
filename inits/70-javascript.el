
;;;js2-modeの設定
(require 'js2-mode)
(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-jsx-mode-hook #'flycheck-mode)

(add-hook 'js2-mode-hook
          (lambda ()

	    (setq tab-width 4)
            (setq indent-tabs-mode t)

	    ;(setq my-js-mode-indent-num 4)
	    ;(setq js2-basic-offset my-js-mode-indent-num)
	    ;(setq js-switch-indent-offset my-js-mode-indent-num)
            ))


(eval-after-load 'tern
    '(progn
        (require 'tern-auto-complete)
        (tern-ac-setup)))





(eval-after-load 'js2-mode '(add-hook 'js2-mode-hook #'add-node-modules-path))
(flycheck-add-mode 'javascript-eslint 'js2-mode)


(add-hook 'js2-mode-hook 'flycheck-mode)

