{
  checkers = [
    { mod = "syntax"; args = [ "childframe" ]; }
  ];

  completion = [
    { mod = "vertico"; args = [ "icons" ]; }
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
    "org"
    "sh"
  ];

  ui = [
    "doom"
    "doom-dashboard"
    { mod = "emoji"; args = [ "github" "unicode" ]; }
    "hydra"
    "modeline"
  ];

  tools = [
    "magit"
  ];
}
