<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .card-stat { border: none; border-radius: 1rem; transition: transform 0.3s; }
        .card-stat:hover { transform: translateY(-5px); }
        .icon-box { width: 60px; height: 60px; border-radius: 1rem; display: flex; align-items: center; justify-content: center; }
    </style>
</head>
<body>
    <jsp:include page="/views/common/navbar.jsp" />
    
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="/views/common/sidebar.jsp" />
            
            <main class="col p-4 bg-light bg-opacity-50">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <span class="badge bg-primary p-2">
                            <i class="bi bi-calendar3 me-2"></i><%= new java.util.Date() %>
                        </span>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Students Stat -->
                    <div class="col-md-4">
                        <div class="card card-stat shadow-sm p-3">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-primary bg-opacity-10 text-primary me-3">
                                    <i class="bi bi-people-fill fs-3"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-0">Total Students</h6>
                                    <h3 class="fw-bold mb-0">${totalStudents}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Books Stat -->
                    <div class="col-md-4">
                        <div class="card card-stat shadow-sm p-3">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-success bg-opacity-10 text-success me-3">
                                    <i class="bi bi-book-half fs-3"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-0">Total Books</h6>
                                    <h3 class="fw-bold mb-0">${totalBooks}</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Active Users Stat -->
                    <div class="col-md-4">
                        <div class="card card-stat shadow-sm p-3">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-warning bg-opacity-10 text-warning me-3">
                                    <i class="bi bi-broadcast-pin fs-3"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-0">Active Sessions</h6>
                                    <h3 class="fw-bold mb-0">${activeUsers}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
