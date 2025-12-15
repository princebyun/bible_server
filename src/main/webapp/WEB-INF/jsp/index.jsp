<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Worshiping Church Bible</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<c:url value='/webjars/bootstrap/5.3.0/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/main.css'/>" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>

<div class="top-bar">
    <a href="<c:url value='/'/>" class="logo">Worshiping Church Bible</a>
</div>

<div class="main-content">
    <div class="search-wrapper">
        <h1 class="main-title">어떤 말씀을 찾고 계신가요??</h1>
        <form action="<c:url value='/bible'/>" method="get" class="search-form">
            <i class="fas fa-search search-icon"></i>
            <input class="search-input" type="search" name="keyword" placeholder="성경 구절이나 단어를 검색해보세요..."
                   aria-label="Search">
        </form>
    </div>

    <div class="card-container">
        <!-- 성경 읽기 카드 -->
        <a href="<c:url value='/bible'/>" class="custom-card">
            <div class="card-image-wrapper">
                <img src="<c:url value='/resources/images/card_bible.png'/>" alt="성경 검색">
            </div>
            <div class="card-content">
                <div class="card-title">성경 읽기</div>
                <div class="card-desc">원하는 구절을 찾아<br>말씀을 묵상하세요.</div>
            </div>
        </a>

        <!-- 오늘의 큐티본문 카드 -->
        <a href="<c:url value='/qt'/>" class="custom-card">
            <div class="card-image-wrapper">
                <img src="<c:url value='/resources/images/card_today.png'/>" alt="오늘의 큐티본문">
            </div>
            <div class="card-content">
                <div class="card-title">오늘의 큐티본문</div>
                <div class="card-desc">매일 주어지는 새로운<br>은혜의 말씀을 만나보세요.</div>
            </div>
        </a>

        <!-- 주일말씀 카드 -->
        <a href="<c:url value='/sermons'/>" class="custom-card">
            <div class="card-image-wrapper">
                <img src="<c:url value='/resources/images/card_pray.png'/>" alt="주일말씀">
            </div>
            <div class="card-content">
                <div class="card-title">주일말씀</div>
                <div class="card-desc">지난 주일의 은혜로운<br>말씀을 다시 만나보세요.</div>
            </div>
        </a>

        <!-- 클린챗 검사 카드 -->
        <a href="<c:url value='/cleanbot/chat'/>" class="custom-card">
            <div class="card-image-wrapper">
                <img src="<c:url value='/resources/images/card_chat.png'/>" alt="클린챗 검사">
            </div>
            <div class="card-content">
                <div class="card-title">클린챗 검사</div>
                <div class="card-desc">텍스트의 유해성을<br>검사합니다.</div>
            </div>
        </a>

        <!-- 클린이미지 검사 카드 -->
        <a href="<c:url value='/cleanbot/image'/>" class="custom-card">
            <div class="card-image-wrapper">
                <img src="<c:url value='/resources/images/card_image.png'/>" alt="클린이미지 검사">
            </div>
            <div class="card-content">
                <div class="card-title">클린이미지 검사</div>
                <div class="card-desc">이미지의 유해성을<br>검사합니다.</div>
            </div>
        </a>
    </div>
</div>

<script src="<c:url value='/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>