package com.securepay.dao;

import com.securepay.model.User;
import com.securepay.util.DBConnection;

import java.sql.*;

public class UserDAO {

    // Check Email Exists
    public boolean emailExists(String email) {

        boolean exists = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM users WHERE email=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                exists = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return exists;
    }

    // Register User
    public boolean registerUser(User user) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "INSERT INTO users(name,email,password,account_number,balance) VALUES(?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAccountNumber());
            ps.setDouble(5, user.getBalance());

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {

                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }

    // Login User
    public User loginUser(
            String email,
            String password) {

        User user = null;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setId(
                        rs.getInt("id"));

                user.setName(
                        rs.getString("name"));

                user.setEmail(
                        rs.getString("email"));

                user.setAccountNumber(
                        rs.getString("account_number"));

                user.setBalance(
                        rs.getDouble("balance"));
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return user;
    }
    public boolean transferMoney(
            String senderAccount,
            double amount) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            System.out.println(
                    "Sender Account = " +
                    senderAccount);

            String sql =
                    "UPDATE users " +
                    "SET balance = balance - ? " +
                    "WHERE account_number = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, senderAccount);

            int rows =
                    ps.executeUpdate();

            System.out.println(
                    "Rows Updated = " +
                    rows);

            if(rows > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    public boolean creditReceiver(
            String receiverAccount,
            double amount) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users " +
                    "SET balance = balance + ? " +
                    "WHERE account_number = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, receiverAccount);

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public boolean depositMoney(
            String accountNumber,
            double amount) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users " +
                    "SET balance = balance + ? " +
                    "WHERE account_number = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, accountNumber);

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {

                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }

    public boolean withdrawMoney(
            String accountNumber,
            double amount) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users " +
                    "SET balance = balance - ? " +
                    "WHERE account_number = ? " +
                    "AND balance >= ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, accountNumber);
            ps.setDouble(3, amount);

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {

                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }
    public boolean changePassword(
            String email,
            String oldPassword,
            String newPassword) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users " +
                    "SET password=? " +
                    "WHERE email=? " +
                    "AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.setString(3, oldPassword);

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {

                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }

 // Get Current Balance
    public double getBalance(String accountNumber) {

        double balance = 0;

        try(Connection con = DBConnection.getConnection()) {

            String sql = "SELECT balance FROM users WHERE account_number=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, accountNumber);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                balance = rs.getDouble("balance");
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return balance;
    }
 // Deduct Balance for Recharge
    public boolean rechargeMoney(
            String accountNumber,
            double amount) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users " +
                    "SET balance = balance - ? " +
                    "WHERE account_number=? " +
                    "AND balance >= ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, amount);
            ps.setString(2, accountNumber);
            ps.setDouble(3, amount);

            int rows = ps.executeUpdate();

            if(rows > 0) {

                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }
 // Add Reward Coins
    public boolean addRewardCoins(
            String accountNumber,
            int coins) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE users " +
                    "SET reward_coins = reward_coins + ? " +
                    "WHERE account_number=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, coins);
            ps.setString(2, accountNumber);

            int rows = ps.executeUpdate();

            if(rows > 0) {

                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }
}