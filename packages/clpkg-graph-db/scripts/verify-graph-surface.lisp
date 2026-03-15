;;; verify-graph-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(format t "=== Graph DB ADTs ===~%")
(chk "/home/slime/projects/clpkg-graph-db/src/core/graph-types.coal"
     '("module Core.GraphTypes" "data PropertyValue" "data NodeLabel" "data GraphNode"
       "data EdgeType" "data GraphEdge" "data TraversalDirection" "data TraversalStep"
       "data PathResult" "data GraphPattern" "data MatchClause" "data GraphIndex"
       "data GraphTransaction" "data GraphConfig" "data GraphResult"
       "node-has-label" "edge-connects" "path-length" "pattern-node-count"))
(format t "=== ALL 19 CHECKS PASSED ===~%") (sb-ext:exit :code 0)
