package dao;
import model.Log;
import java.util.List;

public interface LogDAO {
    boolean add(Log log);
    List<Log> getAll();
}
