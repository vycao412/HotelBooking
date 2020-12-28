/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utils;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;

/**
 *
 * @author VYCAO
 */
public class SendingEmail {
    
    private String userEmail;

    private final Logger LOG = Logger.getLogger(SendingEmail.class);

    public SendingEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    // confirm Booking via Email
    public void sendConfirmBooking(String link) {
        final String email = "sunmoon2092@gmail.com";
        final String password = "Soon@2092";

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getDefaultInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
            message.setSubject("CONFIRM BOOKING");
            message.setText("Thank for booking room in my website!\n Your confirm link: " + link);
            Transport.send(message);
        } catch (Exception e) {
            LOG.error("Error at confirmEmail: " + e.toString());
        }
    }
    
}
