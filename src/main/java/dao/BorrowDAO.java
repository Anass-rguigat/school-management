package dao;
import model.Borrow;
import java.util.List;

public interface BorrowDAO {
    List<Borrow> getAll();
    boolean borrowBook(int studentId, int bookId);
    boolean returnBook(int borrowId);
}
