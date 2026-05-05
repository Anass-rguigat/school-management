<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Borrowing - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/common/navbar.jsp" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="/views/common/sidebar.jsp" />
            <main class="col p-4">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow-sm border-0 rounded-4">
                            <div class="card-header bg-white py-3 border-0">
                                <h3 class="fw-bold mb-0">New Borrowing</h3>
                            </div>
                            <div class="card-body">
                                <form action="borrow" method="post">
                                    <div class="mb-3">
                                        <label class="form-label">Select Student</label>
                                        <select name="studentId" class="form-select" required>
                                            <c:forEach var="s" items="${students}">
                                                <option value="${s.id}">${s.name} (#${s.id})</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-4">
                                        <label class="form-label">Select Available Book</label>
                                        <select name="bookId" class="form-select" required>
                                            <c:forEach var="b" items="${books}">
                                                <c:if test="${b.available}">
                                                    <option value="${b.id}">${b.title} by ${b.author}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary px-4">Confirm Borrow</button>
                                        <a href="borrow" class="btn btn-light px-4">Cancel</a>
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
