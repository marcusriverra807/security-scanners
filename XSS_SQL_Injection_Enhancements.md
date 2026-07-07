# Enhancements for XSS and SQL Injection Detection Rules

## Overview
This document consolidates the proposed enhancements for the XSS and SQL injection detection rules in order to improve detection accuracy and reduce false positives. Each enhancement includes refined test cases and patterns, emphasizing the importance of monitoring false positive rates for continual improvement.

---

## Enhancements for XSS Detection Rules

### 1. **xss-001: Detect Script Tag Injection**
- **Enhancements:**
  - **Add Test Cases:**
    - `<script src='data:text/html,alert(1)'></script>` → **Expected:** true
    - `<script type="text/javascript" src='http://example.com/script.js'></script>` → **Expected:** true
  - **Review Pattern:** Adjust to capture variations in script attributes.

### 2. **xss-002: Detect JavaScript URLs**
- **Enhancements:**
  - **Add Test Cases:**
    - `<a href="data:text/html,<script>alert(1)</script>">Click</a>` → **Expected:** true
    - `<a href="javascript:void(0)">Safe Link</a>` → **Expected:** false
  - **Review Pattern:** Ensure it encompasses all forms of JavaScript execution.

### 3. **xss-003: Detect Onerror Handler Injection**
- **Enhancements:**
  - **Add Test Cases:**
    - `<img src='image.jpg' onerror='alert(1)' onload='console.log(1)'>` → **Expected:** true
    - `<script>document.getElementById('img').onerror='alert(1)';</script>` → **Expected:** true
  - **Review Pattern:** Include all relevant attributes in detection logic.

### 4. **xss-004: Detect SVG Onload Injection**
- **Enhancements:**
  - **Add Test Cases:**
    - `<svg><script>alert(1)</script></svg>` → **Expected:** true
    - `<svg onload='alert(1)' onclick='alert(2)'></svg>` → **Expected:** true
  - **Review Pattern:** Adjust to be more inclusive of SVG manipulations.

### 5. **xss-005: Detect XSS Through Event Handler Attributes**
- **Enhancements:**
  - **Add Test Cases:**
    - `<div onmouseover='alert(1)'>Hover me</div>` → **Expected:** true
    - `<div>No click</div>` → **Expected:** false
  - **Review Pattern:** Ensure all potential event handlers are accounted for.

---

## Enhancements for SQL Injection Detection Rules

### 1. **sql-004: Detect Advanced SQL Injection Patterns**
- **Enhancements:**
  - **Add Test Cases:**
    - `SELECT * FROM users WHERE id='1' OR '1'='1' --` → **Expected:** true (multiple injections)
    - `SELECT * FROM users; DROP TABLE users; --` → **Expected:** true
  - **Review Pattern:** Include checks for comments and variations of SQL syntax.

### 2. **sql-005: Detect SQL Injection Using Time-Based Blind Techniques**
- **Enhancements:**
  - **Add Test Cases:**
    - `1; WAITFOR DELAY '00:00:10'` → **Expected:** true
    - `SELECT * FROM users WHERE id='1' AND SLEEP(5) --` → **Expected:** true
  - **Review Pattern:** Expand to include additional time-based SQL injection commands.

### 3. **sql-006: Detect SQL Injection with UNION-Based Techniques**
- **Enhancements:**
  - **Add Test Cases:**
    - `SELECT * FROM users UNION SELECT * FROM admin WHERE '1'='1';` → **Expected:** true
    - `SELECT id, name FROM products UNION ALL SELECT id, name FROM customers;` → **Expected:** true
  - **Review Pattern:** Ensure coverage for UNION queries with mismatched column types.

### 4. **sql-007: Detect SQL Injection with Comment-Based Techniques**
- **Enhancements:**
  - **Add Test Cases:**
    - `SELECT * FROM users WHERE id=1; -- comment` → **Expected:** true
    - `SELECT * FROM users; # comment` → **Expected:** true
  - **Review Pattern:** Check for comments at various positions in SQL statements.

### 5. **sql-008: Detect SQL Injection with Nested Queries**
- **Enhancements:**
  - **Add Test Cases:**
    - `SELECT * FROM (SELECT * FROM users) AS subquery;` → **Expected:** true
    - `SELECT * FROM (SELECT id, name FROM users WHERE id='1') AS subquery;` → **Expected:** true
  - **Review Pattern:** Ensure detection can identify multiple nesting levels.

---

## Importance of Monitoring False Positive Rates
- **Continuous Monitoring:** Implement a system to regularly analyze detection logs to identify false positives.
- **Adjustments:** Modify patterns based on inputs that lead to false positives to improve accuracy.
- **Performance Metrics:** Track detection rates, false positives, and refine rules based on real-world performance.

---

This consolidated document serves as a guide for reviewing and implementing the proposed enhancements to the XSS and SQL injection detection rules, with an emphasis on continual monitoring and improvement to ensure effectiveness.