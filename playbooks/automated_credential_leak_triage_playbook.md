# Automated Credential Leak Triage Playbook

## Overview
This playbook automates the triage process for alerts triggered by credential leak detection rules. It is designed to streamline investigation, validation, and initial containment steps to reduce response time and improve accuracy.

## Alert Pattern
The automated triage targets common credential leak vectors using regex patterns similar to manual detection rules:

1. **Detect AWS Access Keys**
   - Regex: `AKIA[0-9A-Z]{16}`
   - Description: Detect AWS Access Key IDs typically used in AWS services.

2. **Detect AWS Secret Access Keys**
   - Regex: `(?i)aws(.{0,20})?(secret|access)?(.{0,20})?["']?[0-9a-zA-Z/+]{40}["']?`
   - Description: Detect AWS Secret Access Keys often paired with Access Key IDs.

3. **Detect Generic API Keys**
   - Regex: `(?i)(api_key|apikey|api-key|token|auth_token|access_token)["'=:\s]+[0-9a-zA-Z]{16,40}`
   - Description: Detect common API key patterns used in various services.

4. **Detect Private RSA Keys**
   - Regex: `-----BEGIN PRIVATE KEY-----[\s\S]+?-----END PRIVATE KEY-----`
   - Description: Detect private RSA keys which should never be exposed in code or logs.

5. **Detect Basic Auth Credentials in URLs**
   - Regex: `https?:\/\/[^\/\s]+:[^\/\s]+@[^\/\s]+`
   - Description: Detect URLs containing embedded basic auth credentials.

6. **Detect Password Assignments**
   - Regex: `(?i)(password|passwd|pwd)["'=:\s]+.{6,}`
   - Description: Detect common password variable assignments in code or config files.

## Automated Response Steps

### 1. Alert Triage Automation
- Automatically verify alert against detection rule and severity.
- Extract leaked credential details and metadata.
- Assign priority based on exposure context and credential type.

### 2. Automated Investigation
- Cross-reference credential against known active credentials (if integrated).
- Check source and scope of exposure automatically.
- Flag alerts with high risk for manual review.

### 3. Initial Containment
- Trigger automatic credential rotation or revocation workflows (if supported).
- Apply temporary network or access controls to limit exposure.

### 4. Notification and Escalation
- Send automated notifications to security teams with detailed findings.
- Escalate high-priority alerts to on-call responders.

### 5. Continuous Monitoring
- Monitor for repeated or related credential leak alerts.
- Update automated triage rules based on incident feedback.

## References
- [Best practices for secret management](https://example.com/secret-management-best-practices)

## Notes
- Automated triage reduces human workload but requires validation of false positives.
- Integration with credential management systems enhances effectiveness.

---

_Last updated: 2026-04-30_