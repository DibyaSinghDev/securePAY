package com.securepay.dao;

import com.securepay.model.User;
import com.securepay.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    public boolean validateAdmin(
            String username,
            String password) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM admin WHERE username=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }

    public int getTotalUsers() {

        int count = 0;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "SELECT COUNT(*) FROM users";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    public int getTotalTransactions() {

        int count = 0;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "SELECT COUNT(*) FROM transactions";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    public double getTotalBalance() {

        double total = 0;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "SELECT SUM(balance) FROM users";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                total = rs.getDouble(1);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return total;
    }

    public List<User> getAllUsers() {

    	
    	List<User> users =
    	        new ArrayList<>();

    	try(Connection con =
    	        DBConnection.getConnection()) {

    	    String sql =
    	            "SELECT * FROM users";

    	    PreparedStatement ps =
    	            con.prepareStatement(sql);

    	    ResultSet rs =
    	            ps.executeQuery();

    	    while(rs.next()) {

    	        User user =
    	                new User();

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

    	        users.add(user);
    	    }

    	} catch(Exception e) {

    	    e.printStackTrace();
    	}

    	return users;
    	

    	}

	public boolean deleteUser(
    		String accountNumber) {

    		
    		boolean status = false;

    		try(Connection con =
    		        DBConnection.getConnection()) {

    		    String sql =
    		            "DELETE FROM users WHERE account_number=?";

    		    PreparedStatement ps =
    		            con.prepareStatement(sql);

    		    ps.setString(
    		            1,
    		            accountNumber);

    		    int rows =
    		            ps.executeUpdate();

    		    if(rows > 0){

    		        status = true;
    		    }

    		} catch(Exception e){

    		    e.printStackTrace();
    		}

    		return status;
    		

    		}


   

    
}