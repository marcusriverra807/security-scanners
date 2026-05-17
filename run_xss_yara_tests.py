import yara

# Load the YARA rules
rules = yara.compile(filepath='xss_detection_rules.yara')

# Define test cases from the test cases file
# Positive test cases (should match)
positive_tests = {
    'new_xss_001_url_encoding_attacks': [
        '%3Cscript%3Ealert(1)%3C/script%3E',
    ],
    'new_xss_002_dom_based_xss': [
        'document.write("test")',
        '<div onclick=\"alert(1)\">',
    ],
    'new_xss_003_obfuscated_script_tags': [
        '<script type="text/base64">PHNjcmlwdD5hbGVydCgxKTwvc2NyaXB0Pg==</script>',  # base64 encoded script
        '<script type="text/hex">3c7363726970743e616c6572742831293c2f7363726970743e</script>',  # hex encoded script
    ],
    'new_xss_004_script_tag_malicious_attributes': [
        '<script src="javascript:alert(1)"></script>',
    ],
    'new_xss_005_dynamic_script_execution': [
        'eval("alert(\'XSS\')")',
        'Function("alert(\'XSS\')")',
    ],
    'new_xss_006_inline_event_handlers': [
        'onmouseover="alert(\'XSS\')"',
    ],
    'new_xss_007_svg_element_attribute_injection': [
        '<svg onload="alert(\'XSS\')"></svg>',
    ],
    'new_xss_008_html_entity_encoded_script_injection': [
        '&lt;script&gt;alert(1)&lt;/script&gt;',
    ],
    'new_xss_009_iframe_injection_attempts': [
        '<iframe src="javascript:alert(1)"></iframe>',
    ],
    'new_xss_010_dangerous_dom_methods': [
        'innerHTML = "test"',
    ],
}

# Negative test cases (should NOT match)
negative_tests = {
    'new_xss_001_url_encoding_attacks': [
        'https://example.com/page?param=value',
    ],
    'new_xss_002_dom_based_xss': [
        'safe DOM methods without malicious payload',
    ],
    'new_xss_003_obfuscated_script_tags': [
        '<script type="text/base64">aGFybWxlc3M=</script>',  # base64 for 'harmless'
        '<script type="text/hex">4861726d6c657373</script>',  # hex for 'harmless'
    ],
    'new_xss_004_script_tag_malicious_attributes': [
        '<script src="https://trusted.com/script.js"></script>',
    ],
    'new_xss_005_dynamic_script_execution': [
        'someFunctionCall()',
    ],
    'new_xss_006_inline_event_handlers': [
        'onmouseover="safeFunction()"',
    ],
    'new_xss_007_svg_element_attribute_injection': [
        '<svg></svg>',
    ],
    'new_xss_008_html_entity_encoded_script_injection': [
        '&lt;div&gt;content&lt;/div&gt;',
    ],
    'new_xss_009_iframe_injection_attempts': [
        '<iframe src="https://trusted.com"></iframe>',
    ],
    'new_xss_010_dangerous_dom_methods': [
        'safe DOM usage',
    ],
}


def run_tests():
    print("Starting YARA XSS detection rules tests...")
    passed = 0
    failed = 0

    # Test positive cases
    for rule, tests in positive_tests.items():
        for test_str in tests:
            matches = rules.match(data=test_str)
            if any(m.rule == rule for m in matches):
                print(f"PASS (Expected): {rule} detected in payload: {test_str}")
                passed += 1
            else:
                print(f"FAIL (Expected): {rule} NOT detected in payload: {test_str}")
                failed += 1

    # Test negative cases
    for rule, tests in negative_tests.items():
        for test_str in tests:
            matches = rules.match(data=test_str)
            if any(m.rule == rule for m in matches):
                print(f"FAIL (Unexpected): {rule} detected in benign payload: {test_str}")
                failed += 1
            else:
                print(f"PASS (Expected): {rule} NOT detected in benign payload: {test_str}")
                passed += 1

    print(f"\nTesting completed. Passed: {passed}, Failed: {failed}")


if __name__ == '__main__':
    run_tests()
