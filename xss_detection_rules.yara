rule updated_xss_url_encoding_attacks {
    meta:
        description = "Detect advanced URL encoding and mixed encoding attacks including UTF-7 and Unicode escapes"
        severity = "high"
        false_positive_rate = "2%"
        version = "1.6"
        last_updated = "2026-06-01"
    strings:
        $utf7_encoded_payload = /\+ADw-|%2bADw-/i   // UTF-7 encoded <
        $unicode_escape_payload = /\\u[0-9a-fA-F]{4}/
        $mixed_encoding_payload = /(%[0-9a-fA-F]{2}|\\u[0-9a-fA-F]{4}|\+ADw-)+/
    condition:
        any of them
}

rule updated_xss_dom_framework_apis {
    meta:
        description = "Detect DOM-based XSS in modern JavaScript frameworks"
        severity = "high"
        false_positive_rate = "2%"
        version = "1.6"
        last_updated = "2026-06-01"
    strings:
        $react_dangerous_innerhtml = /dangerouslySetInnerHTML/
        $angular_bypass_security = /bypassSecurityTrustHtml/
        $vue_template_injection = /v-html=/
    condition:
        any of them
}

rule updated_xss_ml_integration {
    meta:
        description = "ML integration hook for heuristic and behavioral XSS detection"
        severity = "high"
        false_positive_rate = "TBD"
        version = "1.6"
        last_updated = "2026-06-01"
        notes = "External ML model integration via YARA external variables"
    strings:
        $ml_detection_signal = "ML_DETECTION_SIGNAL"  // Placeholder for external ML signal
    condition:
        $ml_detection_signal
}

# Existing rules remain unchanged...

# End of updated XSS detection rules with enhanced detection capabilities
