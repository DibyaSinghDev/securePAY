package com.examshield.dao;

import com.examshield.model.Admin;
import com.examshield.util.DBConnection;

import java.sql.*;

public class AdminDAO {

    public Admin login(
            String username,
            String password){

        Admin admin = null;

        try{

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM admins WHERE username=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                admin = new Admin();

                admin.setId(
                        rs.getInt("id"));

                admin.setUsername(
                        rs.getString("username"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return admin;
    }
}