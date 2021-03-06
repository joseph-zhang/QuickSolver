;;;; basic config
(require 'package)
(setq package-archives
			'(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
				("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.1)
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode nim-mode c-mode cc-mode c++-mode objc-mode swift-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode rust-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js-jsx-mode js2-mode js2-jsx-mode coffee-mode php-mode css-mode scss-mode less-css-mode elixir-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode web-mode ts-mode sclang-mode verilog-mode qml-mode apples-mode haskell-mode fundamental-mode racket-mode latex-mode ac-modes)))
 '(column-number-mode t)
 '(custom-enabled-themes nil)
 '(flyspell-abbrev-p t)
 '(flyspell-after-incorrect-word-string nil)
 '(font-use-system-font t)
 '(global-auto-complete-mode t)
 '(global-linum-mode t)
 '(package-selected-packages
   (quote
    (rust-mode robe flymake-ruby rinari ac-geiser racket-mode haskell-mode auto-complete)))
 '(show-paren-mode t)
 '(size-indication-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "Mono" :slant normal :weight normal :height 128 :width normal)))))

;; colour setting
(set-background-color "gray20")
(set-foreground-color "white")
(set-face-foreground 'region "green")
(set-face-background 'region "blue")

;; set English font
(set-face-attribute
 'default nil :font "Courier New 16")

;; set Chinese font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "KaiTi_GB2312" :size 21)))

;; auctex config
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; latex config
(setq TeX-output-view-style (quote (("^pdf$" "." "evince %o %(outpage)"))))

(add-hook 'LaTeX-mode-hook (lambda()
		(setq Tex-global-PDF-mode t TeX-engine 'xetex)
        (add-to-list 'TeX-command-list '("XeLaTeX" "%'xelatex%(mode)%' %t" TeX-run-TeX nil t))
        (setq TeX-command-default "XeLaTeX")
        (TeX-PDF-mode t)
        (setq TeX-save-query  nil )
        (setq TeX-show-compilation nil)
        (outline-minor-mode)
        (hide-body)
))

; transparent
;(set-frame-parameter nil 'alpha '(95 . 100))
;;set transparent effect
(global-set-key [(f11)] 'loop-alpha)
(setq alpha-list '((95 65) (100 100) (85 55) (75 45) (65 35)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
)

; change fringe bent arrows
(define-fringe-bitmap 'right-curly-arrow
  [#b00000000
   #b00000000
   #b00000000
   #b00000000
   #b01110000
   #b00010000
   #b00010000
   #b00000000])
(define-fringe-bitmap 'left-curly-arrow
  [#b00000000
   #b00001000
   #b00001000
   #b00001110
   #b00000000
   #b00000000
   #b00000000
   #b00000000])

; Hide what we don't need
(tool-bar-mode -1)
(setq inhibit-splash-screen t)
