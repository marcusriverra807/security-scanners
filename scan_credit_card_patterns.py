import os
import re

# Credit card regex patterns
patterns = {
    "Visa": r"4[0-9]{12}(?:[0-9]{3})?",
    "MasterCard": r"5[1-5][0-9]{14}",
    "American Express": r"3[47][0-9]{13}",
    "Discover": r"6(?:011|5[0-9]{2})[0-9]{12}",
    "Diners Club": r"3(?:0[0-5]|[68][0-9])[0-9]{11}",
    "JCB": r"(?:2131|1800|35\d{3})\d{11}",
    "General": r"(?:\d{4}[ -]?){3}\d{4}"
}

# Compile regex patterns
compiled_patterns = {name: re.compile(pattern) for name, pattern in patterns.items()}

# Scan directory recursively for files

def scan_file_for_patterns(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
    except Exception as e:
        print(f"Could not read file {file_path}: {e}")
        return []

    findings = []
    for i, line in enumerate(lines, start=1):
        for name, pattern in compiled_patterns.items():
            if pattern.search(line):
                findings.append((i, name, line.strip()))
    return findings


def scan_directory(directory):
    results = {}
    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            findings = scan_file_for_patterns(file_path)
            if findings:
                results[file_path] = findings
    return results


def main():
    root_dir = '.'  # Current directory
    results = scan_directory(root_dir)
    if results:
        print("Potential credit card information found in files:")
        for file_path, findings in results.items():
            print(f"\nFile: {file_path}")
            for line_num, card_type, content in findings:
                print(f"  Line {line_num} [{card_type}]: {content}")
    else:
        print("No potential credit card information found.")


if __name__ == '__main__':
    main()
