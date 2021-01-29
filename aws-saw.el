;;; aws-saw.el --- Helpers for retrieving logs from AWS. -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2019, by Hindol Adhya, Tatu Lahtela

;; Author: Tatu Lahtela <tatu@lahtela.me>
;; Version: 0.0.1
;; Created: 2021-01-28
;; Keywords: aws
;; Homepage: https://github.com/ration/aws-saw.el

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU General Public License version 2.

;;; Commentary:

;; Highlighting and indentation for Kusto https://docs.microsoft.com/en-us/azure/kusto/query/index

;;; Code:

(defcustom aws-saw-command "/usr/local/bin/saw" "Path to saw")
(defcustom aws-saw-default-get-logs "-10h")

(defun aws-saw-command (args)
  (shell-command-to-string (format "%s %s" aws-saw-command args)))

(defun aws-saw-select-group ()
  (interactive)
  (completing-read "Select group: "
                   (split-string (aws-saw-command "groups"))))

(defun aws-saw-get-log ()
  "Prompt for aws log group and dump last -200h lines to *saw*"
  (interactive)
  (let ((group (aws-saw-select-group)))
    (switch-to-buffer (generate-new-buffer (format "*%s*" group)))
    (goto-char (point-max))
    (insert (aws-saw-command (format "get --start %s %s" aws-saw-default-get-logs group)))))





