<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>성경책</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<c:url value='/webjars/bootstrap/5.3.0/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/menu.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/main.css'/>" rel="stylesheet">
</head>
<body>
<!-- 공통 메뉴 삽입 -->
<%@ include file="menu.jsp" %>

<div class="container main-container">
    <h1 class="main-title">The Holy Bible</h1>
    <p class="sub-title">당신의 삶에 말씀이 함께하기를</p>

    <!-- 챗봇 스타일 검색창 -->
    <div class="chat-search-container mt-5">
        <form action="<c:url value='/bible'/>" method="get" class="d-flex align-items-center">
            <input class="form-control me-2 flex-grow-1" type="search" name="keyword" placeholder="단어나 구절 입력 (예: 예수)"
                   aria-label="Search">
            <button class="btn btn-outline-success text-nowrap" type="submit">검색</button>
        </form>
    </div>
</div>

<script src="<c:url value='/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>
