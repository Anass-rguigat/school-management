package dao;
import model.Book;
import java.util.List;

public interface BookDAO {
    List<Book> getAllActive();
    List<Book> getAllArchived();
    Book getById(int id);
    boolean add(Book book);
    boolean update(Book book);
    boolean softDelete(int id);
    boolean restore(int id);
    boolean updateAvailability(int id, boolean available);
    int countActive();
}
