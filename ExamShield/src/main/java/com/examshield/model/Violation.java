package com.examshield.model;

public class Violation {

    private int id;
    private int userId;
    private int examId;

    private String violationType;

    public Violation() {
    }

    public Violation(
            int id,
            int userId,
            int examId,
            String violationType) {

        this.id = id;
        this.userId = userId;
        this.examId = examId;
        this.violationType = violationType;
    }

    public int getId() {
        return id;
    }

    public void setId(
            int id) {

        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(
            int userId) {

        this.userId = userId;
    }

    public int getExamId() {
        return examId;
    }

    public void setExamId(
            int examId) {

        this.examId = examId;
    }

    public String getViolationType() {
        return violationType;
    }

    public void setViolationType(
            String violationType) {

        this.violationType =
                violationType;
    }
}