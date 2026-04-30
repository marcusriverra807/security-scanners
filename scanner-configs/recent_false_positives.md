# Recent Detected False Positives

This document captures recent false positive instances detected by the security scanners following the structured format from the false_positive_data_template.md.

## Instance 1

### 1. Scanner Information
- Scanner Name: 
- Scanner Version: 
- Date and Time of Scan: 

### 2. False Positive Instance Details
- Rule ID Triggered: XSS-001
- Rule Description: Cross-Site Scripting (XSS) Detection Rule
- Severity Level: 

### 3. False Positive Description
- Description of the false positive: False positive on XSS detection in user input field 'comments'
- Reason why this is a false positive: The data contained an encoded script tag but was actually safe.

### 4. Affected Code or Data
- Snippet or sample of the code/data flagged: 
- File or resource path: 
- Line number(s) (if applicable): 

### 5. Context Information
- Environment or system where the false positive occurred: 
- Additional contextual information: Detected in commit abc123

### 6. Suggested Rule Adjustment
- Proposed changes to the detection rule to avoid this false positive: 
- Rationale for the suggested adjustment: 

### 7. Reviewer Information
- Name of the person reporting: 
- Date of report: 
- Additional comments: 

---

## Instance 2

### 1. Scanner Information
- Scanner Name: 
- Scanner Version: 
- Date and Time of Scan: 

### 2. False Positive Instance Details
- Rule ID Triggered: SQL-002
- Rule Description: SQL Injection Detection Rule
- Severity Level: 

### 3. False Positive Description
- Description of the false positive: False positive on SQL injection in API endpoint 'getUser'
- Reason why this is a false positive: The input query looked suspicious but was properly sanitized by the application.

### 4. Affected Code or Data
- Snippet or sample of the code/data flagged: 
- File or resource path: 
- Line number(s) (if applicable): 

### 5. Context Information
- Environment or system where the false positive occurred: 
- Additional contextual information: Detected in commit def456

### 6. Suggested Rule Adjustment
- Proposed changes to the detection rule to avoid this false positive: 
- Rationale for the suggested adjustment: 

### 7. Reviewer Information
- Name of the person reporting: 
- Date of report: 
- Additional comments: 

---

(Repeat the above template for each false positive instance)