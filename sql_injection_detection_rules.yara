rule sql_001_time_based_blind_injection {
    meta:
        description = "Detect time-based blind SQL injection patterns"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.0"
        last_updated = "2026-04-30"
    strings:
        $time_delay = /WAITFOR\s+DELAY\s+'\d{2}:\d{2}:\d{2}'/i
    condition:
        $time_delay
}

rule sql_002_union_based_injection {
    meta:
        description = "Detect union-based SQL injection patterns"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.0"
        last_updated = "2026-04-30"
    strings:
        $union_select = /UNION\s+SELECT\s+[\w\*,\s]+FROM\s+\w+/i
    condition:
        $union_select
}

rule sql_003_stacked_queries {
    meta:
        description = "Detect stacked query SQL injection attempts"
        severity = "high"
        false_positive_rate = "4%"
        version = "1.0"
        last_updated = "2026-04-30"
    strings:
        $stacked_query = /;\s*\w+\s+\w+/i
    condition:
        $stacked_query
}

rule sql_004_encoded_sql_injection {
    meta:
        description = "Detect URL encoded SQL injection patterns"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.0"
        last_updated = "2026-04-30"
    strings:
        $encoded_pattern = /%27\s*OR\s*1=1\s*--/i
    condition:
        $encoded_pattern
}

rule sql_005_comment_based_obfuscation {
    meta:
        description = "Detect comment-based SQL injection obfuscation"
        severity = "high"
        false_positive_rate = "3%"
        version = "1.0"
        last_updated = "2026-04-30"
    strings:
        $comment_obfuscation = /1=1\s*/\*.*?\*/
    condition:
        $comment_obfuscation
}

# SQL Injection Detection Rules Update Plan
# This plan should be reviewed quarterly and updated based on emerging attack techniques and detection performance.

# 1. Quarterly Review
# - Analyze detection logs and incident reports for false positives and false negatives.

# 2. Threat Intelligence Integration
# - Incorporate latest SQL injection attack patterns from threat intelligence feeds.

# 3. Rule Refinement
# - Tune regex patterns and detection heuristics.

# 4. Testing and Validation
# - Use synthetic and real-world test cases to validate rule effectiveness.

# 5. Documentation and Training
# - Update documentation and train detection engineers on new rules.

# 6. Feedback and Automation
# - Establish feedback channels and automate rule tuning and deployment.

# 7. Reporting
# - Generate regular reports on rule performance.

# End of SQL Injection Detection Rules Update Plan
