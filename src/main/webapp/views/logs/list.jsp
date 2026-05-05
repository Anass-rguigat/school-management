<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>System Logs - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
    <style>
        .log-detail-card {
            border-left: 4px solid var(--bs-primary);
            background: #f8f9fc;
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="/views/common/navbar.jsp" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="/views/common/sidebar.jsp" />
            <main class="col p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold text-dark"><i class="bi bi-journal-text me-2 text-primary"></i>System Audit Logs</h2>
                </div>

                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-primary text-white">
                                    <tr>
                                        <th class="ps-4 py-3">Timestamp</th>
                                        <th>User</th>
                                        <th>Action</th>
                                        <th>Module</th>
                                        <th class="text-end pe-4">Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="l" items="${logs}">
                                        <tr>
                                            <td class="ps-4">
                                                <small class="text-muted d-block">
                                                    <fmt:formatDate value="${l.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                </small>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-light text-primary rounded-circle p-2 me-2" style="width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;">
                                                        <i class="bi bi-person-fill"></i>
                                                    </div>
                                                    <span class="fw-bold">${l.username}</span>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge ${l.action == 'Delete' ? 'bg-danger-subtle text-danger' : (l.action == 'Create' ? 'bg-success-subtle text-success' : 'bg-primary-subtle text-primary')} px-3">
                                                    ${l.action}
                                                </span>
                                            </td>
                                            <td><span class="text-secondary fw-medium">${l.module}</span></td>
                                            <td class="text-end pe-4">
                                                <button class="btn btn-sm btn-light border text-primary rounded-circle" 
                                                        onclick="viewLogDetail('${l.id}', '${l.username}', '${l.action}', '${l.module}', '${l.url}', '${l.details}', '${l.createdAt}')">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty logs}">
                                        <tr><td colspan="5" class="text-center py-5 text-muted">No audit logs found.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Log Detail Modal -->
    <div class="modal fade" id="logModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold text-primary"><i class="bi bi-info-circle me-2"></i>Audit Log Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="p-3 rounded-3 bg-light border mb-3">
                                <label class="text-muted small text-uppercase fw-bold d-block mb-1">User Performed Action</label>
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-person-circle fs-4 me-2 text-primary"></i>
                                    <span class="fw-bold" id="logUser"></span>
                                </div>
                            </div>
                            <div class="p-3 rounded-3 bg-light border mb-3">
                                <label class="text-muted small text-uppercase fw-bold d-block mb-1">Module</label>
                                <span class="fw-bold" id="logModule"></span>
                            </div>
                            <div class="p-3 rounded-3 bg-light border">
                                <label class="text-muted small text-uppercase fw-bold d-block mb-1">Action Type</label>
                                <span class="badge bg-primary" id="logAction"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 rounded-3 bg-light border mb-3">
                                <label class="text-muted small text-uppercase fw-bold d-block mb-1">Timestamp</label>
                                <span class="fw-bold" id="logTime"></span>
                            </div>
                            <div class="p-3 rounded-3 bg-light border">
                                <label class="text-muted small text-uppercase fw-bold d-block mb-1">Request URL</label>
                                <div class="text-break small font-monospace" id="logUrl"></div>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="log-detail-card p-4 rounded-3 shadow-sm">
                                <label class="text-muted small text-uppercase fw-bold d-block mb-2">Activity Description</label>
                                <div class="fs-5 text-dark" id="logDetails"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const logModal = new bootstrap.Modal(document.getElementById('logModal'));
        
        function viewLogDetail(id, user, action, module, url, details, time) {
            document.getElementById('logUser').innerText = user;
            document.getElementById('logAction').innerText = action;
            document.getElementById('logModule').innerText = module;
            document.getElementById('logUrl').innerText = url;
            document.getElementById('logDetails').innerText = details;
            document.getElementById('logTime').innerText = time;
            
            // Set badge color based on action
            const badge = document.getElementById('logAction');
            badge.className = 'badge ';
            if (action === 'Delete') badge.classList.add('bg-danger');
            else if (action === 'Create') badge.classList.add('bg-success');
            else badge.classList.add('bg-primary');
            
            logModal.show();
        }
    </script>
</body>
</html>
