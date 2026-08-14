;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)

;;; $DOOMDIR/config.el --- Summary: My Doom emacs config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq doom-theme 'doom-spacegrey)
(setq doom-font (font-spec :family "JetBrainsMono NF" :size 14))

(setq display-line-numbers-type 'relative)

;;; Set org directory
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/"))

(after! org
  (add-to-list 'org-capture-templates
               '("e" "Event / Appointment" entry
                 (file "~/org/calendar.org")
                 "* TODO %^{Task Name}\nSCHEDULED: %^t\n%?"
                 :empty-lines 1)
               ))
(after! org
  (add-to-list 'org-capture-templates
               '("i" "Idea" entry
                 (file "~/org/ideas.org")
                 "* IDEA %?"
                 :empty-lines 1)
               ))

(after! org-roam
  (setq org-roam-capture-templates
        '(("a" "atomic note" plain
           "%?"
           :if-new (file+head "atoms/${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)

          ("s" "school notebook" plain
           "%?"
           :if-new (file+head "school/${slug}.org" "#+title: ${title}\n#+filetags: :school:\n")
           :unnarrowed t)

          ("p" "project" plain
           "%?"
           :if-new (file+head "projects/${slug}.org" "#+title: ${title}\n#+filetags: :project:\n")
           :unnarrowed t))))

;; Adds leetcode support
(use-package! leetcode
  :config
  ;; LeetCode supports Racket and Scheme for Lisp-family languages
  (setq leetcode-prefer-language "racket")
  (setq leetcode-save-solutions t)
  (setq leetcode-directory "~/Dev/Leetcode"))

;; Stops doom from interfering with the leetcode popups
(set-popup-rule! "^\\*leetcode" :ignore t)

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
  '(org-level-5 :inherit outline-5 :height 1.1 :weight bold)
  '(org-document-title :height 1.8 :bold t :underline nil))

(defun insert-tree ()
  "Inserts a Tree for a given directory"
  (interactive)
  (let* ((directory-to-tree (read-string "Directory to Tree: "))
         (tree-depth (read-number "Enter Depth: "))
         (tree-command (format "tree %s -L %d" directory-to-tree tree-depth))
         (tree-string (shell-command-to-string tree-command)))
    (insert tree-string)))

(map! :leader
      :desc "Insert Filetree"
      "i t" #'insert-tree)

(map! :leader
      :desc "Toggle Treemacs File Explorer"
      "e e" #'treemacs)

(after! org-modern
  (setq org-modern-star '("◉" "○" "✿" "✸" "✤" "✜" "◆" "▶")))

(use-package! conflict-buttons
  :hook (find-file . conflict-buttons-mode))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(after! lsp-mode
  (setq lsp-clients-clangd-args
        '("--query-driver=/nix/store/**/bin/*gcc*"
          "--background-index")))

;; Use the modern EPA pinentry behavior
(setq epa-pinentry-mode 'loopback)
(setq epg-gpg-program "gpg")

;; Tell GPG which terminal to prompt on, when running in a terminal Emacs.
;; Safe to include even under GUI Emacs (pinentry-loopback prompts via
;; the minibuffer instead, so GPG_TTY mostly matters for terminal use).
(setenv "GPG_TTY" (getenv "TTY"))

(require 'auth-source)

(defun my/get-canvas-ics-url ()
  "Safely retrieve and decrypt the Canvas ICS URL from ~/.authinfo.gpg."
  (let ((match (car (auth-source-search :host "canvas-calendar" :port "ics"))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret) (funcall secret) secret))
      (error "Could not find 'canvas-calendar' entry in authinfo file"))))

(defvar my/canvas-diary-file (expand-file-name "canvas-diary" org-directory))

(defun my/canvas-sync ()
  "Fetch the Canvas ICS feed and import assignments into a diary file."
  (interactive)
  (let ((tmp-ics (make-temp-file "canvas" nil ".ics"))
        (url (my/get-canvas-ics-url)))
    (url-copy-file url tmp-ics t)
    (with-temp-file my/canvas-diary-file "")
    (icalendar-import-file tmp-ics my/canvas-diary-file t)
    (delete-file tmp-ics)
    (message "Canvas calendar synced.")))

(setq lsp-clients-clangd-executable "clangd")
(setq lsp-clients-clangd-args '("-j=6" "--background-index"))
