(require 'anything)
(require 'anything-config)

;;anythingでファイルリストを検索
(define-key global-map (kbd "C-x b") 'anything-filelist+)
;;クリップボードの履歴をanythingで検索
(global-set-key "\M-y" 'anything-show-kill-ring)
(global-set-key (kbd "C-.") 'anything-do-grep)
