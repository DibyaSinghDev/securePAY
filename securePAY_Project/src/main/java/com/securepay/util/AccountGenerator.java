package com.securepay.util;

import java.util.Random;

public class AccountGenerator {

    public static String generateAccountNumber() {

        Random random = new Random();

        return "ACC" +
                (100000 + random.nextInt(900000));
    }
}