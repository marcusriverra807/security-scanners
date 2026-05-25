import re
import yaml

# Load the sql-xss-configs.yaml content
with open('sql-xss-configs.yaml', 'r') as f:
    config = yaml.safe_load(f)

# Extract XSS detection rules
rules = config.get('rules', [])

# Sample SQL Injection payloads
sql_injection_payloads = [
    "' OR '1'='1'; --",
    "DROP TABLE users; --",
    "SELECT * FROM users WHERE username = 'admin' --",
    "UNION SELECT password FROM admin --",
    "INSERT INTO users (username, password) VALUES ('attacker', 'pass')",
    "admin'--",
    "OR 1=1",
    "'; EXEC xp_cmdshell('dir'); --",
    """ AND EXISTS(SELECT * FROM users WHERE username='admin')"""
]

print("Validating XSS Rules:\n")

# Validate XSS rules against their test cases
for rule in rules:
    pattern = rule.get('pattern')
    description = rule.get('description')
    rule_id = rule.get('id')
    compiled_pattern = re.compile(pattern, re.IGNORECASE | re.DOTALL)

    print(f"Rule {rule_id}: {description}")

    test_cases = rule.get('test_cases', [])
    for case in test_cases:
        input_str = case.get('input')
        expected = case.get('expected').lower() == 'true'
        match = bool(compiled_pattern.search(input_str))
        result = 'PASS' if match == expected else 'FAIL'
        print(f"  Test input: {input_str}\n    Expected: {expected}, Detected: {match} => {result}")

    print()

print("Validating SQL Injection Payloads:\n")

# Simple SQL Injection detection patterns (example, can be expanded)
sql_patterns = [
    r"'\s*or\s*'1'='1'",  # tautology
    r"drop\s+table",          # drop table
    r"union\s+select",        # union select
    r"exec\s+xp_cmdshell",    # exec xp_cmdshell
    r"insert\s+into",         # insert into
    r"select\s+\*",          # select *
]

compiled_sql_patterns = [re.compile(pat, re.IGNORECASE | re.DOTALL) for pat in sql_patterns]

for payload in sql_injection_payloads:
    detected = any(pat.search(payload) for pat in compiled_sql_patterns)
    print(f"Payload: {payload}\n  Detected as SQL Injection: {detected}\n")

print("Validation complete.")
