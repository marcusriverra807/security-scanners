# Tuning Recommendations for XSS and SQL Injection Detection Rules

This document provides tuning recommendations based on recent synthetic test cases added to enhance detection of XSS and SQL injection attack vectors.

## Observations and Recommendations

1. **Obfuscated Payloads**
   - Rules detecting obfuscated payloads (e.g., encoded JavaScript, hexadecimal escapes) should be tuned to reliably decode and inspect these patterns.
   - Consider implementing normalization steps before rule evaluation to reduce false negatives.

2. **Less Common Event Handlers and New HTML5 Elements**
   - Include detailed documentation on detection logic for less common event handlers (e.g., `onblur`, `onfocus`, `onsubmit`) and new HTML5 elements/attributes.
   - Provide examples of attack payloads and expected alerts.

3. **Time-Based SQL Injection and Hardcoded Secrets**
   - Tune SQL injection detection rules to balance between catching time-based delays and avoiding false positives from legitimate queries.
   - Document scope and limitations of detecting hardcoded API keys and secrets to manage expectations.

4. **Content Security Policy Violations and Reflected XSS**
   - Add context on challenges detecting CSP violations and reflected XSS patterns.
   - Recommend response actions such as alert validation and rule adjustments.

5. **Mutation-Based DOM XSS and Dynamic Script Execution**
   - Evaluate performance impact of rules detecting dynamic script execution and DOM mutations.
   - Tune rules to minimize false positives, especially in complex web applications.

## Next Steps

- Integrate these tuning recommendations into the rule development lifecycle.
- Update user-facing documentation with examples and tuning guidance.
- Monitor alert trends post-tuning to validate effectiveness.

---

This proposal is based on recent synthetic test cases added in commit ddb2c5e1ba2075ee825f183db93c8d4256cd82d3.
