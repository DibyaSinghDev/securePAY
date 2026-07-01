package com.securepay.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.securepay.model.Notification;
import com.securepay.util.DBConnection;

public class NotificationDAO {

    // =============================
    // Add Notification
    // =============================
    public boolean addNotification(int userId,
                                   String title,
                                   String message) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "INSERT INTO notifications(user_id,title,message) VALUES(?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, message);

            int rows =
                    ps.executeUpdate();

            if(rows > 0){

                status = true;
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return status;
    }

    // =============================
    // Get User Notifications
    // =============================
    public List<Notification> getNotifications(int userId){

        List<Notification> list =
                new ArrayList<>();

        try(Connection con =
                DBConnection.getConnection()){

            String sql =
                    "SELECT * FROM notifications " +
                    "WHERE user_id=? " +
                    "ORDER BY created_at DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Notification n =
                        new Notification();

                n.setNotificationId(
                        rs.getInt("notification_id"));

                n.setUserId(
                        rs.getInt("user_id"));

                n.setTitle(
                        rs.getString("title"));

                n.setMessage(
                        rs.getString("message"));

                n.setRead(
                        rs.getBoolean("is_read"));

                n.setCreatedAt(
                        rs.getTimestamp("created_at"));

                list.add(n);

            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return list;
    }

    // =============================
    // Mark Notification Read
    // =============================
    public boolean markAsRead(int notificationId){

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()){

            String sql =
                    "UPDATE notifications " +
                    "SET is_read=TRUE " +
                    "WHERE notification_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, notificationId);

            int rows =
                    ps.executeUpdate();

            if(rows > 0){

                status = true;
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return status;
    }

    // =============================
    // Delete Notification
    // =============================
    public boolean deleteNotification(int notificationId){

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()){

            String sql =
                    "DELETE FROM notifications " +
                    "WHERE notification_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, notificationId);

            int rows =
                    ps.executeUpdate();

            if(rows > 0){

                status = true;
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return status;
    }
    public int getUnreadNotificationCount(int userId) {

        int count = 0;

        String sql = "SELECT COUNT(*) FROM notifications WHERE user_id=? AND is_read=FALSE";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                count = rs.getInt(1);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return count;
    }

}