package model;
import java.sql.Timestamp;

public class Log {
    private int id;
    private String username;
    private String action;
    private String module;
    private String url;
    private String details;
    private Timestamp createdAt;

    public Log() {}

    public Log(String username, String action, String module, String url, String details) {
        this.username = username;
        this.action = action;
        this.module = module;
        this.url = url;
        this.details = details;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    public String getModule() { return module; }
    public void setModule(String module) { this.module = module; }
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
