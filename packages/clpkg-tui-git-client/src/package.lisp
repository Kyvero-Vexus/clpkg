(defpackage #:clpkg-tui-git-client
  (:use #:cl)
  (:export
   #:repo-status #:repo-status-p #:make-repo-status
   #:branch-state #:branch-state-p #:make-branch-state
   #:diff-stat #:diff-stat-p #:make-diff-stat
   #:build-status-view))
