;; HOOKS

(defmacro hook-if (hook predicate &rest body)
  `(add-hook ,hook (lambda ()
                     (if ,predicate
                         (progn
                           ,@body)))))

(defmacro hook-unless (hook predicate &rest body)
  `(hook-if ,hook (not ,predicate) ,@body))

(defun major-mode-match-p (mode)
  (string-match mode (symbol-name major-mode)))

(hook-unless 'find-file-hook (major-mode-match-p "makefile") (untabify-all))
(hook-unless 'find-file-hook buffer-read-only (delete-trailing-whitespace))
(hook-unless 'before-save-hook (major-mode-match-p "makefile") (untabify-all))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'auto-make-directory)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'emms-player-started-hook 'emms-show)

(add-hook
 'magit-status-mode-hook
 (lambda ()
   (define-key magit-mode-map (kbd "Z") 'magit-quick-stash)))

(add-hook
 'dired-mode-hook
 (lambda ()
   (define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory)
   (define-key dired-mode-map (kbd "e") 'dired-efap)))

(add-hook
 'ruby-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)
   (rvm-activate-corresponding-ruby)
   (flymake-ruby-load)))

(add-hook
 'js-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)))

(add-hook
 'coffee-mode-hook
 (lambda ()
   (smart-indent-rigidly-mode)))

(add-hook
 'sass-mode-hook
 (lambda ()
   (smart-indent-rigidly-mode)))

(add-hook
 'haml-mode-hook
 (lambda ()
   (smart-indent-rigidly-mode)))

(add-hook
 'css-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)))

(add-hook
 'magit-log-edit-mode-hook
 (lambda ()
   (flyspell-mode)
   (set-fill-column 72)))

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (linum-mode)
   (paredit-mode +1)))

(add-hook
 'lisp-mode-hook
 (lambda ()
   (linum-mode)
   (paredit-mode +1)
   (if (string-match "stumpwmrc$" buffer-file-name)
       (stumpwm-mode))))

(add-hook
 'lisp-interaction-mode-hook
 (lambda ()
   (paredit-mode +1)))

(add-hook
 'slime-repl-mode-hook
 (lambda ()
   (paredit-mode +1)))

(provide 'my-hooks)
