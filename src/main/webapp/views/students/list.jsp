<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Students List - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="/views/common/navbar.jsp" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="/views/common/sidebar.jsp" />
            <main class="col p-4 bg-light bg-opacity-50">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold"><i class="bi bi-people me-2"></i>Students Management</h2>
                    <div class="d-flex gap-2">
                        <form action="${pageContext.request.contextPath}/students" method="get" class="d-flex">
                            <input type="hidden" name="action" value="search">
                            <div class="input-group">
                                <input type="text" name="query" class="form-control" placeholder="Search students...">
                                <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                            </div>
                        </form>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/students?action=new" class="btn btn-success rounded-pill px-4">
                                <i class="bi bi-plus-lg me-1"></i>Add Student
                            </a>
                        </c:if>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="ps-4">ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Field</th>
                                        <th class="text-end pe-4">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="s" items="${students}">
                                        <tr>
                                            <td class="ps-4 fw-bold">#${s.id}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 me-2">
                                                        <i class="bi bi-person"></i>
                                                    </div>
                                                    ${s.name}
                                                </div>
                                            </td>
                                            <td>${s.email}</td>
                                            <td><span class="badge bg-info text-dark">${s.field}</span></td>
                                            <td class="text-end pe-4">
                                                <c:choose>
                                                    <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                                        <a href="${pageContext.request.contextPath}/students?action=edit&id=${s.id}" class="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil"></i></a>
                                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#deleteModal"
                                                                data-id="${s.id}" 
                                                                data-name="${fn:escapeXml(s.name)}">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted small">Read Only</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty students}">
                                        <tr><td colspan="5" class="text-center py-5 text-muted">No students found.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4 text-center">
                    <div class="bg-danger bg-opacity-10 text-danger rounded-circle p-4 d-inline-block mb-3">
                        <i class="bi bi-exclamation-triangle fs-1"></i>
                    </div>
                    <p class="fs-5 mb-1">Are you sure you want to remove this student?</p>
                    <p class="text-muted fw-bold" id="deleteStudentName"></p>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/students" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteStudentId">
                    </form>
                </div>
                <div class="modal-footer border-0 pt-0 justify-content-center pb-4">
                    <button type="button" class="btn btn-light rounded-pill px-4 me-2" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger rounded-pill px-4" onclick="document.getElementById('deleteForm').submit()">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            const name = button.getAttribute('data-name');
            
            document.getElementById('deleteStudentId').value = id;
            document.getElementById('deleteStudentName').innerText = name;
        });
    </script>
</body>
</html>
