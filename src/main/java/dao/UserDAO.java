package dao;
import model.User;
import java.util.List;

public interface UserDAO {
    User authenticate(String username, String password);
    List<User> getAllUsers();
    User getUserById(int id);
    boolean addUser(User user);
    boolean updateUser(User user);
    boolean updateWithPassword(User user);
    boolean toggleStatus(int id, boolean status);
}
