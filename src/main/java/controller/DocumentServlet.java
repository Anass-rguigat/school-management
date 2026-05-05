package controller;

import dao.DocumentDAO;
import dao.StudentDAO;
import dao.impl.DocumentDAOImpl;
import dao.impl.StudentDAOImpl;
import model.Document;
import util.LoggerUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/documents")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class DocumentServlet extends HttpServlet {
    private DocumentDAO documentDAO = new DocumentDAOImpl();
    private StudentDAO studentDAO = new StudentDAOImpl();
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("new".equals(action)) {
            req.setAttribute("students", studentDAO.getAllActive());
            req.getRequestDispatcher("/views/documents/upload.jsp").forward(req, resp);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("document", documentDAO.getById(id));
            req.setAttribute("students", studentDAO.getAllActive());
            req.getRequestDispatcher("/views/documents/edit.jsp").forward(req, resp);
        } else if ("delete".equals(action)) {
            int deleteId = Integer.parseInt(req.getParameter("id"));
            documentDAO.softDelete(deleteId);
            LoggerUtil.log(req, "Delete", "Documents", "Document ID " + deleteId + " moved to archive");
            resp.sendRedirect(req.getContextPath() + "/documents");
        } else if ("search".equals(action)) {
            String query = req.getParameter("query");
            req.setAttribute("documents", documentDAO.search(query));
            req.getRequestDispatcher("/views/documents/list.jsp").forward(req, resp);
        } else {
            req.setAttribute("documents", documentDAO.getAllActive());
            req.getRequestDispatcher("/views/documents/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            documentDAO.softDelete(id);
            LoggerUtil.log(req, "Delete", "Documents", "Document ID " + id + " moved to archive (POST)");
            resp.sendRedirect(req.getContextPath() + "/documents");
            return;
        }

        String title = req.getParameter("title");
        int studentId = Integer.parseInt(req.getParameter("studentId"));
        Part filePart = req.getPart("file");

        String applicationPath = req.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) fileSaveDir.mkdirs();

        if ("add".equals(action)) {
            String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
            saveFile(filePart, fileSaveDir, fileName);
            Document doc = new Document(0, title, UPLOAD_DIR + "/" + fileName, studentId, false);
            documentDAO.add(doc);
            LoggerUtil.log(req, "Create", "Documents", "New document uploaded: " + title);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Document doc = documentDAO.getById(id);
            doc.setTitle(title);
            doc.setStudentId(studentId);

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
                saveFile(filePart, fileSaveDir, fileName);
                doc.setFilePath(UPLOAD_DIR + "/" + fileName);
            }
            documentDAO.update(doc);
            LoggerUtil.log(req, "Update", "Documents", "Document ID " + id + " updated: " + title);
        }

        resp.sendRedirect(req.getContextPath() + "/documents");
    }

    private void saveFile(Part filePart, File fileSaveDir, String fileName) throws IOException {
        File file = new File(fileSaveDir, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
