; dired で c キーで VSCode を開く
(define-key dired-mode-map (kbd "c") 'open-vscode)
(defun open-vscode ()
  (interactive)
  (let ((files (dired-get-marked-files t current-prefix-arg)))
    (dired-do-shell-command "code *" nil files)))
