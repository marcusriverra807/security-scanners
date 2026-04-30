# Detection Rule Adjustments for XSS Scanner

## 1. URL Encoding Attacks
- Enhance decoding and normalization to differentiate encoded attacks from benign URLs.
- Add whitelist for known safe URL patterns to reduce false positives.

## 2. DOM-Based XSS
- Refine rules to detect malicious payloads within document.write and innerHTML usage.
- Implement context-aware pattern matching.

## 3. Script Tag Malicious Attributes
- Add allowlist for trusted domains in script src attributes to avoid flagging legitimate scripts.

## 4. Dynamic Script Execution
- Narrow detection to suspicious eval and Function calls related to XSS.
- Exclude benign function calls from detection.

## 5. Inline Event Handlers
- Incorporate context checks to differentiate safe vs unsafe inline event handlers.

## 6. SVG Element Attribute Injection
- Target detection only at SVG elements with event handler attributes.

## 7. HTML Entity Encoded Script Injection
- Improve pattern matching to distinguish malicious encoded scripts from benign HTML entities.

## 8. Iframe Injection Attempts
- Maintain allowlist for trusted iframe sources.

## 9. Dangerous DOM Methods
- Use context-aware analysis to detect dangerous usage and exclude benign use cases.

---

These adjustments aim to reduce false positives while maintaining detection accuracy. Regular review and tuning are advised.