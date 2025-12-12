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
    <!-- html2canvas 라이브러리 -->
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    <!-- Kakao SDK (integrity 속성 제거) -->
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.0/kakao.min.js" crossorigin="anonymous"></script>
    <style>
        /* 카카오 버튼 스타일 */
        .btn-kakao {
            background-color: #FEE500;
            color: #000000;
            border: none;
            font-weight: bold;
        }

        .btn-kakao:hover {
            background-color: #FDD835;
            color: #000000;
        }
    </style>
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
            <div class="row g-3 h-100" id="capture-area">
                <!-- 왼쪽: 큐티 본문 -->
                <div class="col-md-6 h-100">
                    <div class="qt-content-area">
                        <div class="qt-header">
                            <p class="qt-date">${date}</p>
                            <h1 class="qt-title">${title}</h1>
                            <p class="qt-passage">${passage}</p>
                        </div>
                        <div class="qt-body">
                            <c:forEach var="verse" items="${verses}">
                                <div class="verse">
                                    <p><c:out value="${verse}" escapeXml="false"/></p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- 오른쪽: 묵상 노트 -->
                <div class="col-md-6 h-100">
                    <div class="qt-note-area">
                        <h2 class="note-title">나의 묵상</h2>
                        <textarea class="note-textarea" placeholder="오늘 말씀을 통해 받은 은혜를 기록해보세요..."></textarea>
                    </div>
                </div>
            </div>

            <!-- 버튼 영역 -->
            <div class="btn-area text-end">
                <button class="btn btn-primary btn-sm me-2" onclick="saveImage()">
                    <i class="fas fa-download"></i> 이미지로 저장하기
                </button>
                <button class="btn btn-kakao btn-sm" onclick="shareKakao()">
                    <i class="fas fa-comment"></i> 카카오톡으로 공유하기
                </button>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="<c:url value='/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js'/>"></script>
<script>
    // 카카오 SDK 초기화
    try {
        Kakao.init('58f34b0958d81c971284547077722431');
    } catch (e) {
        console.error("Kakao SDK 초기화 실패. 키를 확인하세요.");
    }

    // 공통 캡처 함수
    function captureScreen() {
        const captureArea = document.getElementById("capture-area");
        return html2canvas(captureArea, {
            scale: 2,
            backgroundColor: "#f0f8ff",
            logging: false,
            useCORS: true
        });
    }

    // 1. 이미지 저장 함수
    function saveImage() {
        captureScreen().then(canvas => {
            const image = canvas.toDataURL("image/png");
            const link = document.createElement("a");
            link.href = image;
            link.download = "오늘의큐티_" + new Date().toISOString().slice(0, 10) + ".png";
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }).catch(err => {
            console.error("이미지 저장 실패:", err);
            alert("이미지 저장에 실패했습니다.");
        });
    }

    // html2canvas 등으로 캡처된 canvas가 있다고 가정
    function shareCapturedImage(canvas) {
        // 1. Canvas를 Blob(파일 데이터)으로 변환
        canvas.toBlob(function (blob) {
            // 2. File 객체 생성 (카카오 API는 FileList나 File 배열을 받습니다)
            const file = new File([blob], "capture.png", {type: "image/png"});
            // 3. 카카오 서버로 이미지 업로드
            Kakao.Share.uploadImage({
                file: [file] // 배열 형태로 전달
            })
                .then(function (response) {
                    // 4. 업로드된 이미지 URL 획득
                    const imageUrl = response.infos.original.url;

                    // 5. 해당 URL을 사용하여 카카오톡 공유
                    Kakao.Share.sendDefault({
                        objectType: 'feed',
                        content: {
                            title: '캡처 이미지 공유',
                            description: '웹페이지에서 캡처된 화면입니다.',
                            imageUrl: imageUrl, // 카카오 서버에 저장된 URL 사용
                            link: {
                                mobileWebUrl: window.location.href,
                                webUrl: window.location.href
                            },
                        },
                    });
                })
                .catch(function (error) {
                    console.error('이미지 업로드 실패:', error);
                });
        });
    }

    // 2. 카카오톡 공유 함수
    function shareKakao() {
        if (!Kakao.isInitialized()) {
            alert('카카오 JavaScript 키가 설정되지 않았습니다. 코드를 확인해주세요.');
            return;
        }

        captureScreen().then(canvas => {
            shareCapturedImage(canvas);
            /* canvas.toBlob(blob => {
                 const file = new File([blob], "qt_share.png", {type: "image/png"});

                 Kakao.Share.uploadImage({
                     file: [file]
                 })
                     .then(function (response) {
                         const imageUrl = response.infos.original.url;
                         const width = canvas.width;
                         const height = canvas.height;

                         Kakao.Share.sendDefault({
                             objectType: 'feed',
                             content: {
                                 title: '



            ${title}',
                                description: '



            ${date} 묵상 나눔',
                                imageUrl: imageUrl,
                                imageWidth: width,
                                imageHeight: height,
                                link: {
                                    mobileWebUrl: window.location.href,
                                    webUrl: window.location.href
                                }
                            }
                        });
                    })
                    .catch(function (error) {
                        console.error('카카오 이미지 업로드 실패:', error);
                        alert('카카오톡 공유에 실패했습니다.');
                    });
            });*/
        }).catch(err => {
            console.error("화면 캡처 실패:", err);
            alert("화면 캡처에 실패했습니다.");
        });
    }
</script>
</body>
</html>
