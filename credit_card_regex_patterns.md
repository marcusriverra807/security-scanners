# Credit Card Regex Patterns

Below are regex patterns to match various credit card formats:

1. **Visa**: 
   - Pattern: `^4[0-9]{12}(?:[0-9]{3})?$`
   - Description: Matches Visa cards starting with 4, followed by 12 or 15 digits.

2. **MasterCard**: 
   - Pattern: `^5[1-5][0-9]{14}$`
   - Description: Matches MasterCard cards starting with 51 through 55, followed by 14 digits.

3. **American Express**: 
   - Pattern: `^3[47][0-9]{13}$`
   - Description: Matches American Express cards starting with 34 or 37, followed by 13 digits.

4. **Discover**: 
   - Pattern: `^6(?:011|5[0-9]{2})[0-9]{12}$`
   - Description: Matches Discover cards starting with 6011 or 5xx, followed by 12 digits.

5. **Diners Club**: 
   - Pattern: `^3(?:0[0-5]|[68][0-9])[0-9]{11}$`
   - Description: Matches Diners Club cards starting with 300-305 or 36, 38, followed by 11 digits.

6. **JCB**: 
   - Pattern: `^(?:2131|1800|35\d{3})\d{11}$`
   - Description: Matches JCB cards starting with 2131, 1800, or 35, followed by 11 digits.

7. **General Pattern**: 
   - Pattern: `(?:\d{4}[ -]?){3}\d{4}`
   - Description: Matches any credit card number format that is 16 digits long, allowing spaces or hyphens between groups of four digits.

### Usage
These patterns can be used in applications to validate credit card inputs, ensuring they conform to expected formats.