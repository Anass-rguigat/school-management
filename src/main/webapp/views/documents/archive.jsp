<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document Archive - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="/views/common/navbar.jsp" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="/views/common/sidebar.jsp" />
            <main class="col p-4">
                <h2 class="fw-bold mb-4"><i class="bi bi-archive me-2"></i>Document Archive</h2>
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-0">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Title</th>
                                    <th>Path</th>
                                    <th class="text-end pe-4">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="d" items="${documents}">
                                    <tr>
                                        <td class="ps-4">${d.id}</td>
                                        <td>${d.title}</td>
                                        <td class="small text-muted">${d.filePath}</td>
                                        <td class="text-end pe-4">
                                            <a href="${pageContext.request.contextPath}/archive?action=restore&module=document&id=${d.id}" class="btn btn-sm btn-success">
                                                <i class="bi bi-arrow-counterclockwise me-1"></i>Restore
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty documents}">
                                    <tr><td colspan="4" class="text-center py-5 text-muted">Archive is empty.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
