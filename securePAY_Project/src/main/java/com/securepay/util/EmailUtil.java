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
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });
    }

    // Holds color/icon/sign scheme for a transaction type
    private static class TypeStyle {
        String color, bg, border, sign, icon;
        TypeStyle(String color, String bg, String border, String sign, String icon) {
            this.color = color; this.bg = bg; this.border = border; this.sign = sign; this.icon = icon;
        }
    }

    private static TypeStyle resolveStyle(String transactionType) {
        String type = transactionType == null ? "" : transactionType.trim().toUpperCase();
        switch (type) {
            case "DEBIT":
            case "WITHDRAWAL":
                return new TypeStyle("#dc2626", "#fef2f2", "#fecaca", "−", "↓");
            case "CREDIT":
            case "DEPOSIT":
                return new TypeStyle("#16a34a", "#f0fdf4", "#bbf7d0", "+", "↑");
            case "TRANSFER":
            case "TRANSFER OUT":
                return new TypeStyle("#dc2626", "#fef2f2", "#fecaca", "−", "→");
            case "TRANSFER IN":
                return new TypeStyle("#2563eb", "#eff6ff", "#bfdbfe", "+", "←");
            case "REFUND":
                return new TypeStyle("#7c3aed", "#f5f3ff", "#ddd6fe", "+", "↺");
            case "REVERSAL":
                return new TypeStyle("#d97706", "#fffbeb", "#fde68a", "+", "↺");
            case "BILL PAYMENT":
            case "PAYMENT":
                return new TypeStyle("#dc2626", "#fef2f2", "#fecaca", "−", "▤");
            case "CASHBACK":
            case "REWARD":
                return new TypeStyle("#0d9488", "#f0fdfa", "#99f6e4", "+", "★");
            case "FEE":
            case "CHARGE":
                return new TypeStyle("#ea580c", "#fff7ed", "#fed7aa", "−", "!");
            default:
                if (type.contains("DEBIT") || type.contains("WITHDRAW") || type.contains("OUT")) {
                    return new TypeStyle("#dc2626", "#fef2f2", "#fecaca", "−", "↓");
                } else if (type.contains("CREDIT") || type.contains("DEPOSIT") || type.contains("IN")) {
                    return new TypeStyle("#16a34a", "#f0fdf4", "#bbf7d0", "+", "↑");
                }
                return new TypeStyle("#4b5563", "#f3f4f6", "#e5e7eb", "", "•");
        }
    }

    // Masks account number, e.g. 1234567890 -> XXXXXX7890
    private static String maskAccount(String accountNo) {
        if (accountNo == null || accountNo.length() <= 4) return accountNo;
        String last4 = accountNo.substring(accountNo.length() - 4);
        StringBuilder masked = new StringBuilder();
        for (int i = 0; i < accountNo.length() - 4; i++) masked.append("X");
        return masked.append(last4).toString();
    }

    // ============ OTP EMAIL ============
    public static boolean sendOTP(String toEmail, String otp) {
        try {
            Session session = getSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "SecurePAY"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("SecurePAY OTP Verification");

            String htmlContent =
                "<div style='background-color:#eef1f6; padding:48px 20px; font-family:-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Arial,sans-serif;'>" +
                "<table role='presentation' width='100%' cellpadding='0' cellspacing='0' style='max-width:460px; margin:0 auto; background-color:#ffffff; border-radius:20px; overflow:hidden; box-shadow:0 8px 30px rgba(26,35,126,0.14);'>" +
                "<tr><td style='height:6px; background:linear-gradient(90deg,#3949ab 0%,#5c6bc0 50%,#7986cb 100%);'></td></tr>" +
                "<tr><td style='padding:40px 40px 8px; text-align:center;'>" +
                "<div style='width:52px; height:52px; background:linear-gradient(135deg,#1a237e,#3949ab); border-radius:14px; margin:0 auto 18px; line-height:52px; font-size:24px; box-shadow:0 6px 16px rgba(57,73,171,0.35);'>🔐</div>" +
                "<h1 style='color:#111827; margin:0; font-size:20px; font-weight:800; letter-spacing:-0.3px;'>SecurePAY</h1>" +
                "<p style='color:#9ca3af; margin:4px 0 0; font-size:12px; letter-spacing:1px; text-transform:uppercase; font-weight:600;'>Verification Required</p>" +
                "</td></tr>" +
                "<tr><td style='padding:24px 40px 8px;'>" +
                "<p style='font-size:14.5px; color:#374151; margin:0 0 26px; line-height:1.6; text-align:center;'>Enter this code to verify it's really you. It expires shortly, so don't wait around.</p>" +
                "<table role='presentation' width='100%' cellpadding='0' cellspacing='0'>" +
                "<tr><td style='background-color:#f8f9fe; border:1.5px solid #e0e4f5; border-radius:14px; padding:26px; text-align:center;'>" +
                "<p style='margin:0 0 10px; font-size:10.5px; color:#7c85c4; letter-spacing:2px; font-weight:700; text-transform:uppercase;'>Verification Code</p>" +
                "<p style='margin:0; font-size:36px; font-weight:800; color:#1a237e; letter-spacing:12px; font-family:Courier New,monospace;'>" + otp + "</p>" +
                "</td></tr></table>" +
                "</td></tr>" +
                "<tr><td style='padding:28px 40px 0;'><div style='border-top:1.5px dashed #e5e7eb;'></div></td></tr>" +
                "<tr><td style='padding:20px 40px 0;'>" +
                "<table role='presentation' width='100%' cellpadding='0' cellspacing='0'>" +
                "<tr><td style='background-color:#fef9e7; border-radius:10px; padding:14px 18px;'>" +
                "<p style='margin:0; font-size:12.5px; color:#92720b; line-height:1.5;'>🛡️ &nbsp;<strong>Keep it private.</strong> SecurePAY will never call or message you asking for this code.</p>" +
                "</td></tr></table>" +
                "</td></tr>" +
                "<tr><td style='padding:28px 40px 36px; text-align:center;'>" +
                "<p style='font-size:13px; color:#6b7280; margin:0; line-height:1.6;'>Regards,<br><strong style='color:#111827;'>SecurePAY Team</strong></p>" +
                "</td></tr>" +
                "<tr><td style='background-color:#fafbfc; padding:20px 40px; text-align:center; border-top:1px solid #f0f1f5;'>" +
                "<p style='font-size:11.5px; color:#adb2bd; margin:0; line-height:1.6;'>Automated message — please do not reply.<br>© 2026 SecurePAY. All rights reserved.</p>" +
                "</td></tr>" +
                "</table></div>";

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ============ SIMPLE TRANSACTION EMAIL (DEBIT / CREDIT / DEPOSIT / WITHDRAWAL etc) ============
    public static boolean sendTransactionMail(
            String toEmail, String transactionType, double amount, double balance) {
        return sendTransactionMailWithParty(toEmail, transactionType, amount, balance, null, null);
    }

    // ============ TRANSFER EMAIL — notifies BOTH sender and receiver ============
    public static boolean sendTransferMail(
            String senderEmail, String senderAccountNo, double senderBalanceAfter,
            String receiverEmail, String receiverAccountNo, double receiverBalanceAfter,
            double amount) {

        boolean senderMailSent = sendTransactionMailWithParty(
                senderEmail, "TRANSFER OUT", amount, senderBalanceAfter,
                "To A/C", maskAccount(receiverAccountNo));

        if (!senderMailSent) {
            System.err.println("SecurePAY: Failed to send transfer-out mail to sender: " + senderEmail);
        }

        boolean receiverMailSent = sendTransactionMailWithParty(
                receiverEmail, "TRANSFER IN", amount, receiverBalanceAfter,
                "From A/C", maskAccount(senderAccountNo));

        if (!receiverMailSent) {
            System.err.println("SecurePAY: Failed to send transfer-in mail to receiver: " + receiverEmail);
        }

        // Both sides are independent — one failing shouldn't block the other.
        // Caller can inspect logs / return value to decide if a retry job is needed.
        return senderMailSent && receiverMailSent;
    }

    // Internal shared sender used by both sendTransactionMail and sendTransferMail
    private static boolean sendTransactionMailWithParty(
            String toEmail, String transactionType, double amount, double balance,
            String partyLabel, String partyValue) {
        try {
            Session session = getSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "SecurePAY"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("SecurePAY Transaction Alert - " + transactionType);

            TypeStyle style = resolveStyle(transactionType);
            String mailContent = buildTransactionTemplate(transactionType, amount, balance, style, partyLabel, partyValue);

            message.setContent(mailContent, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private static String buildTransactionTemplate(
            String transactionType, double amount, double balance,
            TypeStyle style, String partyLabel, String partyValue) {

        String partyRow = "";
        if (partyLabel != null && partyValue != null) {
            partyRow =
                "<tr><td colspan='2' style='border-top:1px solid #eef0f5;'></td></tr>" +
                "<tr>" +
                "<td style='padding:16px 20px; font-size:13px; color:#6b7280;'>" + partyLabel + "</td>" +
                "<td style='padding:16px 20px; font-size:13px; color:#111827; font-weight:700; text-align:right;'>" + partyValue + "</td>" +
                "</tr>";
        }

        return
        "<div style='background-color:#eef1f6; padding:48px 20px; font-family:-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Arial,sans-serif;'>" +
        "<table role='presentation' width='100%' cellpadding='0' cellspacing='0' style='max-width:480px; margin:0 auto; background-color:#ffffff; border-radius:20px; overflow:hidden; box-shadow:0 8px 30px rgba(26,35,126,0.14);'>" +

        "<tr><td style='height:6px; background:linear-gradient(90deg,#3949ab 0%,#5c6bc0 50%,#7986cb 100%);'></td></tr>" +

        "<tr><td style='padding:36px 40px 20px; text-align:center;'>" +
        "<h1 style='color:#111827; margin:0; font-size:19px; font-weight:800; letter-spacing:-0.3px;'>SecurePAY</h1>" +
        "<p style='color:#9ca3af; margin:4px 0 0; font-size:12px; letter-spacing:1px; text-transform:uppercase; font-weight:600;'>Transaction Receipt</p>" +
        "</td></tr>" +

        "<tr><td style='text-align:center; padding:0 40px 8px;'>" +
        "<span style='display:inline-block; background-color:#f0fdf4; color:#16a34a; font-size:12px; font-weight:700; padding:6px 16px; border-radius:20px; letter-spacing:0.3px;'>" +
        "&#10003; SUCCESSFUL</span>" +
        "</td></tr>" +

        "<tr><td style='padding:28px 40px 4px; text-align:center;'>" +
        "<p style='margin:0 0 6px; font-size:11.5px; color:#9ca3af; letter-spacing:1.2px; text-transform:uppercase; font-weight:700;'>" +
        transactionType + " Amount</p>" +
        "<p style='margin:0; font-size:42px; font-weight:800; color:" + style.color + "; letter-spacing:-1px;'>" +
        style.sign + " ₹" + String.format("%,.2f", amount) + "</p>" +
        "</td></tr>" +

        "<tr><td style='padding:24px 40px 0;'><div style='border-top:1.5px dashed #e5e7eb;'></div></td></tr>" +

        "<tr><td style='padding:22px 40px 0;'>" +
        "<table role='presentation' width='100%' cellpadding='0' cellspacing='0' style='background-color:#fafbfc; border:1px solid #eef0f5; border-radius:14px;'>" +

        "<tr>" +
        "<td style='padding:16px 20px; font-size:13px; color:#6b7280;'>Type</td>" +
        "<td style='padding:16px 20px; text-align:right;'>" +
        "<span style='background-color:" + style.bg + "; border:1px solid " + style.border + "; color:" + style.color + "; padding:4px 12px; border-radius:20px; font-size:12px; font-weight:700;'>" +
        style.icon + " " + transactionType.toUpperCase() + "</span>" +
        "</td></tr>" +

        "<tr><td colspan='2' style='border-top:1px solid #eef0f5;'></td></tr>" +

        "<tr>" +
        "<td style='padding:16px 20px; font-size:13px; color:#6b7280;'>Available Balance</td>" +
        "<td style='padding:16px 20px; font-size:15px; color:#111827; font-weight:700; text-align:right;'>₹" +
        String.format("%,.2f", balance) + "</td>" +
        "</tr>" +

        partyRow +

        "</table></td></tr>" +

        "<tr><td style='padding:22px 40px 0;'>" +
        "<table role='presentation' width='100%' cellpadding='0' cellspacing='0'>" +
        "<tr><td style='background-color:#fef9e7; border-radius:10px; padding:14px 18px;'>" +
        "<p style='margin:0; font-size:12.5px; color:#92720b; line-height:1.5;'>⚠️ &nbsp;Didn't make this transaction? <strong>Contact SecurePAY support</strong> right away.</p>" +
        "</td></tr></table>" +
        "</td></tr>" +

        "<tr><td style='padding:26px 40px 36px; text-align:center;'>" +
        "<p style='font-size:13px; color:#6b7280; margin:0;'>Thank you for banking with <strong style='color:#111827;'>SecurePAY</strong></p>" +
        "</td></tr>" +

        "<tr><td style='background-color:#fafbfc; padding:20px 40px; text-align:center; border-top:1px solid #f0f1f5;'>" +
        "<p style='font-size:11.5px; color:#adb2bd; margin:0; line-height:1.6;'>Automated message — please do not reply.<br>© 2026 SecurePAY. All rights reserved.</p>" +
        "</td></tr>" +

        "</table></div>";
    }
}