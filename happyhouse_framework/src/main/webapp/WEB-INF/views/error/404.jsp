<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#mvIndex").click(function () {
                location.href = "${root}/";
            });
        });
    </script>

    <div class="container text-center mt-3">
        <div class="col-lg-8 mx-auto">
            <div class="jumbotron">
                <h2 class="text-danger">요청하신 페이지를 찾을 수 없습니다.</h2>
                <p class="mt-4">URL 확인 후 다시 접속해 주세요.</p>
                <p class="mt-4"><button type="button" id="mvIndex" class="btn btn-outline-dark">메인으로 이동</button></p>
            </div>
        </div>
    </div>

<%@ include file="../footer.jsp" %>