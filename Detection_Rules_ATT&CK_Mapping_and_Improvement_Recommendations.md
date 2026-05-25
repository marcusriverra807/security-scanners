# Detection Rules ATT&CK Mapping and Improvement Recommendations

## Overview
This document provides a detailed mapping of recent scanner outputs, specifically XSS and SQL Injection detection rules and test cases, to the MITRE ATT&CK framework. It also includes actionable recommendations for improving detection accuracy and compliance based on this mapping.

## 1. XSS Test Cases and Corresponding ATT&CK Mappings

- **URL Encoding Attacks, HTML Entity Encoded Script Injection, Double Encoded Script Tag** (new-xss-001, new-xss-008, new-xss-025)
  - **ATT&CK Technique:** T1059.007 (Command and Scripting Interpreter: JavaScript)
  - **Recommendation:** Enhance decoding and normalization of inputs prior to detection to catch encoded payloads.

- **DOM-Based XSS, Mutation-based DOM XSS** (new-xss-002, new-xss-019)
  - **ATT&CK Technique:** T1203 (Exploitation for Client Execution)
  - **Recommendation:** Improve detection of DOM manipulation APIs and suspicious dynamic content injection.

- **Inline Event Handlers, Less Common Event Handlers, Obfuscated Event Handlers** (new-xss-006, new-xss-023, new-xss-026)
  - **ATT&CK Technique:** T1059.007 (Command and Scripting Interpreter: JavaScript)
  - **Recommendation:** Refine regex for event handlers to reduce false positives and account for obfuscation.

- **Script Tags with Attributes, SVG Element Attribute Injection, Iframe Injection** (new-xss-004, new-xss-007, new-xss-009)
  - **ATT&CK Technique:** T1059.007 (JavaScript), T1185 (Man-in-the-Middle)
  - **Recommendation:** Add contextual filtering to exclude trusted sources and whitelist safe attributes.

- **Dynamic Script Execution, Obfuscated Eval Function Call** (new-xss-005, new-xss-027)
  - **ATT&CK Technique:** T1059.007 (JavaScript)
  - **Recommendation:** Monitor eval and other dynamic code execution methods with enhanced context.

- **Suspicious CSS Expressions, Content Security Policy Violations** (new-xss-012, new-xss-013)
  - **ATT&CK Technique:** T1059.007 (JavaScript)
  - **Recommendation:** Detect CSS expressions and CSP violations as potential attack indicators.

## 2. SQL Injection Test Cases and Corresponding ATT&CK Mappings

- **Time-Based SQL Injection** (new-sql-001)
  - **ATT&CK Technique:** T1190 (Exploit Public-Facing Application)
  - **Recommendation:** Extend detection to cover time delays and comment-based obfuscation patterns.

## 3. Sensitive Data Test Cases

- **Hardcoded API Keys, Passwords** (sensitive-001, sensitive-002)
  - **ATT&CK Technique:** T1552 (Unsecured Credentials)
  - **Recommendation:** Detect and flag hardcoded secrets and credentials in codebases.

## General Recommendations for Detection Improvements

- Implement input decoding and normalization processes to detect obfuscated and encoded payloads effectively.
- Enhance contextual filtering using metadata such as source domains, request types, and encoding methods to reduce false positives.
- Collaborate with application teams to verify input sanitation and incorporate this knowledge into detection rules.
- Regularly update regex patterns to cover new obfuscation techniques and emerging attack vectors.
- Maintain continuous feedback loops with synthetic and real-world test cases for ongoing rule tuning.
- Expand detection to include suspicious CSS, CSP violations, and dynamic script execution methods.
- Utilize priority matrices to focus efforts on high-risk and high-impact detections.
- Document all tuning actions, false positives, and rationale for audit and continuous improvement.

## Conclusion
This mapping and recommendations document serves as a reference for aligning detection rules with MITRE ATT&CK techniques and guiding actionable improvements to enhance security scanner effectiveness and compliance.