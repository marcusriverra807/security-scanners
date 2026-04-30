# Tuning Plan for New XSS Detection Rules

## 1. General Approach
- Prioritize rules with high severity and higher false positive rates for early and frequent tuning.
- Use synthetic test cases and real-world data to validate rule accuracy.
- Leverage runbook guidance for specific rule contexts and tuning recommendations.
- Implement feedback loops with detection analysts to refine rule thresholds and filters.

## 2. Rule-Specific Tuning Actions

### Rule ID: new-xss-001 (URL encoding attacks)
- Severity: High, FP Rate: 2%
- Actions: Analyze false positives from legitimate encoded URLs; whitelist common safe patterns; tune pattern matching sensitivity.

### Rule ID: new-xss-002 (DOM-based XSS)
- Severity: High, FP Rate: 3%
- Actions: Monitor client-side script complexity; implement context-aware filtering; validate against known benign DOM manipulations.

### Rule ID: new-xss-003 (Deprecated HTML attribute usage)
- Severity: Medium, FP Rate: 5%
- Actions: Review flagged attributes for legitimate legacy usage; create exceptions for known safe cases; consider lowering severity if false positives persist.

### Rule ID: new-xss-004 (Script tag with malicious attributes)
- Severity: High, FP Rate: 2%
- Actions: Validate attribute patterns; tune detection rules to exclude benign script tag attributes used in frameworks or libraries.

### Rule ID: new-xss-005 (Dynamic script execution)
- Severity: High, FP Rate: 1%
- Actions: Validate low false positives; maintain strict detection thresholds; monitor for evasion techniques.

### Rule ID: new-xss-006 (Inline event handlers)
- Severity: High, FP Rate: 3%
- Actions: Differentiate between malicious and legitimate inline handlers; use contextual analysis; whitelist common safe handlers.

### Rule ID: new-xss-007 (SVG element attribute injection)
- Severity: High, FP Rate: 3%
- Actions: Focus on known SVG injection patterns; tune based on application-specific SVG usage; monitor unusual attribute values.

### Rule ID: new-xss-008 (HTML entity encoded script injection)
- Severity: High, FP Rate: 3%
- Actions: Analyze encoding variations; tune for common obfuscation techniques; validate against benign encoded content.

### Rule ID: new-xss-009 (Iframe injection attempts)
- Severity: High, FP Rate: 2%
- Actions: Whitelist trusted iframe sources; monitor for unusual iframe attributes; tune detection for common attack vectors.

### Rule ID: new-xss-010 (Dangerous DOM methods like innerHTML)
- Severity: High, FP Rate: 5%
- Actions: Contextualize usage of DOM methods; implement behavior-based filtering; review false positives regularly.

## 3. Continuous Improvement
- Schedule periodic reviews of rule performance and false positive rates.
- Update tuning parameters based on new attack trends and operational feedback.
- Collaborate with development teams to understand application behavior influencing detections.

Prepared by: Ananya Patel, Detection Engineer
Date: 2026-04-30
