# XSS and SQL Detection Rules Tuning Plan

This plan outlines detailed tuning adjustments for specific detection rules in the sql-xss-configs.yaml configuration that have a history of false positives.

## 1. Rules with Medium Severity (Potential False Positives)

### Rules: new-xss-003 (Deprecated HTML Attributes), new-xss-006 (Inline Event Handlers)

**Issue:** These rules detect patterns that are common in legitimate HTML usage, leading to false positives.

**Tuning Adjustments:**
- Refine regex patterns to exclude known safe attributes and common HTML elements.
- Add context-aware filtering to differentiate between benign and malicious uses.
- Introduce whitelist capability for trusted sources or attributes.

---

## 2. Event Handler Injection Rules

### Rules: xss-003, xss-004, xss-006, xss-007

**Issue:** These rules flag event handler attributes that are widely used in legitimate web pages.

**Tuning Adjustments:**
- Implement exceptions for attributes originating from trusted domains or sources.
- Use heuristics to check the surrounding code context (e.g., script tags, attribute values) to reduce noise.
- Consider severity reduction for alerts triggered solely by event handlers.

---

## 3. SQL Injection Detection Rules

### Rules: sql-001, sql-002

**Issue:** Detection based on SQL keywords and tautologies may trigger on legitimate queries.

**Tuning Adjustments:**
- Incorporate whitelist filters for known safe query patterns or parameterized queries.
- Add contextual analysis to differentiate between static and dynamic query parts.
- Use anomaly detection techniques to flag unusual query patterns rather than common keywords alone.

---

## 4. Hardcoded Secrets Detection

### Rules: sensitive-001, sensitive-002

**Issue:** May generate false positives by matching non-sensitive strings.

**Tuning Adjustments:**
- Integrate with secret management systems or APIs to verify detected secrets.
- Implement validation steps to confirm the nature of detected strings.
- Add exclusions for known safe tokens or placeholder values.

---

## General Recommendations

- Conduct regular review and tuning cycles based on false positive feedback.
- Use both synthetic and real-world test cases to validate rule effectiveness.
- Adjust alert severity and prioritization to optimize operational response.

---

This tuning plan aims to balance detection efficacy with minimizing false positives for better security operations.