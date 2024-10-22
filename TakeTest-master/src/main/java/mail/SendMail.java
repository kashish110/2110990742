package mail;

import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.activation.*;

public class SendMail {
	
	// using java mail api
	
	public boolean send(String subject, String text, String to) {
		
		final String from = "kashishgulati70@gmail.com";
		final String password = "klhepmjsidkjwsyy";
		
		Properties props = new Properties();
        props.put("mail.transport.protocol", "smtps");
        props.put("mail.smtps.host", "smtp.gmail.com");
        props.put("mail.smtps.port", 465);
        props.put("mail.smtps.auth", "true");
        props.put("mail.smtps.quitwait", "false");
//        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.socketFactory.port", "465"); // SSL Port
        props.put("mail.smtp.socketFactory.class", "jakarta.net.ssl.SSLSocketFactory"); // SSL Factory Class
        props.put("mail.smtp.socketFactory.fallback", "false");
        
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });
        session.setDebug(true);
        
        try {
        	Message message = new MimeMessage(session);            
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to) );
            message.setSubject(subject);
            message.setText(text);
            
            try (Transport tt = session.getTransport()) {
                tt.connect(from, password);
                tt.sendMessage(message, message.getAllRecipients());
            }
            return true;
        }catch (Exception e) {
        	e.printStackTrace();
        }
		
		return false;
	}

}
