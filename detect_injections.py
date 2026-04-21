import os
import re

# Define the high severity patterns for XSS and SQL injection
xss_patterns = [
    {"id": "xss-001", "pattern": r"<script[^>]*?(src=\".*?\"|.*?</script>)", "description": "Detect script tag injection"},
    {"id": "xss-002", "pattern": r"javascript:[^\s]*|data:text/html[^\s]*", "description": "Detect JavaScript URLs"},
    {"id": "xss-004", "pattern": r"<svg[^>]*?(onload=\".*?\"|onerror=\".*?\")", "description": "Detect SVG onload injection"},
    {"id": "xss-005", "pattern": r"<iframe[^>]*?(src=\"javascript:.*?\"|srcdoc=\".*?\")", "description": "Detect iframe with JavaScript injection"}
]

sql_patterns = [
    {"id": "sql-001", "pattern": r"(\bSELECT\b|\bINSERT\b|\bUPDATE\b|\bDELETE\b|\bWHERE\b|\bOR\b|\bAND\b|\bUNION\b).*?('|")?[^;]*?('|")?", "description": "Detect SQL injection patterns"},
    {"id": "sql-002", "pattern": r"(1=1|1=0|0=0)", "description": "Detect tautology-based SQL injection"}
]

# Function to scan for patterns in a file
def scan_file(file_path):
    matches = []
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.readlines()
        for line_number, line in enumerate(content):
            for pattern in xss_patterns + sql_patterns:
                if re.search(pattern['pattern'], line):
                    matches.append((file_path, line_number + 1, pattern['description']))
    return matches

# Function to scan a directory for files
def scan_directory(directory):
    results = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(('.js', '.html', '.php', '.py')):  # Add file extensions as needed
                file_path = os.path.join(root, file)
                matches = scan_file(file_path)
                if matches:
                    results.extend(matches)
    return results

# Main execution
if __name__ == '__main__':
    directory_to_scan = '.'  # Set the directory to scan
    findings = scan_directory(directory_to_scan)
    if findings:
        print("Findings:")
        for finding in findings:
            print(f"File: {finding[0]}, Line: {finding[1]}, Issue: {finding[2]}")
    else:
        print("No high severity vulnerabilities found.")
