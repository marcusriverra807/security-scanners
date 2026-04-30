# Credential Leak Detection Playbook

## Overview
This playbook provides a structured response plan for alerts triggered by credential leak detection rules. It is designed to guide security analysts through the investigation, validation, containment, remediation, and recovery of potential credential leakage incidents.

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

7. **Detect Azure and GCP Keys**
   - Regex: `(?i)(azure|gcp|google)["'=:\s]+[0-9a-zA-Z\-]{20,40}`
   - Description: Detect Azure and Google Cloud Platform credentials.

8. **Detect OAuth Tokens and JWTs**
   - Regex: `eyJ[a-zA-Z0-9_-]{10,}\.[a-zA-Z0-9_-]{10,}\.[a-zA-Z0-9_-]{10,}`
   - Description: Detect JSON Web Tokens commonly used for OAuth authentication.

9. **Entropy-Based Detection**
   - Description: Detect high entropy strings that may indicate secrets.

## Response Steps

### 1. Alert Triage
- Verify the alert against the detection rule ID and description.
- Check the context, severity, and asset criticality to prioritize response.
- Enrich alerts with threat intelligence and public code repository scans.
- Review leaked credential data or incident details that triggered the alert.

### 2. Investigation
- Analyze the source of the alert (e.g., source code repository, network logs, application logs).
- Validate if the exposed credential is active and determine exposure extent.
- Check credential usage logs for suspicious activity.
- Correlate with other security events such as unusual logins or data exfiltration.
- Consult known credential patterns and detection rule test cases for reference.

### 3. Containment
- Immediately revoke or rotate exposed credentials using automation where possible.
- Block access or isolate affected systems to prevent further leakage.
- Apply temporary filters or rules to prevent automated exploitation.
- Recommend network segmentation to isolate compromised systems.

### 4. Remediation
- Remove exposed credentials from source code or logs.
- Implement secure storage solutions such as HashiCorp Vault, AWS Secrets Manager.
- Integrate automated secret scanning and secure coding practices in CI/CD pipelines.
- Educate developers and staff on secure credential management practices.
- Conduct security awareness training focused on credential handling.

### 5. Recovery
- Monitor for any further credential leak alerts and reused or rotated secrets.
- Conduct a post-incident review and update detection rules and response plans as needed.
- Use incident communication templates to notify stakeholders.

## Playbook Automation
- Integrate playbook steps with SOAR platforms for automated investigation and response.
- Leverage orchestration to revoke credentials, update firewall rules, and notify teams.

## Common False Positives
- Generic strings that match API key patterns but are not actual keys.
- Test or placeholder credentials used in development or testing environments.
- Publicly available keys that are intentionally exposed for demo or public use.
- Long base64 strings that are not secrets but encoded data or certificates.
- Misclassified tokens or strings from unrelated logs or data.

## Escalation and Contact Points
- Security Operations Center (SOC): soc@example.com
- Incident Response Team: irt@example.com
- Cloud Security Team: cloudsec@example.com
- Development Team Lead: devlead@example.com

## References
- [Best practices for secret management](https://example.com/secret-management-best-practices)
- [HashiCorp Vault](https://www.vaultproject.io/)
- [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/)
- [OWASP Credential Management](https://owasp.org/www-project-credential-management/)

## Notes
- False positives are possible; validate alerts carefully.
- Prompt response is critical to minimize risk from leaked credentials.
- Ensure analysts have access to updated detection rules and automation playbooks.
- Maintain clear communication channels for incident escalation.

---

_Last updated: 2026-04-30_