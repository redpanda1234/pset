(TeX-add-style-hook
 "fkpresentation-example"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("csquotes" "style=british")))
   (TeX-run-style-hooks
    "latex2e"
    "fkpresentation"
    "fkpresentation10"
    "csquotes")
   (TeX-add-symbols
    '("od" ["argument"] 2)
    '("pd" ["argument"] 2)
    "pdd"
    "dd"
    "signed")
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 0)
    '("problem" LaTeX-env-args ["argument"] 0)
    '("aquote" 1))
   (LaTeX-add-bibliographies
    "aha.bib")
   (LaTeX-add-saveboxes
    "mybox"))
 :latex)

