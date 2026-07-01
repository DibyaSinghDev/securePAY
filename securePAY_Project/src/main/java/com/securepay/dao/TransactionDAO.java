package com.securepay.dao;

import com.securepay.model.Transaction;
import com.securepay.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    public boolean addTransaction(String senderAccount,
                                  String receiverAccount,
                                  double amount,
                                  String transactionType){

        boolean status=false;

        try(Connection con=DBConnection.getConnection()){

            String sql="INSERT INTO transactions(sender_account,receiver_account,amount,transaction_type) VALUES(?,?,?,?)";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,senderAccount);
            ps.setString(2,receiverAccount);
            ps.setDouble(3,amount);
            ps.setString(4,transactionType);

            status=ps.executeUpdate()>0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    public List<Transaction> getTransactions(String accountNumber){

        List<Transaction> list=new ArrayList<>();

        try(Connection con=DBConnection.getConnection()){

            String sql="SELECT * FROM transactions WHERE sender_account=? OR receiver_account=? ORDER BY transaction_date DESC";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,accountNumber);
            ps.setString(2,accountNumber);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                Transaction t=new Transaction();

                t.setTransactionId(rs.getInt("transaction_id"));
                t.setSenderAccount(rs.getString("sender_account"));
                t.setReceiverAccount(rs.getString("receiver_account"));
                t.setAmount(rs.getDouble("amount"));
                t.setTransactionType(rs.getString("transaction_type"));
                t.setTransactionDate(rs.getTimestamp("transaction_date"));

                list.add(t);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    public List<Transaction> getRecentTransactions(String accountNumber){

        List<Transaction> list=new ArrayList<>();

        try(Connection con=DBConnection.getConnection()){

            String sql="SELECT * FROM transactions WHERE sender_account=? OR receiver_account=? ORDER BY transaction_date DESC LIMIT 5";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,accountNumber);
            ps.setString(2,accountNumber);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                Transaction t=new Transaction();

                t.setTransactionId(rs.getInt("transaction_id"));
                t.setSenderAccount(rs.getString("sender_account"));
                t.setReceiverAccount(rs.getString("receiver_account"));
                t.setAmount(rs.getDouble("amount"));
                t.setTransactionType(rs.getString("transaction_type"));
                t.setTransactionDate(rs.getTimestamp("transaction_date"));

                list.add(t);

            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    public double getTotalCredit(String accountNumber){

        double total=0;

        try(Connection con=DBConnection.getConnection()){

            String sql="SELECT SUM(amount) FROM transactions WHERE receiver_account=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,accountNumber);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                total=rs.getDouble(1);

            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return total;
    }

    public double getTotalDebit(String accountNumber){

        double total=0;

        try(Connection con=DBConnection.getConnection()){

            String sql="SELECT SUM(amount) FROM transactions WHERE sender_account=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,accountNumber);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                total=rs.getDouble(1);

            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return total;
    }

    public void addRechargeTransaction(String accountNumber,
                                       double amount,
                                       String provider,
                                       String serviceType){

        addTransaction(accountNumber,
                provider,
                amount,
                serviceType);
    }

}