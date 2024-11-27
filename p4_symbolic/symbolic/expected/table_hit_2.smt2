; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x54 (= ?x41 (- 1))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) true) $x54)))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) true) (= ?x41 0))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let ((?x65 (ite $x54 (- 1) (ite $x44 (ite $x48 0 (- 1)) (- 1)))))
 (let (($x64 (ite $x54 false (ite $x44 $x45 false))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) $x64) (= ?x65 (- 1)))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let ((?x65 (ite $x54 (- 1) (ite $x44 (ite $x48 0 (- 1)) (- 1)))))
 (let (($x64 (ite $x54 false (ite $x44 $x45 false))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) $x64) (= ?x65 0))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x60 (ite $x54 (ite $x58 0 (- 1)) (- 1))))
 (let (($x59 (ite $x54 $x55 false)))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) $x59) (= ?x60 (- 1)))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x60 (ite $x54 (ite $x58 0 (- 1)) (- 1))))
 (let (($x59 (ite $x54 $x55 false)))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) $x59) (= ?x60 0))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) true) (= (- 1) (- 1)))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun h1.f1 () (_ BitVec 8))
(declare-fun h1.f2 () (_ BitVec 8))
(declare-fun h1.f3 () (_ BitVec 8))
(assert
 (let (($x100 (= standard_metadata.ingress_port (_ bv7 9))))
 (let (($x95 (= standard_metadata.ingress_port (_ bv6 9))))
 (let (($x90 (= standard_metadata.ingress_port (_ bv5 9))))
 (let (($x85 (= standard_metadata.ingress_port (_ bv4 9))))
 (let (($x80 (= standard_metadata.ingress_port (_ bv3 9))))
 (let (($x76 (= standard_metadata.ingress_port (_ bv2 9))))
 (let (($x72 (= standard_metadata.ingress_port (_ bv1 9))))
 (let (($x77 (or (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x72) $x76)))
 (or (or (or (or (or $x77 $x80) $x85) $x90) $x95) $x100))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x83 (or (or (or (or false (= ?x63 (_ bv0 9))) (= ?x63 (_ bv1 9))) (= ?x63 (_ bv2 9))) (= ?x63 (_ bv3 9)))))
 (let (($x103 (or (or (or (or $x83 (= ?x63 (_ bv4 9))) (= ?x63 (_ bv5 9))) (= ?x63 (_ bv6 9))) (= ?x63 (_ bv7 9)))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (or $x39 $x103)))))))))))))))
(assert
 (let (($x37 (and true (and true (= h1.f1 (_ bv255 8))))))
 (let ((?x43 (ite $x37 (_ bv1 9) (ite true (concat (_ bv0 8) (_ bv0 1)) standard_metadata.egress_spec))))
 (let ((?x41 (ite $x37 0 (- 1))))
 (let (($x44 (and (distinct ?x41 (- 1)) true)))
 (let (($x45 (and true $x44)))
 (let (($x48 (and $x45 (and true (= h1.f2 (_ bv255 8))))))
 (let (($x54 (= ?x41 (- 1))))
 (let (($x55 (and true $x54)))
 (let (($x58 (and $x55 (and true (= h1.f3 (_ bv255 8))))))
 (let ((?x63 (ite $x58 (_ bv3 9) (ite $x48 (_ bv2 9) ?x43))))
 (let (($x39 (= ?x63 (_ bv511 9))))
 (and (and (not $x39) true) (= (- 1) (- 1)))))))))))))))
(check-sat)

