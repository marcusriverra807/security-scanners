# New XSS Detection Rules Documentation

## Overview
This documentation provides details on the newly integrated XSS detection rules added to the security scanner framework. These rules enhance detection coverage for a broad range of XSS attack vectors and include sophisticated patterns for modern attack techniques.

---

## Detection Rules Summary

| Rule ID    | Description                                    | Severity | Estimated False Positive Rate | Runbook Link                                |
|------------|------------------------------------------------|----------|-------------------------------|--------------------------------------------|
| new-xss-001 | Detect URL encoding attacks                    | High     | 2%                            | [Runbook](https://example.com/runbook/url-encoding)         |
| new-xss-002 | Detect DOM-based XSS                           | High     | 3%                            | [Runbook](https://example.com/runbook/dom-xss)              |
| new-xss-003 | Detect deprecated HTML attribute usage        | Medium   | 5%                            | [Runbook](https://example.com/runbook/deprecated-html)      |
| new-xss-004 | Detect script tag with malicious attributes    | High     | 2%                            | [Runbook](https://example.com/runbook/script-tag-attributes) |
| new-xss-005 | Detect dynamic script execution                | High     | 1%                            | [Runbook](https://example.com/runbook/dynamic-script)       |
| new-xss-006 | Detect inline event handlers                    | High     | 3%                            | [Runbook](https://example.com/runbook/inline-event-handlers) |
| new-xss-007 | Detect SVG element attribute injection         | High     | 3%                            | [Runbook](https://example.com/runbook/svg-attribute-injection) |
| new-xss-008 | Detect HTML entity encoded script injection    | High     | 3%                            | [Runbook](https://example.com/runbook/html-entity-encoded)  |
| new-xss-009 | Detect iframe injection attempts                | High     | 2%                            | [Runbook](https://example.com/runbook/iframe-injection)     |
| new-xss-010 | Detect dangerous DOM methods like innerHTML    | High     | 5%                            | [Runbook](https://example.com/runbook/dangerous-dom-methods) |

---

## Usage
- These rules are automatically loaded and applied by the security scanner during scans.
- They are supported by synthetic test cases to validate detection efficacy.
- Refer to the linked runbooks for detailed response and mitigation steps.

---

## Maintenance
- Review and update these rules periodically to keep pace with evolving XSS techniques.
- Adjust false positive tolerances based on operational feedback.

For any questions or support, contact the Detection Engineering team.

---

Prepared by: Ananya Patel, Detection Engineer
Date: 2026-04-30
