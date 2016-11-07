;;----- MacでGUIの時、optionをmeta
(if window-system (progn
		    (when (equal system-type 'darwin)
		      ;(setq mac-option-modifier 'meta))
		      (setq mac-command-modifier 'meta))
		    ))

(if window-system (progn
		    (when (equal system-type 'darwin) ;; Macでは16pt
		      (add-to-list 'default-frame-alist '(font . "ricty-18")))
		    ))



