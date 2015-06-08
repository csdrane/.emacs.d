;;; org-drill-table-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "org-drill-table" "org-drill-table.el" (21749
;;;;;;  9655 0 0))
;;; Generated autoloads from org-drill-table.el

(autoload 'org-drill-table-generate "org-drill-table" "\
Use a table at the current heading to generate org-drill cards.

HEADING is the title to use for each card.

TYPE is a string, of one of the card types in `org-drill-card-type-alist'.

INSTRUCTIONS is a string describing how to use the card.

\(fn HEADING TYPE INSTRUCTIONS)" t nil)

(autoload 'org-drill-table-update "org-drill-table" "\
Update an existing org drill table.
Suitable for adding to `org-ctrl-c-ctrl-c-hook'.

\(fn)" t nil)

(autoload 'org-drill-table-update-all "org-drill-table" "\
Call `org-drill-table-update' on each table in the buffer.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; org-drill-table-autoloads.el ends here
