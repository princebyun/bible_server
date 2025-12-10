<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>성경 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/resources/css/view.css'/>" rel="stylesheet">
</head>
<body>

<!-- 공통 메뉴 삽입 -->
<%@ include file="menu.jsp" %>

<div class="container mt-4">
    <h1 class="mb-4">성경 보기</h1>

    <!-- 필터링 폼 -->
    <form id="filterForm" action="/bible" method="get" class="row g-3 align-items-end filter-form">
        <div class="col-md-2">
            <label for="cate" class="form-label">구분</label>
            <select id="cate" name="cate" class="form-select" onchange="submitFormOnChange()">
                <option value="">전체</option>
                <c:forEach var="t" items="${testaments}" varStatus="status">
                    <option value="${status.index + 1}" ${selectedCate != null && selectedCate == status.index + 1 ? 'selected' : ''}>${t}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-3">
            <label for="book" class="form-label">성경</label>
            <select id="book" name="book" class="form-select">
                <option value="">전체</option>
                <c:forEach var="b" items="${books}">
                    <option value="${b.book}" ${selectedBook != null && selectedBook == b.book ? 'selected' : ''}>${b.longLabel}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <label for="chapter" class="form-label">장</label>
            <input type="number" id="chapter" name="chapter" class="form-control" value="${selectedChapter}">
        </div>
        <div class="col-md-2">
            <label for="paragraph" class="form-label">절</label>
            <input type="number" id="paragraph" name="paragraph" class="form-control" value="${selectedParagraph}">
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-primary w-100">검색</button>
        </div>
    </form>

    <!-- 성경 구절 목록 -->
    <div id="bible-content">
        <c:if test="${empty verses}">
            <div class="alert alert-info">
                검색 결과가 없습니다.
            </div>
        </c:if>
        <c:forEach var="verse" items="${verses}">
            <div class="bible-verse">
                <p>
                    <strong>${verse.long_label} ${verse.chapter}:${verse.paragraph}</strong>
                    <span>${verse.sentence}</span>
                </p>
            </div>
        </c:forEach>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function submitFormOnChange() {
        // '구분' 변경 시 '성경'과 '장'을 초기화하지 않고 폼을 제출하여
        // 컨트롤러에서 '구분'에 맞는 '성경' 목록을 다시 로드하게 함
        document.getElementById('filterForm').submit();
    }
</script>
</body>
</html>
