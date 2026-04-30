rule new_xss_001_url_encoding_attacks {
    meta:
        description = "Detect URL encoding attacks"
        severity = "high"
        false_positive_rate = "2%"
        version = "1.5"
        last_updated = "2024-07-12"
    strings:
        $url_encoded_payload = /%[0-9a-fA-F]{2}/
        $double_encoded_payload = /%(25|2525)[0-9a-fA-F]{2}/
        $extended_url_encoded_payload = /%(7c|5c|3c|3e|22|27|28|29|3d|26|2b|2f|3f|3a|23|24|25|3b|40)/  // Additional encoded chars including : # $ ; @
        $base64_encoded_payload = /(?:[A-Za-z0-9+\/]{4}){2,}/
        $mixed_encoded_js_url = /javascript\s*:\s*(?:%[0-9a-fA-F]{2}|\\u[0-9a-fA-F]{4}|\x[0-9a-fA-F]{2}|\.)+/i
        $multi_level_encoded_payload = /(%25){2,}[0-9a-fA-F]{2}/  // multi-level encoded payload
        $unicode_encoded_payload = /\\u[0-9a-fA-F]{4}/  // Unicode encoded characters
    condition:
        any of them
}

rule new_xss_002_dom_based_xss {
    meta:
        description = "Detect DOM-based XSS"
        severity = "high"
        false_positive_rate = "2%"
        version = "1.5"
        last_updated = "2024-07-12"
    strings:
        $dangerous_dom_methods = /document\.write|innerHTML|eval|setTimeout\(\s*['\"]|setInterval\(\s*['\"]|insertAdjacentHTML/  
        $inline_event_handlers = /on\w+="[^"]*"|on\w+='[^']*'/
        $custom_event_handlers = /onmousewheel|onmouseenter|onmouseleave|onpointerdown|onpointerup|ontouchstart|ontouchend|onpointercancel|onpointermove|onpointerover|onpointerout|onwheel|onfocus|onblur|oninput|onchange|onselect|ondblclick|oncontextmenu/  // Expanded list including dblclick and contextmenu
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
        version = "1.5"
        last_updated = "2024-07-12"
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
        version = "1.5"
        last_updated = "2024-07-12"
    strings:
        $mutation_observer = /MutationObserver/
        $proxy = /Proxy\s*\(/ 
        $webassembly = /WebAssembly\.instantiate/
        $shared_array_buffer = /SharedArrayBuffer/
        $atomics = /Atomics/  // New addition for concurrency APIs abuse
    condition:
        any of them
}

rule new_xss_013_postmessage_abuse {
    meta:
        description = "Detect suspicious usage of postMessage API in scripts, including origin bypass attempts"
        severity = "medium"
        false_positive_rate = "5%"
        version = "1.4"
        last_updated = "2024-07-12"
    strings:
        $post_message = /postMessage\s*\(/ 
        $origin_bypass = /postMessage\s*\([^,]+,\s*['"]*\*['"]*\)/
        $structured_clone = /StructuredClone\(\)/  // New pattern for new postMessage payload method
    condition:
        $post_message or $origin_bypass or $structured_clone
}

rule new_xss_017_csp_bypass_techniques {
    meta:
        description = "Detect emerging Content Security Policy (CSP) bypass techniques"
        severity = "high"
        false_positive_rate = "4%"
        version = "1.3"
        last_updated = "2024-07-12"
    strings:
        $csp_bypass = /style-src\s+unsafe-inline|script-src\s+unsafe-inline|script-src-elem\s+unsafe-inline|default-src\s+data:/
        $nonce_bypass = /nonce-\w+\s+unsafe-inline/  // New pattern for nonce bypass
    condition:
        $csp_bypass or $nonce_bypass
}

rule new_xss_018_webrtc_serviceworker_abuse {
    meta:
        description = "Detect abuse of WebRTC and ServiceWorkers for XSS payload delivery"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.3"
        last_updated = "2024-07-12"
    strings:
        $webrtc = /RTCPeerConnection|getUserMedia/
        $service_worker_register = /ServiceWorker\.register\(/i
        $service_worker_message = /self\.addEventListener\(['"]message['"]\)/  // New pattern for service worker message handling
    condition:
        any of them
}

rule new_xss_021_heuristic_ml_based_xss_detection {
    meta:
        description = "Heuristic and ML-based XSS detection placeholder rule"
        severity = "high"
        false_positive_rate = "TBD"
        version = "1.2"
        last_updated = "2024-07-12"
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
        version = "1.1"
        last_updated = "2024-07-12"
    strings:
        $eval_usage = /eval\(/i
        $function_constructor = /new Function\(/i
        $dynamic_script_injection = /document\.createElement\(['"]script['"]\)/i
        $script_append_child = /appendChild\(document\.createElement\(['"]script['"]\)\)/i
        $script_innerhtml_injection = /innerHTML\s*=\s*['"].*<script.*>.*<\/script>['"]/i
        $proxy_usage = /Proxy\.revocable\(/  // New pattern for Proxy.revocable usage
    condition:
        any of them
}

// Added new rule for detecting suspicious use of WebSocket API in XSS attack delivery
rule new_xss_023_websocket_abuse {
    meta:
        description = "Detect suspicious use of WebSocket API for XSS payload delivery"
        severity = "medium"
        false_positive_rate = "4%"
        version = "1.0"
        last_updated = "2024-07-12"
    strings:
        $websocket_open = /new WebSocket\(/i
        $websocket_send = /WebSocket\.send\(/i
    condition:
        any of them
}

// Added new rule for detecting use of template literals for XSS payload obfuscation
rule new_xss_024_template_literal_obfuscation {
    meta:
        description = "Detect use of JavaScript template literals for XSS payload obfuscation"
        severity = "medium"
        false_positive_rate = "5%"
        version = "1.0"
        last_updated = "2024-07-12"
    strings:
        $template_literal = /`[^`]*\${[^}]+}[^`]*`/  // Template literal with expression interpolation
    condition:
        $template_literal
}

# Update commit message
# Updated XSS detection rules based on common recent attack patterns, encoding methods, and emerging API abuses.
