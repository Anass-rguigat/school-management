package dao;
import model.Document;
import java.util.List;

public interface DocumentDAO {
    List<Document> getAllActive();
    List<Document> getAllArchived();
    List<Document> getByStudentId(int studentId);
    boolean add(Document doc);
    boolean update(Document doc);
    boolean softDelete(int id);
    boolean restore(int id);
    Document getById(int id);
    List<Document> search(String query);
}
