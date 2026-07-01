package com.examshield.dao;

import com.examshield.model.Exam;
import com.examshield.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamDAO {

    // Add Exam

    public boolean addExam(Exam exam) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO exams(title,description,duration,total_marks,exam_date,status) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, exam.getTitle());
            ps.setString(2, exam.getDescription());
            ps.setInt(3, exam.getDuration());
            ps.setInt(4, exam.getTotalMarks());
            ps.setString(5, exam.getExamDate());
            ps.setString(6, exam.getStatus());

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

    // Get All Exams

    public List<Exam> getAllExams() {

        List<Exam> examList =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM exams ORDER BY id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Exam exam =
                        new Exam();

                exam.setId(
                        rs.getInt("id"));

                exam.setTitle(
                        rs.getString("title"));

                exam.setDescription(
                        rs.getString("description"));

                exam.setDuration(
                        rs.getInt("duration"));

                exam.setTotalMarks(
                        rs.getInt("total_marks"));

                exam.setExamDate(
                        rs.getString("exam_date"));

                exam.setStatus(
                        rs.getString("status"));

                examList.add(exam);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return examList;
    }

    // Get Exam By Id

    public Exam getExamById(int id) {

        Exam exam = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM exams WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                exam = new Exam();

                exam.setId(
                        rs.getInt("id"));

                exam.setTitle(
                        rs.getString("title"));

                exam.setDescription(
                        rs.getString("description"));

                exam.setDuration(
                        rs.getInt("duration"));

                exam.setTotalMarks(
                        rs.getInt("total_marks"));

                exam.setExamDate(
                        rs.getString("exam_date"));

                exam.setStatus(
                        rs.getString("status"));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return exam;
    }

    // Update Exam

    public boolean updateExam(Exam exam) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE exams SET title=?,description=?,duration=?,total_marks=?,exam_date=?,status=? WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, exam.getTitle());
            ps.setString(2, exam.getDescription());
            ps.setInt(3, exam.getDuration());
            ps.setInt(4, exam.getTotalMarks());
            ps.setString(5, exam.getExamDate());
            ps.setString(6, exam.getStatus());
            ps.setInt(7, exam.getId());

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

    // Delete Exam

    public boolean deleteExam(int id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "DELETE FROM exams WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

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

    // Total Exams

    public int getTotalExams() {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT COUNT(*) FROM exams";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }
}