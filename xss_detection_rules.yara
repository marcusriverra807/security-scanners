rule new_xss_001_url_encoding_attacks {
    meta:
        description = "Detect URL encoding attacks"
        severity = "high"
        false_positive_rate = "2%"
    strings:
        $url_encoded_payload = /%[0-9a-fA-F]{2}/
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
        $inline_event_handlers = /on\w+=\"[^"]*\"|on\w+='[^']*'/
    condition:
        any of them
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
        $inline_event = /on\w+=\"[^"]*\"|on\w+='[^']*'/
    condition:
        $inline_event
}

rule new_xss_007_svg_element_attribute_injection {
    meta:
        description = "Detect SVG element attribute injection"
        severity = "high"
        false_positive_rate = "3%"
    strings:
        $svg_injection = /<svg[^>]*on\w+=\"[^"]*\"/i
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
