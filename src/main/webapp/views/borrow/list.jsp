<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Borrow Management - School Manager</title>
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
                    <h2 class="fw-bold"><i class="bi bi-arrow-left-right me-2"></i>Borrow / Return</h2>
                    <a href="borrow?action=new" class="btn btn-primary rounded-pill px-4">
                        <i class="bi bi-plus-lg me-1"></i>New Borrowing
                    </a>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="ps-4">Student</th>
                                        <th>Book</th>
                                        <th>Borrow Date</th>
                                        <th>Return Date</th>
                                        <th class="text-end pe-4">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="b" items="${borrows}">
                                        <tr>
                                            <td class="ps-4 fw-bold">${b.studentName}</td>
                                            <td>${b.bookTitle}</td>
                                            <td><span class="text-muted small">${b.borrowDate}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty b.returnDate}">
                                                        <span class="badge bg-success-subtle text-success">${b.returnDate}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning-subtle text-warning">Not Returned</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end pe-4">
                                                <c:if test="${empty b.returnDate}">
                                                    <a href="borrow?action=return&id=${b.id}&bookId=${b.bookId}" class="btn btn-sm btn-outline-success">
                                                        <i class="bi bi-check2-circle me-1"></i>Return Book
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty borrows}">
                                        <tr><td colspan="5" class="text-center py-5 text-muted">No borrowing history.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
