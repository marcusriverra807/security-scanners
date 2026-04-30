# XSS New Scanner Findings Triage

This document captures the triage of new scanner findings from the latest synthetic test cases for XSS detection rules.

## Summary of New Findings

These new scanner findings come from synthetic test cases defined in the files:
- tests/xss_additional_synthetic_tests.yaml
- tests/xss_synthetic_tests.yaml

The findings cover various new XSS attack vectors including:

1. Additional DOM-based XSS vectors such as innerHTML assignments, window.location.href injections, and dynamic script insertions.
2. Inline event handler injections in HTML elements (e.g., onerror, onclick, onmouseover).
3. SVG element attribute injections with event handlers.
4. HTML entity encoded script injections with nested or encoded payloads.
5. Dangerous DOM methods usage like document.write, eval, setTimeout, setInterval, and new Function calls.

## Detailed Triage

### 1. DOM-based XSS Vectors
- Examples: `element.innerHTML = "<img src=x onerror=alert(1) />";`, `window.location.href = "javascript:alert(1)";`
- Expected detection: True
- Risk: High, as these vectors allow script execution via DOM manipulation.
- Action: Ensure detection rules cover these vectors and false positives are minimized.

### 2. Inline Event Handlers
- Examples: `<img onerror="alert(1)" />`, `<div onmouseover="alert(1)">Hover me</div>`
- Expected detection: True
- Risk: Medium to High, inline event handlers are common XSS injection points.
- Action: Tune detection rules to catch these handlers and test against benign cases.

### 3. SVG Element Attribute Injections
- Examples: `<animate onbegin="alert(1)" />`, `<svg><rect onload="alert(1)" /></svg>`
- Expected detection: True
- Risk: Medium, SVG can be used to bypass typical HTML filters.
- Action: Add specific detection for SVG event handlers and attributes.

### 4. HTML Entity Encoded Script Injections
- Examples: Encoded script tags and payloads such as `&lt;img src=x onerror=alert(1)&gt;`
- Expected detection: True
- Risk: Medium, encoded payloads try to evade naive filters.
- Action: Enhance decoding and detection capabilities in scanner.

### 5. Dangerous DOM Methods
- Examples: `document.write("<img src=x onerror=alert(1)>")`, `eval("alert(1)")`
- Expected detection: True
- Risk: High, these methods execute arbitrary code.
- Action: Strictly monitor and alert on usage of these methods.

## Next Steps

- Validate detection rules against these synthetic test cases.
- Adjust tuning to reduce false positives while maintaining coverage.
- Integrate findings into automated triage playbooks.
- Schedule periodic review and update of test cases and rules.

---

Document prepared by Bashir Khan, vuln_triage_engineer.
