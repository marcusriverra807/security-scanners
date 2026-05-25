# XSS Detection Rules Testing and Tuning Plan

This document outlines specific testing plans and tuning suggestions for the XSS detection rules xss-011, xss-010, and xss-012 based on their estimated false positive rates.

---

## Rule xss-011: Detect base64 encoded XSS payloads (FP rate: 10%, Severity: Medium)

### Testing Plan:
- Collect a diverse dataset of known benign base64 encoded payloads from legitimate sources (e.g., data URIs for images, documents).
- Collect a dataset of known malicious base64 encoded XSS payloads.
- Run the detection rule against both datasets to measure true positive and false positive rates.
- Analyze false positives to identify common patterns or contexts that can be excluded.

### Tuning Suggestions:
- Refine the regex pattern to include context checks, e.g., checking for specific suspicious keywords or script patterns within the decoded base64 string.
- Consider implementing a decoding step before applying regex to the decoded content rather than the encoded string itself.
- Introduce whitelisting for known safe base64 content types or sources.

---

## Rule xss-010: Detect usage of dangerous DOM methods (FP rate: 5%, Severity: High)

### Testing Plan:
- Collect examples of benign usage of DOM methods like innerHTML and document.write in well-known safe applications.
- Collect examples of malicious usage exploiting these methods for DOM XSS.
- Test the rule against these datasets to evaluate detection accuracy and false positives.

### Tuning Suggestions:
- Enhance the regex to detect usage patterns indicative of injection (e.g., concatenations with user input) rather than generic method calls.
- Combine static analysis techniques to verify if the content processed by these DOM methods is tainted or not.
- Consider contextual awareness by integrating with other detection rules or runtime monitoring.

---

## Rule xss-012: Detect suspicious CSS expressions and behaviors (FP rate: 5%, Severity: Medium)

### Testing Plan:
- Gather examples of legacy CSS using expressions or behaviors in benign contexts (e.g., legacy internal applications).
- Gather examples of CSS-based XSS attack payloads exploiting these properties.
- Evaluate rule performance on these samples.

### Tuning Suggestions:
- Refine regex to differentiate between malicious use and legacy benign use by looking at surrounding CSS context.
- Consider correlation with browser versions or environments where these expressions are exploitable.
- Monitor and update the rule as legacy browser support declines to potentially reduce false positives.

---

Prepared by: Ananya Patel, Detection Engineer
Date: 2026-04-30
