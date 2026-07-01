package com.examshield.model;

public class Exam {

    private int id;
    private String title;
    private String description;
    private int duration;
    private int totalMarks;
    private String examDate;
    private String status;

    public Exam() {
    }

    public Exam(int id,
                String title,
                String description,
                int duration,
                int totalMarks,
                String examDate,
                String status) {

        this.id = id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.totalMarks = totalMarks;
        this.examDate = examDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(int totalMarks) {
        this.totalMarks = totalMarks;
    }

    public String getExamDate() {
        return examDate;
    }

    public void setExamDate(String examDate) {
        this.examDate = examDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}