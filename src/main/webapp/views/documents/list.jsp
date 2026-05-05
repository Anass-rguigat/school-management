<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Documents List - School Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
    <style>
        .preview-container {
            min-height: 400px;
            max-height: 70vh;
            overflow: auto;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .preview-container img {
            max-width: 100%;
            height: auto;
            object-fit: contain;
        }
        .preview-container iframe {
            width: 100%;
            height: 65vh;
            border: none;
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
                    <h2 class="fw-bold text-dark"><i class="bi bi-file-earmark-text me-2 text-primary"></i>Documents Management</h2>
                    <div class="d-flex gap-2">
                        <form action="${pageContext.request.contextPath}/documents" method="get" class="d-flex shadow-sm rounded-pill overflow-hidden">
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="query" class="form-control border-0 ps-4" placeholder="Search documents..." style="width: 250px;">
                            <button class="btn btn-white border-0 text-primary" type="submit"><i class="bi bi-search"></i></button>
                        </form>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/documents?action=new" class="btn btn-primary rounded-pill px-4 shadow-sm">
                                <i class="bi bi-plus-lg me-1"></i>New Upload
                            </a>
                        </c:if>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-primary text-white">
                                    <tr>
                                        <th class="ps-4 py-3">Document Title</th>
                                        <th>Student</th>
                                        <th>Actions</th>
                                        <th class="text-end pe-4">Management</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="d" items="${documents}">
                                        <tr>
                                            <td class="ps-4">
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-primary bg-opacity-10 text-primary rounded-3 p-2 me-3">
                                                        <i class="bi bi-file-earmark-text fs-5"></i>
                                                    </div>
                                                    <div>
                                                        <span class="fw-bold d-block text-dark">${d.title}</span>
                                                        <small class="text-muted text-truncate d-inline-block" style="max-width: 150px;">${d.filePath}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark border p-2">
                                                    <i class="bi bi-person-circle me-1"></i>${d.studentName}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <button class="btn btn-sm btn-outline-info rounded-pill px-3" 
                                                            onclick="viewDocument('${pageContext.request.contextPath}/${d.filePath}', '${d.title}')">
                                                        <i class="bi bi-eye me-1"></i>View
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/${d.filePath}" 
                                                       download 
                                                       class="btn btn-sm btn-outline-success rounded-pill px-3">
                                                        <i class="bi bi-download me-1"></i>Download
                                                    </a>
                                                </div>
                                            </td>
                                            <td class="text-end pe-4">
                                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                                    <div class="btn-group">
                                                        <a href="${pageContext.request.contextPath}/documents?action=edit&id=${d.id}" class="btn btn-sm btn-light border text-primary rounded-circle me-2 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px;">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        <button type="button" class="btn btn-sm btn-light text-danger border rounded-circle shadow-sm d-flex align-items-center justify-content-center" 
                                                                style="width: 32px; height: 32px;"
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#deleteModal"
                                                                data-id="${d.id}" 
                                                                data-title="${fn:escapeXml(d.title)}">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty documents}">
                                        <tr><td colspan="4" class="text-center py-5 text-muted">No documents found.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- View Modal -->
    <div class="modal fade" id="viewModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold" id="modalTitle"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div id="previewContent" class="preview-container">
                        <!-- Content will be injected here -->
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
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
                        <i class="bi bi-file-earmark-text fs-1"></i>
                    </div>
                    <p class="fs-5 mb-1">Are you sure you want to delete this document?</p>
                    <p class="text-muted fw-bold" id="deleteDocTitle"></p>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/documents" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteDocId">
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
        const viewModal = document.getElementById('viewModal');
        const deleteModal = document.getElementById('deleteModal');
        
        function viewDocument(url, title) {
            const modalTitle = document.getElementById('modalTitle');
            modalTitle.innerText = title;
            const preview = document.getElementById('previewContent');
            const ext = url.split('.').pop().toLowerCase();
            preview.innerHTML = '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>';

            if (['jpg', 'jpeg', 'png', 'gif', 'webp'].includes(ext)) {
                const img = new Image();
                img.src = url;
                img.className = 'img-fluid rounded shadow-sm';
                img.onload = () => { preview.innerHTML = ''; preview.appendChild(img); };
            } else if (ext === 'pdf') {
                preview.innerHTML = `<iframe src="${url}" title="${title}"></iframe>`;
            } else {
                preview.innerHTML = `<p class="text-muted">Preview not available for this file type.</p>`;
            }
            new bootstrap.Modal(viewModal).show();
        }

        deleteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            const title = button.getAttribute('data-title');
            
            document.getElementById('deleteDocId').value = id;
            document.getElementById('deleteDocTitle').innerText = title;
        });
    </script>
</body>
</html>
