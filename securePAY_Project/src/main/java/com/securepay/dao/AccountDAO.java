package com.securepay.dao;

import com.securepay.util.DBConnection;

import java.sql.*;

public class AccountDAO {

    // Get Balance

    public double getBalance(
            String accountNumber) {

        double balance = 0;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "SELECT balance FROM users WHERE account_number=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, accountNumber);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                balance =
                        rs.getDouble("balance");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return balance;
    }

    // Deposit

    public boolean deposit(
            String accountNumber,
            double amount) {

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users SET balance = balance + ? WHERE account_number=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, accountNumber);

            return ps.executeUpdate() > 0;

        } catch(Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    // Withdraw

    public boolean withdraw(
            String accountNumber,
            double amount) {

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users SET balance = balance - ? WHERE account_number=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, accountNumber);

            return ps.executeUpdate() > 0;

        } catch(Exception e) {

            e.printStackTrace();
        }

        return false;
    }
}