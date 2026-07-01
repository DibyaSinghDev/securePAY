package com.examshield.dao;

import com.examshield.model.User;
import com.examshield.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // Register User

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO users(name,email,phone,password,role) VALUES(?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());

            int row =
                    ps.executeUpdate();

            if (row > 0) {

                status = true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }

    // Login User

    public User loginUser(
            String email,
            String password,
            String role) {

        User user = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users WHERE email=? AND password=? AND role=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, role);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(
                        rs.getInt("id"));

                user.setName(
                        rs.getString("name"));

                user.setEmail(
                        rs.getString("email"));

                user.setPhone(
                        rs.getString("phone"));

                user.setRole(
                        rs.getString("role"));
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return user;
    }
}