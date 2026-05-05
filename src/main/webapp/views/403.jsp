<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>403 Forbidden - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="text-center p-5 bg-white shadow-sm rounded-4" style="max-width: 500px;">
        <i class="bi bi-shield-lock-fill text-danger display-1 mb-4"></i>
        <h1 class="fw-bold">403 Forbidden</h1>
        <p class="text-muted mb-4">You do not have permission to access this page or perform this action.</p>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary rounded-pill px-5 py-2">
            <i class="bi bi-house-door me-2"></i>Back to Dashboard
        </a>
    </div>
</body>
</html>
