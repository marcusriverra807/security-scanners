# XSS Detection Rules Tuning Strategy

## Overview
This document outlines a general plan for tuning XSS detection rules based on analysis of synthetic test cases provided in the test files `tests/xss_additional_synthetic_tests.yaml` and `tests/xss_synthetic_tests.yaml`. The goal is to enhance detection accuracy while minimizing false positives.

## Key Focus Areas

1. **Comprehensive Coverage of XSS Vectors**
   - Ensure detection rules cover a broad range of XSS attack vectors including DOM-based XSS, inline event handlers, SVG attribute injections, HTML entity encoded script injections, and dangerous DOM methods.

2. **Accurate Detection of Dangerous DOM Methods and Inline Event Handlers**
   - Refine rules to accurately detect use of dangerous DOM methods (e.g., `innerHTML`, `document.write`, `eval`, `setTimeout`) and inline event handlers (`onclick`, `onerror`, `onload`, etc.).

3. **Handling Encoded and Nested Encodings**
   - Enhance rules to detect encoded and nested encoded payloads as demonstrated in synthetic test cases.

4. **Negative Control Test Cases**
   - Use safe content test cases (expected `false` detections) as negative controls to identify and reduce false positives.

5. **Granular Rule Definitions**
   - Implement granular detection for inline event handlers and SVG attribute injections to avoid overbroad detections that cause false positives.

6. **Regular Review and Update Cycle**
   - Establish a regular schedule to review detection rules against new synthetic test cases and real scanner run results.
   - Incorporate feedback from false positive investigations to continuously improve rules.

## Action Items

- Review current detection rules against the synthetic test cases and identify any gaps.
- Adjust rule patterns to better handle encoding variations.
- Validate rule precision using negative control test cases.
- Document rule changes and rationale clearly for audit and future tuning.
- Schedule periodic rule review sessions with the security scanning team.

## Conclusion
Following this strategy will help maintain an effective balance between detection sensitivity and specificity, ensuring robust XSS detection with minimized false positives.