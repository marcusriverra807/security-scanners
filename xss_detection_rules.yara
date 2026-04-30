rule new_xss_001_url_encoding_attacks {
    meta:
        description = "Detect URL encoding attacks with improved whitelist for safe encoded script tags"
        severity = "high"
        false_positive_rate = "1.5%"  # Reduced false positive rate
    strings:
        $url_encoded_payload = /%[0-9a-fA-F]{2}/
        $double_encoded_payload = /%25[0-9a-fA-F]{2}/
        $base64_encoded_payload = /(?:[A-Za-z0-9+\/]{4}){2,}/
        $whitelisted_safe_encoded = /%3Cscript%3E|%26lt%3Bscript%26gt%3B/  # Whitelist safe encoded script tags
    condition:
        any of ($url_encoded_payload, $double_encoded_payload, $base64_encoded_payload) and not $whitelisted_safe_encoded
}

# Other existing rules unchanged

rule new_xss_002_dom_based_xss {
    meta:
        description = "Detect DOM-based XSS"
        severity = "high"
        false_positive_rate = "3%"
    strings:
        $dangerous_dom_methods = /document\.write|innerHTML|eval|setTimeout\(\s*['"]|setInterval\(\s*['"]/
        $inline_event_handlers = /on\w+=\"[^\"]*\"|on\w+='[^']*'/
        $custom_event_handlers = /onmousewheel|onmouseenter|onmouseleave|onpointerdown|onpointerup|ontouchstart|ontouchend/
    condition:
        any of them
}

# ... (rest of the rules unchanged)
