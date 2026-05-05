<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Users - School Manager</title>
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
                    <h2 class="fw-bold"><i class="bi bi-person-gear me-2"></i>User Management</h2>
                    <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="bi bi-person-plus me-1"></i>New User
                    </button>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-0">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Username</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th class="text-end pe-4">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${users}">
                                    <tr>
                                        <td class="ps-4 fw-bold">${u.username}</td>
                                        <td><span class="badge ${u.role == 'ADMIN' ? 'bg-dark' : 'bg-secondary'}">${u.role}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.active}">
                                                    <span class="badge bg-success-subtle text-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger-subtle text-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-4">
                                            <a href="users?action=edit&id=${u.id}" class="btn btn-sm btn-outline-primary me-1">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="users?action=toggle&id=${u.id}&status=${u.active}" class="btn btn-sm ${u.active ? 'btn-outline-danger' : 'btn-outline-success'}">
                                                ${u.active ? 'Deactivate' : 'Activate'}
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Add User Modal -->
                <div class="modal fade" id="addUserModal" tabindex="-1">
                    <div class="modal-dialog">
                        <form action="users" method="post" class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add New User</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Username</label>
                                    <input type="text" name="username" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Role</label>
                                    <select name="role" class="form-select">
                                        <option value="USER">USER</option>
                                        <option value="ADMIN">ADMIN</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary px-4">Create User</button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- Update User Modal -->
                <c:if test="${not empty userToEdit}">
                <div class="modal fade" id="updateUserModal" tabindex="-1">
                    <div class="modal-dialog">
                        <form action="users" method="post" class="modal-content">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${userToEdit.id}">
                            <div class="modal-header">
                                <h5 class="modal-title">Update User: ${userToEdit.username}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Username</label>
                                    <input type="text" name="username" class="form-control" value="${userToEdit.username}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">New Password (leave blank to keep current)</label>
                                    <input type="password" name="password" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Role</label>
                                    <select name="role" class="form-select">
                                        <option value="USER" ${userToEdit.role == 'USER' ? 'selected' : ''}>USER</option>
                                        <option value="ADMIN" ${userToEdit.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary px-4">Update User</button>
                            </div>
                        </form>
                    </div>
                </div>
                </c:if>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <c:if test="${not empty userToEdit}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(function() {
                var modalEl = document.getElementById('updateUserModal');
                if (modalEl) {
                    var myModal = new bootstrap.Modal(modalEl);
                    myModal.show();
                }
            }, 100);
        });
    </script>
    </c:if>
</body>
</html>
