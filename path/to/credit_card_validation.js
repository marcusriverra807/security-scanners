// Updated regex patterns for credit card validation
const creditCardRegex = /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9]{2})[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|2(?:014|149)[0-9]{10})$/;

// Function to validate credit card
function validateCreditCard(cardNumber) {
    return creditCardRegex.test(cardNumber);
}