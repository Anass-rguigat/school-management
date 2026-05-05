package dao;
import model.Student;
import java.util.List;

public interface StudentDAO {
    List<Student> getAllActive();
    List<Student> getAllArchived();
    List<Student> search(String query);
    Student getById(int id);
    boolean add(Student student);
    boolean update(Student student);
    boolean softDelete(int id);
    boolean restore(int id);
    int countActive();
}
