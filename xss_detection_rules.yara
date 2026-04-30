rule new_xss_001_url_encoding_attacks {
    meta:
        description = "Detect URL encoding attacks"
        severity = "high"
        false_positive_rate = "2%"
        version = "1.4"
        last_updated = "2024-06-30"
    strings:
        $url_encoded_payload = /%[0-9a-fA-F]{2}/
        $double_encoded_payload = /%(25|2525)[0-9a-fA-F]{2}/
        $extended_url_encoded_payload = /%(7c|5c|3c|3e|22|27|28|29|3d|26|2b|2f|3f|3a|23|24|25|3b|40)/  // Additional encoded chars including : # $ ; @
        $base64_encoded_payload = /(?:[A-Za-z0-9+\/]{4}){2,}/
        $mixed_encoded_js_url = /javascript\s*:\s*(?:%[0-9a-fA-F]{2}|\\u[0-9a-fA-F]{4}|\x[0-9a-fA-F]{2}|\.)+/i
        $multi_level_encoded_payload = /(%25){2,}[0-9a-fA-F]{2}/  // multi-level encoded payload
    condition:
        any of them
}

rule new_xss_002_dom_based_xss {
    meta:
        description = "Detect DOM-based XSS"
        severity = "high"
        false_positive_rate = "2%"
        version = "1.4"
        last_updated = "2024-06-30"
    strings:
        $dangerous_dom_methods = /document\.write|innerHTML|eval|setTimeout\(\s*['\"]|setInterval\(\s*['\"]|insertAdjacentHTML/  
        $inline_event_handlers = /on\w+=\"[^\"]*\"|on\w+='[^']*'/
        $custom_event_handlers = /onmousewheel|onmouseenter|onmouseleave|onpointerdown|onpointerup|ontouchstart|ontouchend|onpointercancel|onpointermove|onpointerover|onpointerout|onwheel|onfocus|onblur|oninput|onchange|onselect/  // Expanded list
        $shadow_dom_manipulation = /attachShadow\(|shadowRoot\./
        $custom_elements = /customElements\.define\(/ 
    condition:
        any of them
}

rule new_xss_003_obfuscated_script_tags {
    meta:
        description = "Detect obfuscated script tags with base64 or hex encoding"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.4"
        last_updated = "2024-06-30"
    strings:
        $base64_script = /<script\s+type=\"text\/base64\">[A-Za-z0-9+\/]+=*<\/script>/
        $hex_encoded_script = /<script\s+type=\"text\/hex\">[0-9A-Fa-f]+<\/script>/
        $base85_encoded_script = /<script\s+type=\"text\/base85\">[A-Za-z0-9!"\#\$%\&'\(\)*\+,\-\./:;<=>\?@\[\\\]\^_`\{|\}~]+<\/script>/
        $safe_pattern = /<script\s+type=\"text\/base64\">aGFybWxlc3M=<\/script>/  // base64 for 'harmless'
    condition:
        any of ($base64_script, $hex_encoded_script, $base85_encoded_script) and not $safe_pattern
}

rule new_xss_011_js_api_abuse {
    meta:
        description = "Detect abuse of modern JavaScript APIs like MutationObserver, Proxy, WebAssembly, and SharedArrayBuffer"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.4"
        last_updated = "2024-06-30"
    strings:
        $mutation_observer = /MutationObserver/
        $proxy = /Proxy\s*\(/ 
        $webassembly = /WebAssembly\.instantiate/
        $shared_array_buffer = /SharedArrayBuffer/
    condition:
        any of them
}

rule new_xss_013_postmessage_abuse {
    meta:
        description = "Detect suspicious usage of postMessage API in scripts, including origin bypass attempts"
        severity = "medium"
        false_positive_rate = "5%"
        version = "1.3"
        last_updated = "2024-06-30"
    strings:
        $post_message = /postMessage\s*\(/ 
        $origin_bypass = /postMessage\s*\([^,]+,\s*['"]*\*['"]*\)/
    condition:
        $post_message or $origin_bypass
}

rule new_xss_017_csp_bypass_techniques {
    meta:
        description = "Detect emerging Content Security Policy (CSP) bypass techniques"
        severity = "high"
        false_positive_rate = "4%"
        version = "1.2"
        last_updated = "2024-06-30"
    strings:
        $csp_bypass = /style-src\s+unsafe-inline|script-src\s+unsafe-inline|script-src-elem\s+unsafe-inline|default-src\s+data:/
    condition:
        $csp_bypass
}

rule new_xss_018_webrtc_serviceworker_abuse {
    meta:
        description = "Detect abuse of WebRTC and ServiceWorkers for XSS payload delivery"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.2"
        last_updated = "2024-06-30"
    strings:
        $webrtc = /RTCPeerConnection|getUserMedia/
        $service_worker_register = /ServiceWorker\.register\(/i
    condition:
        any of them
}

rule new_xss_021_heuristic_ml_based_xss_detection {
    meta:
        description = "Heuristic and ML-based XSS detection placeholder rule"
        severity = "high"
        false_positive_rate = "TBD"
        version = "1.1"
        last_updated = "2024-06-30"
        notes = "This rule is a placeholder and requires integration with an external ML detection engine via YARA external variables or hooks."
    strings:
        $heuristic_pattern = /<script.*?>.*?eval|Function\(|setTimeout|setInterval|document\.cookie|window\.location/si
    condition:
        $heuristic_pattern
}

rule new_xss_022_dynamic_behavioral_monitoring {
    meta:
        description = "Detect dynamic and behavioral indicators of XSS payload execution"
        severity = "high"
        false_positive_rate = "2%"
        version = "1.0"
        last_updated = "2024-06-30"
    strings:
        $eval_usage = /eval\(/i
        $function_constructor = /new Function\(/i
        $dynamic_script_injection = /document\.createElement\(['"]script['"]\)/i
        $script_append_child = /appendChild\(document\.createElement\(['"]script['"]\)\)/i
        $script_innerhtml_injection = /innerHTML\s*=\s*['"].*<script.*>.*<\/script>['"]/i
    condition:
        any of them
}

# Updated XSS Detection Rules Review and Update Plan
# This plan should be revisited and updated quarterly to ensure ongoing effectiveness

# 1. Quarterly Review
# - Conduct comprehensive reviews of detection rule performance using detection logs and incident reports.
# - Evaluate false positive and false negative rates.

# 2. Threat Intelligence Integration
# - Incorporate latest threat intelligence on emerging XSS obfuscation and attack techniques.

# 3. Rule Update and Tuning
# - Update regex patterns and detection heuristics accordingly.
# - Tune severity and false positive rate metadata.
# - Integrate heuristic and machine learning based detection methods where feasible.

# 4. Testing and Validation
# - Use synthetic and real-world test cases to validate rule effectiveness after updates.
# - Include ML model validation metrics and feedback.

# 5. Documentation and Training
# - Update documentation to reflect rule changes and new detection approaches.
# - Provide training to detection engineers on new rule features, heuristics, and ML integration.

# 6. Feedback Mechanism
# - Establish channels for feedback from incident responders and users to refine rules.

# 7. Automation Enhancements
# - Automate continuous feedback collection and analysis pipelines.
# - Integrate dynamic threat intelligence feeds via YARA external variables.
# - Implement automated false positive and false negative reporting.
# - Develop automated rule tuning and deployment pipelines.
# - Explore automated ML model retraining and deployment.

# 8. Reporting
# - Generate quarterly reports on rule performance and planned updates.

# End of updated review and update plan
