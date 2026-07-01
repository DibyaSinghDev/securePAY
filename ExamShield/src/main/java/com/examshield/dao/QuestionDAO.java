package com.examshield.dao;

import com.examshield.model.Question;
import com.examshield.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {


// ADD QUESTION

public boolean addQuestion(Question question) {

    boolean status = false;

    try {

        Connection con =
                DBConnection.getConnection();

        String sql =
                "INSERT INTO questions(exam_id,question,option1,option2,option3,option4,correct_option) VALUES(?,?,?,?,?,?,?)";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(
                1,
                question.getExamId());

        ps.setString(
                2,
                question.getQuestionText());

        ps.setString(
                3,
                question.getOptionA());

        ps.setString(
                4,
                question.getOptionB());

        ps.setString(
                5,
                question.getOptionC());

        ps.setString(
                6,
                question.getOptionD());

        ps.setString(
                7,
                question.getCorrectAnswer());

        status =
                ps.executeUpdate() > 0;

    } catch (Exception e) {

        e.printStackTrace();
    }

    return status;
}

// GET QUESTIONS BY EXAM

public List<Question> getQuestionsByExam(
        int examId) {

    List<Question> questions =
            new ArrayList<>();

    try {

        Connection con =
                DBConnection.getConnection();

        String sql =
                "SELECT * FROM questions WHERE exam_id=?";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(
                1,
                examId);

        ResultSet rs =
                ps.executeQuery();

        while (rs.next()) {

            Question q =
                    new Question();

            q.setId(
                    rs.getInt("id"));

            q.setExamId(
                    rs.getInt("exam_id"));

            q.setQuestionText(
                    rs.getString("question"));

            q.setOptionA(
                    rs.getString("option1"));

            q.setOptionB(
                    rs.getString("option2"));

            q.setOptionC(
                    rs.getString("option3"));

            q.setOptionD(
                    rs.getString("option4"));

            q.setCorrectAnswer(
                    rs.getString("correct_option"));

            questions.add(q);
        }

    } catch (Exception e) {

        e.printStackTrace();
    }

    return questions;
}

// GET QUESTION BY ID

public Question getQuestionById(
        int questionId) {

    Question q = null;

    try {

        Connection con =
                DBConnection.getConnection();

        String sql =
                "SELECT * FROM questions WHERE id=?";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(
                1,
                questionId);

        ResultSet rs =
                ps.executeQuery();

        if (rs.next()) {

            q = new Question();

            q.setId(
                    rs.getInt("id"));

            q.setExamId(
                    rs.getInt("exam_id"));

            q.setQuestionText(
                    rs.getString("question"));

            q.setOptionA(
                    rs.getString("option1"));

            q.setOptionB(
                    rs.getString("option2"));

            q.setOptionC(
                    rs.getString("option3"));

            q.setOptionD(
                    rs.getString("option4"));

            q.setCorrectAnswer(
                    rs.getString("correct_option"));
        }

    } catch (Exception e) {

        e.printStackTrace();
    }

    return q;
}

// DELETE QUESTION

public boolean deleteQuestion(
        int questionId) {

    boolean status = false;

    try {

        Connection con =
                DBConnection.getConnection();

        String sql =
                "DELETE FROM questions WHERE id=?";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(
                1,
                questionId);

        status =
                ps.executeUpdate() > 0;

    } catch (Exception e) {

        e.printStackTrace();
    }

    return status;
}

// COUNT QUESTIONS

public int getQuestionCount(
        int examId) {

    int count = 0;

    try {

        Connection con =
                DBConnection.getConnection();

        String sql =
                "SELECT COUNT(*) FROM questions WHERE exam_id=?";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(
                1,
                examId);

        ResultSet rs =
                ps.executeQuery();

        if (rs.next()) {

            count =
                    rs.getInt(1);
        }

    } catch (Exception e) {

        e.printStackTrace();
    }

    return count;
}


}
