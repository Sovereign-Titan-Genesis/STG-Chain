# Security Policy — STG-Chain

## Supported Versions
STG-Chain is under active development. Only the latest branch (`main`) is supported for security updates.

## Reporting a Vulnerability
If you discover a security issue:
1. **Do not open a public issue.**
2. Send a private disclosure to the Sovereign Titan Genesis security team:
   - Email: security@sovereign-titan-genesis.org
   - Subject: [SECURITY] Vulnerability Report
3. Include:
   - Description of the issue
   - Steps to reproduce
   - Potential impact
   - Suggested mitigation (if any)

We will acknowledge receipt within 72 hours and provide a timeline for resolution.

## Responsible Disclosure
- Vulnerabilities will be patched before public disclosure.
- Contributors must not exploit or weaponize vulnerabilities.
- Security fixes require review by **Sentinel Governance** (Compliance & Auditor roles).

## Scope
- Smart contracts: `SovereignToken.sol`, `CarbonShard.sol`, `Governance.sol`
- Cosmos SDK modules: `stg`, `cshard`, `identity`, `gov`
- Bridge relayers and validator nodes
- Key management (priv_validator_key.json, multisig treasury)

## Out of Scope
- Third-party dependencies outside STG-Chain repo
- User misconfiguration of local environments

## Security Philosophy
STG-Chain is sovereign and antifragile. We embrace:
- **Transparency:** All fixes documented in CHANGELOG.
- **Auditability:** Sentinel logs every compliance event.
- **Resilience:** Chain designed to grow stronger under attack.
