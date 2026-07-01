package com.securepay.dao;

import com.securepay.model.Loan;
import com.securepay.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoanDAO {

    // ===========================
    // Apply for Loan
    // ===========================

    public boolean applyLoan(Loan loan) {

        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "INSERT INTO loan_applications " +
                    "(user_id, account_number, applicant_name, email, " +
                    "loan_type, loan_amount, duration, monthly_income, purpose, status) " +
                    "VALUES (?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, loan.getUserId());
            ps.setString(2, loan.getAccountNumber());
            ps.setString(3, loan.getApplicantName());
            ps.setString(4, loan.getEmail());
            ps.setString(5, loan.getLoanType());
            ps.setDouble(6, loan.getLoanAmount());
            ps.setInt(7, loan.getDuration());
            ps.setDouble(8, loan.getMonthlyIncome());
            ps.setString(9, loan.getPurpose());
            ps.setString(10, "Pending");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ===========================
    // Get Loan By ID
    // ===========================

    public Loan getLoanById(int loanId) {

        Loan loan = null;

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM loan_applications WHERE loan_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, loanId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                loan = new Loan();

                loan.setLoanId(rs.getInt("loan_id"));
                loan.setUserId(rs.getInt("user_id"));
                loan.setAccountNumber(rs.getString("account_number"));
                loan.setApplicantName(rs.getString("applicant_name"));
                loan.setEmail(rs.getString("email"));
                loan.setLoanType(rs.getString("loan_type"));
                loan.setLoanAmount(rs.getDouble("loan_amount"));
                loan.setDuration(rs.getInt("duration"));
                loan.setMonthlyIncome(rs.getDouble("monthly_income"));
                loan.setPurpose(rs.getString("purpose"));
                loan.setStatus(rs.getString("status"));
                loan.setAdminRemark(rs.getString("admin_remark"));
                loan.setAppliedDate(rs.getTimestamp("applied_date"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return loan;
    }

    // ===========================
    // Get Logged-in User Loans
    // ===========================

    public List<Loan> getUserLoans(int userId) {

        List<Loan> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM loan_applications " +
                    "WHERE user_id=? " +
                    "ORDER BY applied_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Loan loan = new Loan();

                loan.setLoanId(rs.getInt("loan_id"));
                loan.setUserId(rs.getInt("user_id"));
                loan.setAccountNumber(rs.getString("account_number"));
                loan.setApplicantName(rs.getString("applicant_name"));
                loan.setEmail(rs.getString("email"));
                loan.setLoanType(rs.getString("loan_type"));
                loan.setLoanAmount(rs.getDouble("loan_amount"));
                loan.setDuration(rs.getInt("duration"));
                loan.setMonthlyIncome(rs.getDouble("monthly_income"));
                loan.setPurpose(rs.getString("purpose"));
                loan.setStatus(rs.getString("status"));
                loan.setAdminRemark(rs.getString("admin_remark"));
                loan.setAppliedDate(rs.getTimestamp("applied_date"));

                list.add(loan);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
 // Get All Loan Applications
    public List<Loan> getAllLoanApplications() {

        List<Loan> list = new ArrayList<>();

        try(Connection con = DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM loan_applications " +
                    "ORDER BY applied_date DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Loan loan = new Loan();

                loan.setLoanId(rs.getInt("loan_id"));
                loan.setUserId(rs.getInt("user_id"));
                loan.setAccountNumber(rs.getString("account_number"));
                loan.setApplicantName(rs.getString("applicant_name"));
                loan.setEmail(rs.getString("email"));
                loan.setLoanType(rs.getString("loan_type"));
                loan.setLoanAmount(rs.getDouble("loan_amount"));
                loan.setDuration(rs.getInt("duration"));
                loan.setMonthlyIncome(rs.getDouble("monthly_income"));
                loan.setPurpose(rs.getString("purpose"));
                loan.setStatus(rs.getString("status"));
                loan.setAdminRemark(rs.getString("admin_remark"));
                loan.setAppliedDate(rs.getTimestamp("applied_date"));

                list.add(loan);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
 // Approve Loan
    public boolean approveLoan(int loanId,
                               String remark) {

        boolean status = false;

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            con.setAutoCommit(false);

            Loan loan =
                    getLoanById(loanId);

            if(loan == null){

                return false;
            }

            // Update Loan Status
            String loanSql =
                    "UPDATE loan_applications " +
                    "SET status=?, admin_remark=? " +
                    "WHERE loan_id=?";

            PreparedStatement ps1 =
                    con.prepareStatement(loanSql);

            ps1.setString(1, "Approved");
            ps1.setString(2, remark);
            ps1.setInt(3, loanId);

            ps1.executeUpdate();

            // Credit User Balance
            String userSql =
                    "UPDATE users " +
                    "SET balance = balance + ? " +
                    "WHERE account_number=?";

            PreparedStatement ps2 =
                    con.prepareStatement(userSql);

            ps2.setDouble(1,
                    loan.getLoanAmount());

            ps2.setString(2,
                    loan.getAccountNumber());

            ps2.executeUpdate();

            con.commit();

            status = true;

        } catch(Exception e) {

            e.printStackTrace();

            try{

                if(con!=null){

                    con.rollback();
                }

            }catch(Exception ex){

                ex.printStackTrace();
            }

        } finally {

            try{

                if(con!=null){

                    con.setAutoCommit(true);

                    con.close();
                }

            }catch(Exception e){

                e.printStackTrace();
            }

        }

        return status;
    }
 // Reject Loan
    public boolean rejectLoan(int loanId,
                              String remark) {

        boolean status = false;

        try(Connection con =
                DBConnection.getConnection()) {

            String sql =
                    "UPDATE loan_applications " +
                    "SET status=?, admin_remark=? " +
                    "WHERE loan_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1,
                    "Rejected");

            ps.setString(2,
                    remark);

            ps.setInt(3,
                    loanId);

            int rows =
                    ps.executeUpdate();

            if(rows>0){

                status = true;
            }

        } catch(Exception e){

            e.printStackTrace();
        }

        return status;
    }
    
}