;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! magit-todos)
(package! git-gutter)
(package! tldr)
(package! leetcode)
(package! conflict-buttons)

;;; We do this so that org-roam-ui will work properly since it wants the most recent version of org-roam but doom wants strict version control
(unpin! org-roam)
(package! org-roam-ui)

;; Unity Integration Package
(straight-use-package
 '(unity :type git :host github :repo "elizagamedev/unity.el"))
(add-hook 'after-init-hook #'unity-mode)


;; Quickshell LSP support
;;(use-package qml-ts-mode
;;  :after lsp-mode
;;  :config
;;  (add-to-list 'lsp-language-id-configuration '(qml-ts-mode . "qml-ts"))
;;  (lsp-register-client
;;   (make-lsp-client :new-connection (lsp-stdio-connection '("qmlls"))
;;                    :activation-fn (lsp-activate-on "qml-ts")
;;                    :server-id 'qmlls))
;;  (add-hook 'qml-ts-mode-hook (lambda ()
;;                                (setq-local electric-indent-chars '(?\n ?\( ?\) ?{ ?} ?\[ ?\] ?\; ?,))
;;                                (lsp-deferred))))
