<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="site-header sticky-top">
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/'/>">The Holy Bible</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/bible'/>">성경 읽기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/qt'/>">오늘의 큐티본문</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">기도 노트</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
