package com.securepay.util;

import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    private static final String FROM_EMAIL =
            "singhdibya168@gmail.com";

    private static final String APP_PASSWORD =
            "danu neoi yhit evyf";

    private static Session getSession() {

        Properties props =
                new Properties();

        props.put(
                "mail.smtp.auth",
                "true");

        props.put(
                "mail.smtp.starttls.enable",
                "true");

        props.put(
                "mail.smtp.host",
                "smtp.gmail.com");

        props.put(
                "mail.smtp.port",
                "587");

        return Session.getInstance(
                props,

                new Authenticator() {

                    @Override
                    protected PasswordAuthentication
                    getPasswordAuthentication() {

                        return new PasswordAuthentication(
                                FROM_EMAIL,
                                APP_PASSWORD);
                    }
                });
    }

    // OTP EMAIL

    public static boolean sendOTP(
            String toEmail,
            String otp) {

        try {

            Session session =
                    getSession();

            Message message =
                    new MimeMessage(
                            session);

            message.setFrom(
                    new InternetAddress(
                            FROM_EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,

                    InternetAddress.parse(
                            toEmail));

            message.setSubject(
                    "SecurePAY OTP Verification");

            message.setText(
                    "Dear Customer,\n\n" +

                    "Your OTP is : " +
                    otp +

                    "\n\nPlease do not share it with anyone.\n\n" +

                    "Regards,\nSecurePAY Team");

            Transport.send(
                    message);

            return true;

        } catch(Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    // TRANSACTION EMAIL

    public static boolean sendTransactionMail(

            String toEmail,

            String transactionType,

            double amount,

            double balance) {

        try {

            Session session =
                    getSession();

            Message message =
                    new MimeMessage(
                            session);

            message.setFrom(
                    new InternetAddress(
                            FROM_EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,

                    InternetAddress.parse(
                            toEmail));

            message.setSubject(
                    "SecurePAY Transaction Alert");

            String mailContent =

                    "Dear Customer,\n\n" +

                    "Transaction Successful.\n\n" +

                    "Transaction Type : " +
                    transactionType +

                    "\nAmount : ₹" +
                    amount +

                    "\nAvailable Balance : ₹" +
                    balance +

                    "\n\nThank you for banking with SecurePAY." +

                    "\n\nSecurePAY Team";

            message.setText(
                    mailContent);

            Transport.send(
                    message);

            return true;

        } catch(Exception e) {

            e.printStackTrace();
        }

        return false;
    }
}