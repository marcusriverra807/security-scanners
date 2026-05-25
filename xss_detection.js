// Updated XSS detection logic
function detectXSS(input) {
    // Improved regex for XSS detection
    const xssRegex = /<script.*?>.*?<\/script>/gi;
    return xssRegex.test(input);
}