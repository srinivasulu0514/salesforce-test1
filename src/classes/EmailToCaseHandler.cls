global class EmailToCaseHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        // Create a new InboundEmailResult object
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        try {
            // Extract the email subject and body
            String subject = email.subject;
            String body = email.plainTextBody;

            // Create a new case
            Case newCase = new Case(
                Subject = subject,
                Description = body,
                Origin = 'Email',
                Status = 'New'
            );
            insert newCase;

            System.debug('Case created with Id: ' + newCase.Id);
            result.success = true;
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            result.success = false;
        }
        
        return result;
    }
}