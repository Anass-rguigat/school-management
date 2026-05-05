package model;

public class Student {
    private int id;
    private String name;
    private String email;
    private String field;
    private boolean deleted;

    public Student() {}

    public Student(int id, String name, String email, String field, boolean deleted) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.field = field;
        this.deleted = deleted;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getField() { return field; }
    public void setField(String field) { this.field = field; }
    public boolean isDeleted() { return deleted; }
    public void setDeleted(boolean deleted) { this.deleted = deleted; }
}
