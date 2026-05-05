package model;

public class Document {
    private int id;
    private String title;
    private String filePath;
    private int studentId;
    private String studentName; // Joined field
    private boolean deleted;

    public Document() {}

    public Document(int id, String title, String filePath, int studentId, boolean deleted) {
        this.id = id;
        this.title = title;
        this.filePath = filePath;
        this.studentId = studentId;
        this.deleted = deleted;
    }

    public Document(int id, String title, String filePath, int studentId, String studentName, boolean deleted) {
        this.id = id;
        this.title = title;
        this.filePath = filePath;
        this.studentId = studentId;
        this.studentName = studentName;
        this.deleted = deleted;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public boolean isDeleted() { return deleted; }
    public void setDeleted(boolean deleted) { this.deleted = deleted; }
}
