(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
   ("marmalade" . "http://marmalade-repo.org/packages/")
   ("melpa" . "http://melpa.milkbox.net/packages/")))
;;http://www.cnblogs.com/bamanzi/archive/2011/02/28/emacs-cua-rectangle-cool.html 块操作
;;自动加载包管理器下载的包
(let ((default-directory "~/.emacs.d/elpa/"))
(normal-top-level-add-subdirs-to-load-path))
;(add-to-list 'load-path "~/.emacs.d/elpa/auto-highlight-symbol-1.55")
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(with-no-warnings
   (require 'cl))
 (eval-after-load "sql"
      (load-library "sql-indent"))
;;设置字体 describe-font得到后面字体
(set-default-font "文泉驿等宽微米黑-12")
;;yasnippet 模板补全工具 如for[tab]键补全
(require 'yasnippet)
(yas-global-mode 1)
;;orgmode页脚
(setq org-export-html-postamble nil)
;;hide toolbar
(tool-bar-mode -1)
;;显示列号
(setq column-number-mode t);;显示在任务栏
(global-linum-mode t);;左边栏
;;tab字符来indent
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-stop-list ())
;;靠近屏幕滚动
(setq scroll-margin 2
      scroll-conservatively 10000)
;;窗口大小
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)
;;缺省mode 为text-mode
(setq default-major-mode 'text-mode)
;;可以直接打开显示图片

;;htmlize
(add-to-list 'load-path "/home/eric/.emacs.d/")
(add-to-list 'load-path "/home/eric/.emacs.d/private/")
(require 'htmlize)
(require 'org-html5presentation);;使用 org-export-as-html5-.....

(iswitchb-mode 1)
;;org src 高亮
(setq org-src-fontify-natively t)
(require 'feng-highlight)
(global-set-key (kbd "M-i") 'feng-highlight-at-point)
;;自动编码
(require 'unicad)
;;语法高亮
(global-font-lock-mode t)
(font-lock-add-keywords 'lisp-mode '("[(]" "[)]"))
;;高亮显示区域选择
(transient-mark-mode t)
;;跨程序拷贝
;;(setq x-select-enable-clipboard t))
(global-set-key (kbd "<C-return>") 'set-mark-command)
(global-set-key [(control \`)] 'set-mark-command)
;;备份文件禁用
(setq make-backup-files nil)
;;切换buffer
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(require 'wcy-swbuffer)
;; then you can use <C-tab> and <C-S-iso-lefttab> to switch buffer.
(global-set-key (kbd "M-[") 'wcy-switch-buffer-forward)
(global-set-key (kbd "M-]") 'wcy-switch-buffer-backward)
;(global-set-key (kbd "<C-S-iso-lefttab>") 'wcy-switch-buffer-backward)
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

(defun my_publish_func (plist filename pub-dir)
  "可以将org-publish输出文件加入时间戳"
  (let (html-file html-file-with-date) 
    (setq html-file
         (org-html-publish-to-html plist filename pub-dir))
    (setq html-file-with-date (concat (file-name-directory html-file)
                                      "1970-01-01-" 
                                      (file-name-nondirectory html-file)))
    (rename-file html-file html-file-with-date t)))

(require 'ox-publish)
;<8 (require 'org-publish)
(setq org-publish-project-alist
  '(
        ("org-notes"               ;used to export .org file
         :base-directory "/home/eric/own/website/org/"  ;.org源目录
         :base-extension "org"     ;只处理扩展名
         :publishing-directory "/home/eric/own/website/jekyll/_posts/"    ;输出目录
         :recursive t
         :publishing-function my_publish_func;  org-html-publish-to-html;<8 org-publish-org-to-html
         :headline-levels 4               ;
         :auto-preamble t
         ;; :auto-sitemap t                  ;自动生成 sitemap.org
         ;; :sitemap-filename "sitemap.org"  ;sitemap文件名
         ;; :sitemap-title "Site"         ;sitemap标题
         ;:sitemap-file-entry-format "%t\t\t\t\t%d" ;sitemap链接项格式
         :export-creator-info nil    ;是否关闭"Created by Org"
         :export-author-info nil     ;是否关闭 "Author: Your Name"
         :auto-postamble nil         ;是否关闭自动 postamble 
         :table-of-contents t        ;目录
         :section-numbers nil        ;是否加数字
         :html-postamble "<p class=\"postamble\">Last Updated %d.</p> " 
         :style-include-default nil  ;默认css文件
         ;:html-link-home "/sitemap.html"
         ;:makeindex t
         :body-only t
        )
        ("org-static"                ;Used to publish static files
         :base-directory "/home/eric/own/website/jekyll/static/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "/home/eric/own/html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("org-notes" "org-static")) ;combine "org-static" and "org-static" into one function call
))
;;(global-set-key (kbd "C-c C-e p") 'org-publish)
;;org-mode css
;; (setq org-export-html-style
;;       "<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/style.css\" />")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/eric/.emacs.d/elpa/auto-complete-20140414.2324/dict/")
(ac-config-default)
;c++头文件补全
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))
(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

;;语法解释器 ac-clang-syntax-check可做语法检查
(add-to-list 'load-path "/home/eric/.emacs.d/elpa/auto-complete-clang-async")
(require 'auto-complete-clang-async)
(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "/home/eric/.emacs.d/elpa/auto-complete-clang-async/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)
(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(my-ac-config)
;;cscope
;;优化 http://blog.csdn.net/intrepyd/article/details/4202312
(require 'xcscope)
;;c/c++代码风格 google-c-syle
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(defun my-c-mode-hook ()
  (setq c-basic-offset 4          ;; 基本缩进宽度
        indent-tabs-mode t        ;; 禁止空格替换Tab
        default-tab-width 4))     ;; 默认Tab宽度
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
;;c/c++代码风格 google-c-syle

;;scheme --lisp-- config
;;(add-to-list 'load-path "/opt/slime/")  ; your SLIME directory
;;(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
;;(require 'slime)
;;(slime-setup)
;;颜色配色
(load-theme 'dichromacy t)
;;括号高亮
(show-paren-mode 1)
(setq show-paren-style 'parentheses)
;; 自动补全M-x C-s/C-r
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;;自动补全括号对等
(require 'smartparens-config)
(smartparens-global-mode 1)
;;org2blog  wordpress 插件

;;(require 'helm-config)
;;(helm-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("47583b577fb062aeb89d3c45689a4f2646b7ebcb02e6cb2d5f6e2790afb91a18" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq sgml-basic-offset 4)

;; python-mode settings
;; python coding
;; 1.Pymacs.(make&&python setup.py install)
;; 2.rope (python setup.py install)
;; 3.ropemacs(python setup.py install)
;; complete use M-/
;; show the document use c-c d;c-c p to lookup pydoc; M-/ to rope complete
;; (require 'pymacs)
;; ;; Initialize Pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" 0 t)
;; (autoload 'pymacs-exec "pymacs" 0 t)
;; (autoload 'pymacs-load "pymacs" 0 t)
;; ;; Initialize Rope
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)
;lookup pydoc
(defun hohe2-lookup-pydoc ()
  (interactive)
  (let ((curpoint (point)) (prepoint) (postpoint) (cmd))
    (save-excursion
      (beginning-of-line)
      (setq prepoint (buffer-substring (point) curpoint)))
    (save-excursion
      (end-of-line)
      (setq postpoint (buffer-substring (point) curpoint)))
    (if (string-match "[_a-z][_\\.0-9a-z]*$" prepoint)
        (setq cmd (substring prepoint (match-beginning 0) (match-end 0))))
    (if (string-match "^[_0-9a-z]*" postpoint)
        (setq cmd (concat cmd (substring postpoint (match-beginning 0) (match-end 0)))))
    (if (string= cmd "") nil
      (let ((max-mini-window-height 0))
        (shell-command (concat "pydoc " cmd))))))

(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c p") 'hohe2-lookup-pydoc)))
;;;python end
;;自动截断行
(auto-fill-mode 0)

;;内部css样式到org-mode
; export html with custom inline css
;(defun my-inline-custom-css-hook ()
;  "insert custom inline css content into org export"
;  (let* ( (working-path (ignore-errors (file-name-directory (buffer-file-name))))
;          (custom-css (concat working-path "style.css"))
;          (custom-css-flag (and (not (null working-path)) (not (null (file-exists-p custom-css)))))
;          (target-css (if custom-css-flag
;                          custom-css
;                        "~/.emacs.d/style.css")))
;    ;; (setq org-export-html-style-include-default nil)
;    (setq org-export-html-style (concat
;                         "<style type=\"text/css\">\n"
;                         "<!--/*--><![CDATA[/*><!--*/\n"
;                         (with-temp-buffer
;                           (insert-file-contents target-css)
;                           (buffer-string))
;                         "/*]]>*/-->\n"
;                         "</style>\n"))))
;(add-hook 'org-mode-hook 'my-inline-custom-css-hook)
;;;;;;;;;;;;
(setq org-export-language-setup (append org-export-language-setup '(("zh-CN" "作者" "日期" "目录" "脚注"))))
(setq org-export-default-language "zh-CN")

;;;php
;; (require 'php-mode)
;; ;;根据文件扩展名自动php-mode
;; (add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
;; (add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
;; (add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
;; ;;自动补全; 下载最新php文档http://php.net/download-docs.php (many html file)
;; (global-set-key [(control tab)] 'php-complete-function)
;; (setq php-manual-path "/usr/share/doc/php/php-chunked-xhtml")
;; (require 'web-mode)

;; (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; (defun my-web-mode-hook()
;;   ;; Indentation
;;   (setq web-mode-markup-indent-offset 2)
;;   (setq web-mode-css-indent-offset 4) 
;;   (setq web-mode-code-indent-offset 4)
;;   (setq web-mode-indent-style 2)
  
;;   ;; Highlight current HTML element
;;   (setq web-mode-enable-current-element-highlight t)
;;   (require 'php-mode)
;;   (define-key php-mode-map (kbd "C-c h") 'phpcmp-complete)
  
;;   ;; php completion
;;   (require 'php-completion) 
;;   (php-completion-mode t)

;;   (when (require 'auto-complete nil t)
;;     (make-variable-buffer-local 'ac-sources)
;;     (add-to-list 'ac-sources 'ac-source-php-completion)
;;     (auto-complete-mode t))
;; )
;; ;;http://www.emacswiki.org/emacs/CompanyModeBackends#PhpCompletion
;; (add-hook 'web-mode-hook 'my-web-mode-hook)

;;;php

(add-to-list 'load-path "/home/eric/.emacs.d/private/php-htm-mode")
(load-library "/home/eric/.emacs.d/private/php-htm-mode/multi-mode.el")
