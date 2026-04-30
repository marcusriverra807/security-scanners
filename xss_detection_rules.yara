rule new_xss_001_url_encoding_attacks {
    meta:
        description = "Detect URL encoding attacks"
        severity = "high"
        false_positive_rate = "2%"
    strings:
        $url_encoded_payload = /%[0-9a-fA-F]{2}/
        $double_encoded_payload = /%25[0-9a-fA-F]{2}/
        $base64_encoded_payload = /(?:[A-Za-z0-9+\/]{4}){2,}/
    condition:
        any of them
}

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

rule new_xss_003_obfuscated_script_tags {
    meta:
        description = "Detect obfuscated script tags with base64 or hex encoding"
        severity = "high"
        false_positive_rate = "3%"
    strings:
        $base64_script = /<script\s+type=\"text\/base64\">[A-Za-z0-9+\/]+=*<\/script>/
        $hex_encoded_script = /<script\s+type=\"text\/hex\">[0-9A-Fa-f]+<\/script>/
        // Placeholder for safe patterns - example: base64 of harmless strings
        $safe_pattern = /<script\s+type=\"text\/base64\">aGFybWxlc3M=<\/script>/  // base64 for 'harmless'
    condition:
        any of ($base64_script, $hex_encoded_script) and not $safe_pattern
}

rule new_xss_004_script_tag_malicious_attributes {
    meta:
        description = "Detect script tag with malicious attributes"
        severity = "high"
        false_positive_rate = "2%"
    strings:
        $script_tag = /<script[^>]*>/
        $malicious_attribute = /src\s*=\s*['"]?javascript:/
    condition:
        $script_tag and $malicious_attribute
}

rule new_xss_005_dynamic_script_execution {
    meta:
        description = "Detect dynamic script execution"
        severity = "high"
        false_positive_rate = "1%"
    strings:
        $dynamic_execution = /eval\(|Function\(/
    condition:
        $dynamic_execution
}

rule new_xss_006_inline_event_handlers {
    meta:
        description = "Detect inline event handlers"
        severity = "high"
        false_positive_rate = "3%"
    strings:
        $inline_event = /on\w+=\"[^\"]*\"|on\w+='[^']*'/
    condition:
        $inline_event
}

rule new_xss_007_svg_element_attribute_injection {
    meta:
        description = "Detect SVG element attribute injection"
        severity = "high"
        false_positive_rate = "3%"
    strings:
        $svg_injection = /<svg[^>]*on\w+=\"[^\"]*\"/i
    condition:
        $svg_injection
}

rule new_xss_008_html_entity_encoded_script_injection {
    meta:
        description = "Detect HTML entity encoded script injection"
        severity = "high"
        false_positive_rate = "3%"
    strings:
        $html_entity_script = /&lt;script&gt;|&amp;#x3c;script&amp;#x3e;/i
    condition:
        $html_entity_script
}

rule new_xss_009_iframe_injection_attempts {
    meta:
        description = "Detect iframe injection attempts"
        severity = "high"
        false_positive_rate = "2%"
    strings:
        $iframe_tag = /<iframe[^>]*>/
        $suspicious_src = /src\s*=\s*['"]?(javascript:|data:text\/html)/
    condition:
        $iframe_tag and $suspicious_src
}

rule new_xss_010_dangerous_dom_methods {
    meta:
        description = "Detect dangerous DOM methods like innerHTML"
        severity = "high"
        false_positive_rate = "5%"
    strings:
        $dangerous_dom = /innerHTML|document\.write|eval|setTimeout|setInterval/
    condition:
        $dangerous_dom
}

# XSS Detection Rules Review and Update Plan
# This plan should be revisited and updated quarterly to ensure ongoing effectiveness

# 1. Quarterly Review
# - Conduct comprehensive reviews of detection rule performance using detection logs and incident reports.
# - Evaluate false positive and false negative rates.

# 2. Threat Intelligence Integration
# - Incorporate latest threat intelligence on emerging XSS obfuscation and attack techniques.

# 3. Rule Update and Tuning
# - Update regex patterns and detection heuristics accordingly.
# - Tune severity and false positive rate metadata.

# 4. Testing and Validation
# - Use synthetic and real-world test cases to validate rule effectiveness after updates.

# 5. Documentation and Training
# - Update documentation to reflect rule changes.
# - Provide training to detection engineers on new rule features and tuning.

# 6. Feedback Mechanism
# - Establish channels for feedback from incident responders and users to refine rules.

# 7. Automation
# - Automate data collection and initial analysis to support rule review process.

# 8. Reporting
# - Generate quarterly reports on rule performance and planned updates.

# End of review and update plan