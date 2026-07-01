package com.securepay.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.securepay.model.Recharge;
import com.securepay.util.DBConnection;

public class RechargeDAO {

	public String generateTransactionId() {
		 return "SPR" + UUID.randomUUID().toString().replace("-", "")
	                .substring(0, 10).toUpperCase();

	}

	public boolean saveRecharge(Recharge recharge) {
		 boolean status = false;

	        String sql = "INSERT INTO recharge_history "
	                + "(user_id, service_type, provider, customer_number, amount, transaction_id, status) "
	                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {

	            ps.setInt(1, recharge.getUserId());
	            ps.setString(2, recharge.getServiceType());
	            ps.setString(3, recharge.getProvider());
	            ps.setString(4, recharge.getCustomerNumber());
	            ps.setDouble(5, recharge.getAmount());
	            ps.setString(6, recharge.getTransactionId());
	            ps.setString(7, recharge.getStatus());

	            status = ps.executeUpdate() > 0;

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return status;

	}

	public List<Recharge> getRechargeHistory(int userId) {

        List<Recharge> list = new ArrayList<>();

        String sql = "SELECT * FROM recharge_history "
                + "WHERE user_id=? ORDER BY recharge_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Recharge recharge = new Recharge();

                recharge.setId(rs.getInt("id"));
                recharge.setUserId(rs.getInt("user_id"));
                recharge.setServiceType(rs.getString("service_type"));
                recharge.setProvider(rs.getString("provider"));
                recharge.setCustomerNumber(rs.getString("customer_number"));
                recharge.setAmount(rs.getDouble("amount"));
                recharge.setTransactionId(rs.getString("transaction_id"));
                recharge.setStatus(rs.getString("status"));
                recharge.setRechargeDate(rs.getTimestamp("recharge_date"));

                list.add(recharge);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;


	
	}

	

}