<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex flex-column flex-shrink-0 p-3 bg-light border-end" style="width: 250px; min-height: calc(100vh - 56px);">
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link ${pageContext.request.requestURI.contains('dashboard') ? 'active' : 'link-dark'}">
                <i class="bi bi-speedometer2 me-2"></i>Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/students" class="nav-link ${pageContext.request.requestURI.contains('students') && !pageContext.request.requestURI.contains('archive') ? 'active' : 'link-dark'}">
                <i class="bi bi-people me-2"></i>Students
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/books" class="nav-link ${pageContext.request.requestURI.contains('books') && !pageContext.request.requestURI.contains('archive') ? 'active' : 'link-dark'}">
                <i class="bi bi-book me-2"></i>Books
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/documents" class="nav-link ${pageContext.request.requestURI.contains('documents') && !pageContext.request.requestURI.contains('archive') ? 'active' : 'link-dark'}">
                <i class="bi bi-file-earmark-text me-2"></i>Documents
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/borrow" class="nav-link ${pageContext.request.requestURI.contains('borrow') ? 'active' : 'link-dark'}">
                <i class="bi bi-arrow-left-right me-2"></i>Borrow / Return
            </a>
        </li>

        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <hr>
            <div class="small fw-bold text-muted mb-2 ps-3 text-uppercase">Admin Only</div>
            <li>
                <a href="${pageContext.request.contextPath}/users" class="nav-link ${pageContext.request.requestURI.contains('users') ? 'active' : 'link-dark'}">
                    <i class="bi bi-person-gear me-2"></i>Manage Users
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/logs" class="nav-link ${pageContext.request.requestURI.contains('logs') ? 'active' : 'link-dark'}">
                    <i class="bi bi-journal-text me-2"></i>System Logs
                </a>
            </li>
            <li>
                <div class="nav-link link-dark disabled pb-1">
                    <i class="bi bi-archive me-2"></i>Archives
                </div>
                <ul class="nav flex-column ms-4 small">
                    <li><a href="${pageContext.request.contextPath}/archive?module=student" class="nav-link link-dark py-1">Students</a></li>
                    <li><a href="${pageContext.request.contextPath}/archive?module=book" class="nav-link link-dark py-1">Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/archive?module=document" class="nav-link link-dark py-1">Documents</a></li>
                </ul>
            </li>
        </c:if>
    </ul>
</div>
