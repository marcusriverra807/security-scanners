# Credential Leak Detection Playbook

## Overview
This playbook provides a structured response plan for alerts triggered by credential leak detection rules. It is designed to guide security analysts through the investigation, validation, containment, and remediation of potential credential leakage incidents.

## Alert Pattern
The alert patterns are based on detection rules targeting common credential leak vectors such as exposed API keys, passwords, tokens, and other sensitive information in source code, logs, or network traffic.

Common detection rules and patterns include:

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

## Response Steps

### 1. Alert Triage
- Verify the alert against the detection rule ID and description.
- Check the context and severity to prioritize response.
- Review the leaked credential data or incident details that triggered the alert.

### 2. Investigation
- Analyze the source of the alert (e.g., source code repository, network logs, application logs).
- Validate if the exposed credential is active and the extent of exposure.
- Consult known credential patterns and detection rule test cases for reference.

### 3. Containment
- Immediately revoke or rotate exposed credentials if possible.
- Block access or isolate affected systems to prevent further leakage.
- Apply temporary filters or rules to prevent automated exploitation.

### 4. Remediation
- Remove exposed credentials from source code or logs.
- Educate developers and staff on secure credential management practices.
- Implement secure storage solutions such as secret management tools.

### 5. Recovery
- Monitor for any further credential leak alerts.
- Conduct a post-incident review and update detection rules and response plans as needed.

## References
- [Best practices for secret management](https://example.com/secret-management-best-practices)

## Notes
- False positives are possible; validate alerts carefully.
- Prompt response is critical to minimize risk from leaked credentials.

---

_Last updated: 2026-04-30_