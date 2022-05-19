{
  checkers = [
    { mod = "syntax"; args = [ "childframe" ]; }
  ];

  completion = [
    { mod = "helm"; args = [ "fuzzy" ]; }
    { mod = "company"; args = [ "tng" ]; }
  ];

  config = [
    { mod = "default"; args = [ "bindings" "smartparens" ]; }
  ];

  editor = [
    { mod = "evil"; args = [ "everywhere" ]; }
    "file-templates"
    "fold"
    "snippets"
  ];

  emacs = [
    { mod = "dired"; args = [ "icons" "ranger" ]; }
    { mod = "ibuffer"; args = [ "icons" ]; }
    { mod = "undo"; args = [ "tree" ]; }
    "imenu"
  ];

  lang = [
    "emacs-lisp"
    "sh"
  ];

  ui = [
    "doom"
    "doom-dashboard"
    "doom-quit"
    { mod = "emoji"; args = [ "github" "unicode" ]; }
    "hydra"
    "modeline"
  ];
}
