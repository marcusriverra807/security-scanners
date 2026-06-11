# Credential Leak Detection Playbook v2

## Overview
This updated playbook takes the already impressive credential leak detection game up a notch. Because let's face it, secrets leaked are like bad jokes — nobody wants to hear them, but sometimes they just slip out! This guide will help our security heroes catch those sneaky leaks before they become embarrassing headlines.

## Alert Pattern
We're still on the lookout for the usual suspects: exposed API keys, passwords, tokens, and other sensitive goodies lurking in code, logs, or network traffic. Our regex detectives have been busy crafting patterns to catch them all:

1. **Detect AWS Access Keys**
   - Regex: `AKIA[0-9A-Z]{16}`
   - Description: The classic AWS Access Key ID, like a VIP pass you don’t want falling into the wrong hands.

2. **Detect AWS Secret Access Keys**
   - Regex: `(?i)aws(.{0,20})?(secret|access)?(.{0,20})?["']?[0-9a-zA-Z/+]{40}["']?`
   - Description: Secret keys that are supposed to stay secret. Spoiler: they don’t like being leaked.

3. **Detect Generic API Keys**
   - Regex: `(?i)(api_key|apikey|api-key|token|auth_token|access_token)["'=:\s]+[0-9a-zA-Z]{16,40}`
   - Description: Catch-all for those sneaky API tokens trying to play hide and seek.

4. **Detect Private RSA Keys**
   - Regex: `-----BEGIN PRIVATE KEY-----[\s\S]+?-----END PRIVATE KEY-----`
   - Description: Private keys are like your diary — keep them locked tight.

5. **Detect Basic Auth Credentials in URLs**
   - Regex: `https?:\/\/[^\/\s]+:[^\/\s]+@[^\/\s]+`
   - Description: URLs with embedded usernames and passwords — the digital equivalent of writing your password on a sticky note.

6. **Detect Password Assignments**
   - Regex: `(?i)(password|passwd|pwd)["'=:\s]+.{6,}`
   - Description: Passwords lurking in code or config files, trying to sneak by.

## Response Steps

### 1. Alert Triage
- Confirm the alert matches our regex party crashers.
- Prioritize based on context and severity — not all leaks are equally dramatic.
- Get the juicy details of the leaked secret.

### 2. Investigation
- Where did this slip-up happen? Repo? Logs? Network?
- Is the leaked credential still valid, or just ancient history?
- Check our trusty test cases and known patterns.

### 3. Containment
- Revoke or rotate those keys faster than you can say "Oops!"
- Block or isolate affected systems — no freeloaders allowed.
- Put up temporary shields (filters/rules) to stop automated attacks.

### 4. Remediation
- Scrub those secrets from code and logs like a pro cleaner.
- Educate the team — secret management isn’t just for spies.
- Implement secure storage solutions because passwords deserve a safe home.

### 5. Recovery
- Keep an eye out for repeat offenders.
- Post-incident review: what did we learn? How can we do better?

## References
- [Best practices for secret management](https://example.com/secret-management-best-practices)

## Notes
- False positives happen — not every alert is a scandal.
- Quick action saves the day (and reputations).

---

_Last updated: 2026-04-30_
