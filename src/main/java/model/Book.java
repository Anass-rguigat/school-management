package model;

public class Book {
    private int id;
    private String title;
    private String author;
    private boolean available;
    private boolean deleted;

    public Book() {}

    public Book(int id, String title, String author, boolean available, boolean deleted) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.available = available;
        this.deleted = deleted;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }
    public boolean isDeleted() { return deleted; }
    public void setDeleted(boolean deleted) { this.deleted = deleted; }
}
