# Enhancements for new_xss_003_obfuscated_script_tags Rule

This document outlines the proposed test case expansions and rule logic adjustments for the `new_xss_003_obfuscated_script_tags` detection rule to improve detection accuracy, reduce false positives, and support maintainability.

---

## 1. Test Case Expansions

### 1.1 Mixed Encoding Test Cases
- Test script tags where base64 or hex encoding is combined with URL encoding.
  - Example: `%3cscript%3ePHNjcmlwdD5hbGVydCgxKTwvc2NyaXB0Pg==%3c/script%3e`

### 1.2 Nested Obfuscated Script Tags
- Test payloads containing multiple or nested obfuscated script tags encoded in base64 or hex.

### 1.3 Evasion Technique Test Cases
- Test payloads with whitespace or line breaks inserted inside the encoded string.
  - Example: base64 string split across multiple lines.
- Test case variations in tag names and attribute names (case insensitive).
  - Example: `<ScRiPt type="text/base64">...</ScRiPt>`
- Test insertion of comments or benign content inside the encoded payload.

### 1.4 False Positive Scenario Tests
- Test legitimate uses of base64 or hex encoding in script tags common in the environment to ensure they are not flagged.

---

## 2. Proposed Rule Logic Adjustments

### 2.1 Contextual Execution Check
- Verify that the decoded content of the base64 or hex string contains executable script elements or suspicious function calls such as `alert`, `eval`, `Function`.

### 2.2 Thresholding and Pattern Matching
- Add thresholds for minimum encoding length or complexity to avoid triggering on short benign base64/hex strings.

### 2.3 Case Insensitivity and Normalization
- Ensure matching of tag and attribute names is case-insensitive.
- Normalize whitespace between attributes and around encoded strings.

### 2.4 Whitespace and Comment Tolerance
- Modify detection logic to tolerate whitespace, line breaks, and comments inside encoded strings without missing detections.

### 2.5 Whitelist Legitimate Patterns
- Allow configuration of whitelisted base64 or hex patterns known to be safe in the environment.

---

## 3. Implementation Notes
- Update test suite to include the expanded test cases.
- Adjust detection rule YARA or equivalent logic based on the above proposals.
- Monitor rule performance and false positive rates post-deployment and adjust thresholds accordingly.

---

This document aims to facilitate the implementation of robust and accurate detection for obfuscated script tag attacks using base64 or hex encoding.
