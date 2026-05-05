<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Document - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
</head>
<body class="bg-light">
    <jsp:include page="/views/common/navbar.jsp" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="/views/common/sidebar.jsp" />
            <main class="col p-4">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                            <div class="card-header bg-primary text-white py-3 border-0">
                                <h4 class="fw-bold mb-0">Edit Document</h4>
                            </div>
                            <div class="card-body p-4">
                                <form action="documents?action=update" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="id" value="${document.id}">
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Document Title</label>
                                        <input type="text" name="title" class="form-control rounded-pill px-3" value="${document.title}" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Attach to Student</label>
                                        <select name="studentId" class="form-select rounded-pill px-3" required>
                                            <c:forEach var="s" items="${students}">
                                                <option value="${s.id}" ${s.id == document.studentId ? 'selected' : ''}>
                                                    ${s.name} (#${s.id})
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Current File</label>
                                        <div class="p-2 border rounded-3 bg-light d-flex align-items-center">
                                            <i class="bi bi-file-earmark-check fs-4 me-2 text-success"></i>
                                            <span class="text-truncate small">${document.filePath}</span>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label fw-bold">Replace File (Optional)</label>
                                        <input type="file" name="file" class="form-control rounded-3">
                                        <div class="form-text">Leave empty to keep the current file.</div>
                                    </div>
                                    
                                    <div class="d-flex gap-2 pt-2">
                                        <button type="submit" class="btn btn-primary rounded-pill px-5 shadow-sm">Save Changes</button>
                                        <a href="documents" class="btn btn-light rounded-pill px-4">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
