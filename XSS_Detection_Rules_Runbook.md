# XSS Detection Rules Runbook

This runbook documents the new YARA-style XSS detection rules, their descriptions, associated test cases, and estimated false positive rates. It serves as a reference for detection engineers to understand, validate, and maintain these rules.

---

## Rule: new_xss_001_url_encoding_attacks
- **Description:** Detect URL encoding attacks
- **Estimated False Positive Rate:** 2%

### Test Cases
- Test URL encoded payloads like %3Cscript%3Ealert(1)%3C/script%3E
- Test non-encoded benign URLs to check false positives

---

## Rule: new_xss_002_dom_based_xss
- **Description:** Detect DOM-based XSS
- **Estimated False Positive Rate:** 3%

### Test Cases
- Test injection of document.write and innerHTML in input
- Test benign usage of DOM methods without malicious payload

---

## Rule: new_xss_003_obfuscated_script_tags
- **Description:** Detect obfuscated script tags with base64 or hex encoding
- **Estimated False Positive Rate:** 3%

### Test Cases
- (Add relevant test cases as needed)

---

## Rule: new_xss_004_script_tag_malicious_attributes
- **Description:** Detect script tag with malicious attributes
- **Estimated False Positive Rate:** 2%

### Test Cases
- Test <script src="javascript:alert(1)"></script>
- Test <script src="https://trusted.com/script.js"></script>

---

## Rule: new_xss_005_dynamic_script_execution
- **Description:** Detect dynamic script execution
- **Estimated False Positive Rate:** 1%

### Test Cases
- Test eval("alert('XSS')") and Function("alert('XSS')")
- Test other function calls without eval or Function

---

## Rule: new_xss_006_inline_event_handlers
- **Description:** Detect inline event handlers
- **Estimated False Positive Rate:** 3%

### Test Cases
- Test inline event handlers like onmouseover="alert('XSS')"
- Test benign inline event handlers in safe contexts

---

## Rule: new_xss_007_svg_element_attribute_injection
- **Description:** Detect SVG element attribute injection
- **Estimated False Positive Rate:** 3%

### Test Cases
- Test <svg onload="alert('XSS')"></svg> injection
- Test SVG without event handlers

---

## Rule: new_xss_008_html_entity_encoded_script_injection
- **Description:** Detect HTML entity encoded script injection
- **Estimated False Positive Rate:** 3%

### Test Cases
- Test HTML entity encoded script tags like &lt;script&gt;alert(1)&lt;/script&gt;
- Test encoded benign HTML entities

---

## Rule: new_xss_009_iframe_injection_attempts
- **Description:** Detect iframe injection attempts
- **Estimated False Positive Rate:** 2%

### Test Cases
- Test <iframe src="javascript:alert(1)"></iframe>
- Test <iframe src="https://trusted.com"></iframe>

---

## Rule: new_xss_010_dangerous_dom_methods
- **Description:** Detect dangerous DOM methods like innerHTML
- **Estimated False Positive Rate:** 5%

### Test Cases
- Test dangerous DOM methods like innerHTML, document.write in input
- Test benign DOM method usage

---

# Runbook Maintenance

- Review and update this document quarterly along with the detection rules.
- Incorporate feedback from detection engineers and incident responders.
- Keep test cases updated to reflect rule changes and new threat intelligence.

---

This runbook is intended to support consistent and effective use of the XSS detection rules in security monitoring and incident response.
