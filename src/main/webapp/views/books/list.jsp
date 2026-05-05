<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Books List - School Manager</title>
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
                    <h2 class="fw-bold"><i class="bi bi-book me-2"></i>Books Management</h2>
                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                        <a href="books?action=new" class="btn btn-success rounded-pill px-4">
                            <i class="bi bi-plus-lg me-1"></i>Add Book
                        </a>
                    </c:if>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="ps-4">ID</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Status</th>
                                        <th class="text-end pe-4">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="b" items="${books}">
                                        <tr>
                                            <td class="ps-4 fw-bold">#${b.id}</td>
                                            <td>${b.title}</td>
                                            <td>${b.author}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${b.available}">
                                                        <span class="badge bg-success-subtle text-success px-3">Available</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger-subtle text-danger px-3">Borrowed</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end pe-4">
                                                <c:choose>
                                                    <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                                        <a href="${pageContext.request.contextPath}/books?action=edit&id=${b.id}" class="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil"></i></a>
                                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#deleteModal"
                                                                data-id="${b.id}" 
                                                                data-title="${fn:escapeXml(b.title)}">
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
                                    <c:if test="${empty books}">
                                        <tr><td colspan="5" class="text-center py-5 text-muted">No books found.</td></tr>
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
                        <i class="bi bi-book fs-1"></i>
                    </div>
                    <p class="fs-5 mb-1">Are you sure you want to delete this book?</p>
                    <p class="text-muted fw-bold" id="deleteBookTitle"></p>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/books" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteBookId">
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
            const title = button.getAttribute('data-title');
            
            document.getElementById('deleteBookId').value = id;
            document.getElementById('deleteBookTitle').innerText = title;
        });
    </script>
</body>
</html>
