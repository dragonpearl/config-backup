(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
   ("marmalade" . "http://marmalade-repo.org/packages/")
   ("melpa" . "http://melpa.milkbox.net/packages/")))
;;自动加载包管理器下载的包
(let ((default-directory "~/.emacs.d/elpa/"))
(normal-top-level-add-subdirs-to-load-path))
;(add-to-list 'load-path "~/.emacs.d/elpa/auto-highlight-symbol-1.55")
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(with-no-warnings
   (require 'cl))
;;yasnippet
;;(require 'yasnippet)
;;(yas-global-mode 1)

;;hide toolbar
(tool-bar-mode -1)
;;显示列号
(setq column-number-mode t);;显示在任务栏
(global-linum-mode t);;左边栏
;;tab字符来indent
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-stop-list ())
;;缺省mode 为text-mode
(setq default-major-mode 'text-mode)
;;可以直接打开显示图片
(auto-image-file-mode)
;;htmlize
(add-to-list 'load-path "/home/eric/.emacs.d/")
(require 'htmlize)
(require 'org-html5presentation);;使用 org-export-as-html5-.....

;;org src 高亮
(setq org-src-fontify-natively t)

;;语法高亮
(global-font-lock-mode t)
(font-lock-add-keywords 'lisp-mode '("[(]" "[)]"))
;;高亮显示区域选择
(transient-mark-mode t)
;;跨程序拷贝
;;(setq x-select-enable-clipboard t))

;;备份文件禁用
(setq make-backup-files nil)
;;切换buffer
(require 'wcy-swbuffer)
;; then you can use <C-tab> and <C-S-iso-lefttab> to switch buffer.
(global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward)
(global-set-key (kbd "<C-S-iso-lefttab>") 'wcy-switch-buffer-backward)
(setq wcy-switch-buffer-active-buffer-face  'highlight)
(setq wcy-switch-buffer-inactive-buffer-face  'secondary-selection )

;;执行代码块
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh .t)
   (python .t)
   (emacs-lisp .t)
   ))
(put 'downcase-region 'disabled nil)

;;发布webiste

(require 'org-publish)
(setq org-publish-project-alist
  '(
        ("org-notes"               ;used to export .org file
         :base-directory "/media/personal/website/www/"  ;directory holds .org files 
         :base-extension "org"     ;process .org file only    
         :publishing-directory "/media/personal/website/public_html/"    ;export destination
         ;:publishing-directory "/ssh:user@server" ;export to server
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4               ; Just the default for this project.
         :auto-preamble t
         :auto-sitemap t                  ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :export-creator-info nil    ; Disable the inclusion of "Created by Org" in the postamble.
         :export-author-info nil     ; Disable the inclusion of "Author: Your Name" in the postamble.
         :auto-postamble nil         ; Disable auto postamble 
         :table-of-contents t        ; Set this to "t" if you want a table of contents, set to "nil" disables TOC.
         :section-numbers nil        ; Set this to "t" if you want headings to have numbers.
         :html-postamble "    <p class=\"postamble\">Last Updated %d.</p> " ; your personal postamble
         :style-include-default nil  ;Disable the default css style
        )
        ("org-static"                ;Used to publish static files
         :base-directory "/media/personal/website/www/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "/media/personal/website/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org" :components ("org-notes" "org-static")) ;combine "org-static" and "org-static" into one function call
))

;;补全工具 m-/
;;(global-set-key (kbd "m-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs try-expand-dabbrev
        try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially try-complete-lisp-symbol
        try-complete-file-name-partially try-complete-file-name))

(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/eric/.emacs.d/ac-dict")
(ac-config-default)
;;c++补全
;;(require 'cedet)
;; ;; semantic toggle, Tag information  
;; (require 'semantic/ia)  
;; (setq-mode-local c-mode semanticdb-find-default-throttle  
;;          '(project unloaded system recursive))  
;; (setq-mode-local c++-mode semanticdb-find-default-throttle  
;;          '(project unloaded system recursive)) 
;;scheme --lisp-- config
(add-to-list 'load-path "/opt/slime/")  ; your SLIME directory
(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup)
;;颜色配色
(load-theme 'dichromacy t)
;;括号高亮
(show-paren-mode 1)
(setq show-paren-style 'parentheses)

;;自动补全括号对等
;;(add-to-list 'load-path "~/.emacs.d/elpa/smartparens-20130804.1820")
;;(add-to-list 'load-path "~/.emacs.d/elpa/dash-20130712.2307")
(require 'smartparens-config)
(smartparens-global-mode 1)
;;org2blog  wordpress 插件

;;(require 'helm-config)
;;(helm-mode 1)
