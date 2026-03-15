# clpkg Monorepo Migration

Created: 2026-03-15T03:10:58-04:00

## Source repositories

### clpkg-ad-blocker
- HEAD: a2d38fd
- remote origin: https://github.com/Kyvero-Vexus/clpkg-ad-blocker.git

### clpkg-api-gateway
- HEAD: 41b8fb5
- remote origin: https://github.com/Kyvero-Vexus/clpkg-api-gateway.git

### clpkg-audio-editor
- HEAD: 280af2c
- remote origin: https://github.com/Kyvero-Vexus/clpkg-audio-editor.git

### clpkg-backup-restore
- HEAD: 6daf6ed
- remote origin: https://github.com/Kyvero-Vexus/clpkg-backup-restore.git

### clpkg-cache-store
- HEAD: eba01d2
- remote origin: https://github.com/Kyvero-Vexus/clpkg-cache-store.git

### clpkg-cluster-orchestrator
- HEAD: a5259a9
- remote origin: https://github.com/Kyvero-Vexus/clpkg-cluster-orchestrator.git

### clpkg-container-runtime
- HEAD: e6702e2
- remote origin: https://github.com/Kyvero-Vexus/clpkg-container-runtime.git

### clpkg-cost-dashboard
- HEAD: dc2a122
- remote origin: https://github.com/Kyvero-Vexus/clpkg-cost-dashboard.git

### clpkg-daw
- HEAD: 7779ddd
- remote origin: https://github.com/Kyvero-Vexus/clpkg-daw.git

### clpkg-db-migration
- HEAD: f830003
- remote origin: https://github.com/Kyvero-Vexus/clpkg-db-migration.git

### clpkg-doc-db
- HEAD: 0045f4c
- remote origin: https://github.com/Kyvero-Vexus/clpkg-doc-db.git

### clpkg-email-client
- HEAD: d0426eb
- remote origin: https://github.com/Kyvero-Vexus/clpkg-email-client.git

### clpkg-endpoint-protection
- HEAD: 809cfbd
- remote origin: https://github.com/Kyvero-Vexus/clpkg-endpoint-protection.git

### clpkg-firewall
- HEAD: 73fd874
- remote origin: https://github.com/Kyvero-Vexus/clpkg-firewall.git

### clpkg-forum-client
- HEAD: d8bb5a4
- remote origin: https://github.com/Kyvero-Vexus/clpkg-forum-client.git

### clpkg-graph-db
- HEAD: 9ecc807
- remote origin: https://github.com/Kyvero-Vexus/clpkg-graph-db.git

### clpkg-iac-runner
- HEAD: b410b01
- remote origin: https://github.com/Kyvero-Vexus/clpkg-iac-runner.git

### clpkg-incident-response
- HEAD: 62c3e64
- remote origin: https://github.com/Kyvero-Vexus/clpkg-incident-response.git

### clpkg-irc-client
- HEAD: 97a9c91
- remote origin: https://github.com/Kyvero-Vexus/clpkg-irc-client.git

### clpkg-irc-clients
- HEAD: 95e7bfc
- remote origin: https://github.com/Kyvero-Vexus/clpkg-irc-clients.git

### clpkg-livestream-encoder
- HEAD: e6e1188
- remote origin: https://github.com/Kyvero-Vexus/clpkg-livestream-encoder.git

### clpkg-markdown-notes-app
- HEAD: a5d0151
- remote origin: https://github.com/Kyvero-Vexus/clpkg-markdown-notes-app.git

### clpkg-matrix-xmpp
- HEAD: c5fe687
- remote origin: https://github.com/Kyvero-Vexus/clpkg-matrix-xmpp.git

### clpkg-mfa-auth
- HEAD: 583bb5c
- remote origin: https://github.com/Kyvero-Vexus/clpkg-mfa-auth.git

### clpkg-observability
- HEAD: 14d5c91
- remote origin: https://github.com/Kyvero-Vexus/clpkg-observability.git

### clpkg-password-manager
- HEAD: c43ebed
- remote origin: https://github.com/Kyvero-Vexus/clpkg-password-manager.git

### clpkg-query-ide
- HEAD: 8c9b619
- remote origin: https://github.com/Kyvero-Vexus/clpkg-query-ide.git

### clpkg-rdbms
- HEAD: a25f64c
- remote origin: https://github.com/Kyvero-Vexus/clpkg-rdbms.git

### clpkg-read-later
- HEAD: b048403
- remote origin: https://github.com/Kyvero-Vexus/clpkg-read-later.git

### clpkg-secret-manager
- HEAD: 0f3f24d
- remote origin: https://github.com/Kyvero-Vexus/clpkg-secret-manager.git

### clpkg-service-mesh
- HEAD: 6352162
- remote origin: https://github.com/Kyvero-Vexus/clpkg-service-mesh.git

### clpkg-siem
- HEAD: 0a069a0
- remote origin: https://github.com/Kyvero-Vexus/clpkg-siem.git

### clpkg-social-scheduler
- HEAD: b745a2d
- remote origin: https://github.com/Kyvero-Vexus/clpkg-social-scheduler.git

### clpkg-subtitle-editor
- HEAD: e6bced0
- remote origin: https://github.com/Kyvero-Vexus/clpkg-subtitle-editor.git

### clpkg-team-chat
- HEAD: df047ff
- remote origin: https://github.com/Kyvero-Vexus/clpkg-team-chat.git

### clpkg-tsdb
- HEAD: 63346ca
- remote origin: https://github.com/Kyvero-Vexus/clpkg-tsdb.git

### clpkg-vpn-client
- HEAD: c65c3af
- remote origin: https://github.com/Kyvero-Vexus/clpkg-vpn-client.git

### clpkg-vuln-scanner
- HEAD: 2f5e237
- remote origin: https://github.com/Kyvero-Vexus/clpkg-vuln-scanner.git

## Layout
Each former repository now lives under:
- packages/<repo-name>/

## Notes
- Original repositories were left in place for safety.
- Nested git metadata was not copied into monorepo.
