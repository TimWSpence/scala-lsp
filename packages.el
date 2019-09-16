;;; packages.el --- scala-lsp layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Tim Spence <tim@Tims-MacBook-Pro-2>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `scala-lsp-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `scala-lsp/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `scala-lsp/pre-init-PACKAGE' and/or
;;   `scala-lsp/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst scala-lsp-packages
  '(
    scala-mode
    sbt-mode
    flycheck
    lsp-mode
    lsp-ui
    company-lsp
    counsel-gtags
    ggtags
    helm-gtags
    )
  "The list of Lisp packages required by the scala-lsp layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun scala-lsp/init-scala-mode ()
    (use-package scala-mode
	:defer t))

(defun scala-lsp/init-sbt-mode ()
    (use-package sbt-mode
      :defer t
      :commands sbt-start sbt-command
      :config
      ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
      ;; allows using SPACE when in the minibuffer
      (substitute-key-definition
       'minibuffer-complete-word
       'self-insert-command
       minibuffer-local-completion-map)
      :init
    	(progn
          (spacemacs/declare-prefix-for-mode 'scala-mode "mc" "sbt")
      	  (spacemacs/set-leader-keys-for-major-mode 'scala-mode
        "cc" 'sbt-command))))


(defun scala-lsp/post-init-lsp-mode ()
    (use-package lsp-mode
      ;; Optional - enable lsp-mode automatically in scala files
      :hook (scala-mode . lsp)
      :config
        (progn
	  (setq lsp-prefer-flymake nil)
          (add-to-list 'spacemacs-jump-handlers-scala-mode 'lsp-find-definition))))

(defun scala-lsp/post-init-flycheck ()
    (use-package flycheck
      :defer t
      :init (global-flycheck-mode)))

(defun scala-lsp/post-init-lsp-ui ()
    (use-package lsp-ui
      :defer t))

(defun scala-lsp/post-init-company-lsp ()
    (use-package company-lsp
      :defer t))

(defun scala-lsp/post-init-ggtags ()
  (add-hook 'scala-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

(defun scala-lsp/post-init-counsel-gtags ()
  (spacemacs/counsel-gtags-define-keys-for-mode 'scala-mode))

(defun scala-lsp/post-init-helm-gtags ()
  (spacemacs/helm-gtags-define-keys-for-mode 'scala-mode))

;;; packages.el ends here
