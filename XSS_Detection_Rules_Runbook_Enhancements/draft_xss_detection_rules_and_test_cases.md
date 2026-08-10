# Draft Detection Rules and Test Cases for Recent XSS Threats Enhancements

## 1. Enhanced Decoding and Normalization for URL Encoding Attacks
- Decode and normalize URL-encoded payloads before matching.
- Differentiate encoded attacks from benign URLs by checking decoded patterns.
- Whitelist known safe URL patterns to reduce false positives.

## 2. Refined Rules for DOM-Based XSS Detection
- Detect malicious payloads within `document.write` and `innerHTML`.
- Use context-aware pattern matching to reduce false positives.
- Example pattern: Suspicious JavaScript functions or event handlers inside these DOM methods.

## 3. Context-Aware Pattern Matching for Script Tag Attributes and Dynamic Script Execution
- Allowlist trusted domains in script `src` attributes.
- Detect suspicious use of `eval()`, `Function()`, and similar dynamic execution calls.
- Exclude benign function calls from detection through contextual analysis.

## 4. Context Checks for Inline Event Handlers and SVG Attribute Injection
- Differentiate safe vs unsafe inline event handlers using context checks.
- Target SVG elements only if they contain event handler attributes.

## 5. Allowlist for Trusted Domains and Iframe Sources
- Maintain and reference allowlists for trusted domains in script and iframe sources.

## 6. Expanded Detection for Obfuscated Script Tags (base64/hex encoding)
- Detect script tags with mixed encoding: base64 or hex combined with URL encoding.
- Support nested or multiple obfuscated script tags.
- Handle evasion techniques like whitespace, line breaks, case variations, and inserted comments.
- Whitelist legitimate uses of base64/hex encoding in scripts to reduce false positives.

## 7. Rule Logic Adjustments
- Contextual execution check: Decoded content should contain executable script elements or suspicious functions like `alert`, `eval`, `Function`.
- Thresholding: Minimum encoding length or complexity before triggering detection.
- Case insensitivity and normalization for tag and attribute matching.
- Tolerance for whitespace, line breaks, and comments inside encoded strings.
- Configurable whitelist for known safe base64/hex patterns.

## 8. Test Cases

### 8.1 URL Encoding Attacks
- Encoded payloads with common XSS patterns.
- Whitelisted safe URLs.

### 8.2 DOM-Based XSS Payloads
- `document.write` with suspicious JavaScript.
- `innerHTML` assignment of malicious code.

### 8.3 Script Tag with Malicious Attributes
- Script tags with `src` from untrusted domains.
- Legitimate `src` from allowlisted domains.

### 8.4 Dynamic Script Execution
- `eval()` and `Function()` calls with XSS payloads.
- Benign function calls excluded.

### 8.5 Inline Event Handlers and SVG
- Unsafe inline event handlers triggering detection.
- Safe inline event handlers excluded.
- SVG elements with event handlers.

### 8.6 Iframe Injection Attempts
- Iframe tags with untrusted sources.
- Allowlisted iframe sources excluded.

### 8.7 Obfuscated Script Tags
- Base64-encoded script tags with malicious payloads.
- Hex-encoded script tags.
- Mixed encoding (base64 + URL encoding).
- Nested encoded script tags.
- Encoded strings with whitespace, line breaks, comments.
- Legitimate base64/hex encoded script tags whitelisted.

---

This draft provides a comprehensive enhancement to detection rules and test cases based on the provided recommendations. Implementing these will improve detection accuracy and reduce false positives for recent XSS threats.