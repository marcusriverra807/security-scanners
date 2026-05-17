# Sample Inputs and Outputs for Credential Leak Detection Playbook

## Sample Inputs

### Input 1: Alert for AWS Access Key Exposure
- Alert ID: 1001
- Detection Rule: Detect AWS Access Keys
- Alert Description: AWS Access Key ID exposed in public GitHub repository
- Source: GitHub Repository URL
- Credential Snippet: AKIA1234567890ABCDEF
- Asset Criticality: High

### Input 2: Alert for Private RSA Key Exposure
- Alert ID: 1002
- Detection Rule: Detect Private RSA Keys
- Alert Description: Private RSA Key found in application logs
- Source: Application Logs
- Credential Snippet: -----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASC...
- Asset Criticality: Medium

## Sample Outputs

### Output 1: Response to AWS Access Key Exposure
- Triage: Confirmed alert, severity high, asset critical.
- Investigation: Verified key is active, exposure in public repo, no suspicious usage found.
- Containment: Rotated AWS key, blocked access to compromised asset.
- Remediation: Removed key from repo, implemented automated secret scanning.
- Recovery: Monitored for further alerts, conducted post-incident review.

### Output 2: Response to Private RSA Key Exposure
- Triage: Confirmed alert, severity medium.
- Investigation: Key found in logs, inactive key confirmed.
- Containment: Isolated affected system, applied temporary filters.
- Remediation: Removed key from logs, educated staff on secure logging.
- Recovery: No further alerts, incident closed.
