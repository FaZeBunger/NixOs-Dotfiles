;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-spacegrey)
(setq doom-font (font-spec :family "JetBrainsMono NF" :size 14))

(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq org-agenda-files '("~/org/"))


;; Adds TODO tracking in git page so we can see TODOs in git repos and per branch
(use-package! magit-todos
  :after magit
  :config
  (magit-todos-mode 1))

;; Add git gutters
(use-package! git-gutter
  :hook (find-file . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02)
  ;; Force colors so the theme doesn't overwrite them
  (custom-theme-set-faces! 'user
    '(git-gutter:added :foreground "green" :weight bold)
    '(git-gutter:deleted :foreground "red" :weight bold)
    '(git-gutter:modified :foreground "yellow" :weight bold)))

;; Add Unity Mode to emacs for opening files with unity
(straight-use-package
 '(unity :type git :host github :repo "elizagamedev/unity.el"))
(add-hook 'after-init-hook #'unity-mode)

;; Used for adding Unity LPS suggestions
(use-package lsp-mode
  :ensure t
  :bind-keymap
  ("C-c l" . lsp-command-map)
  :custom
  (lsp-keymap-prefix "C-c l"))

(use-package csharp-mode
  :ensure t
  :init
  (defun my/csharp-mode-hook ()
    (setq-local lsp-auto-guess-root t)
    (lsp))
  (add-hook 'csharp-mode-hook #'my/csharp-mode-hook))

(map! :leader
      :desc "Git stage hunk"
      "g s" #'git-gutter:stage-hunk)
(setq confirm-kill-emacs nil)


;; Setup vshell and make it use fish

;; Keep a POSIX shell for background Emacs subprocesses to prevent errors
(setq shell-file-name (executable-find "bash"))

;; Explicitly force interactive terminals (vterm) to use Fish shell
(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

;; Set different font sizes for Org Mode Headers
(custom-set-faces!
  '(org-level-1 :inherit outline-1 :height 1.5 :weight bold)
  '(org-level-2 :inherit outline-2 :height 1.4 :weight bold)
  '(org-level-3 :inherit outline-3 :height 1.3 :weight bold)
  '(org-level-4 :inherit outline-4 :height 1.2 :weight bold)
  '(org-level-5 :inherit outline-5 :height 1.1 :weight bold))

;; Changing * to icons for Org Mode
(after! org-modern
  (setq org-modern-start '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")))
