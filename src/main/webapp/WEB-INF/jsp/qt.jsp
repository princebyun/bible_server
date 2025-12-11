<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오늘의 큐티본문</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<c:url value='/webjars/bootstrap/5.3.0/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/common.css'/>" rel="stylesheet">
    <link href="<c:url value='/resources/css/qt.css'/>" rel="stylesheet">
    <!-- html2canvas 라이브러리 추가 -->
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
</head>
<body>

<!-- 공통 메뉴 삽입 -->
<%@ include file="menu.jsp" %>

<div class="qt-page-container">
    <c:choose>
        <c:when test="${not empty error}">
            <div class="alert alert-danger mt-4" role="alert">
                ${error}
            </div>
        </c:when>
        <c:otherwise>
            <!-- 캡처 대상 영역에 ID 부여 -->
            <div class="row g-3 h-100" id="capture-area"> <!-- g-3으로 간격 축소, h-100으로 높이 꽉 채움 -->
                <!-- 왼쪽: 큐티 본문 -->
                <div class="col-lg-6 h-100">
                    <div class="qt-content-area">
                        <div class="qt-header">
                            <p class="qt-date">${date}</p>
                            <h1 class="qt-title">${title}</h1>
                            <p class="qt-passage">${passage}</p>
                        </div>
                        <div class="qt-body">
                            <c:forEach var="verse" items="${verses}">
                                <div class="verse">
                                    <%-- HTML 태그가 그대로 렌더링되도록 escapeXml="false" 사용 --%>
                                    <p><c:out value="${verse}" escapeXml="false"/></p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- 오른쪽: 묵상 노트 -->
                <div class="col-lg-6 h-100">
                    <div class="qt-note-area">
                        <h2 class="note-title">나의 묵상</h2>
                        <textarea class="note-textarea" placeholder="오늘 말씀을 통해 받은 은혜를 기록해보세요..."></textarea>
                    </div>
                </div>
            </div>

            <!-- 버튼 영역 -->
            <div class="btn-area text-end">
                <button class="btn btn-primary btn-sm" onclick="saveAsImage()">이미지로 저장하기</button>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="<c:url value='/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js'/>"></script>
<script>
    function saveAsImage() {
        const captureArea = document.getElementById("capture-area");

        // html2canvas 옵션 설정
        html2canvas(captureArea, {
            scale: 2, // 해상도 2배 (선명하게)
            backgroundColor: "#f0f8ff", // 배경색 지정 (투명 배경 방지)
            logging: false,
            useCORS: true // 외부 이미지 사용 시 필요
        }).then(canvas => {
            // 캔버스를 이미지 URL로 변환
            const image = canvas.toDataURL("image/png");

            // 다운로드 링크 생성
            const link = document.createElement("a");
            link.href = image;
            link.download = "오늘의큐티_" + new Date().toISOString().slice(0, 10) + ".png"; // 파일명 설정

            // 링크 클릭하여 다운로드 실행
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }).catch(err => {
            console.error("이미지 저장 중 오류 발생:", err);
            alert("이미지 저장에 실패했습니다.");
        });
    }
</script>
</body>
</html>
