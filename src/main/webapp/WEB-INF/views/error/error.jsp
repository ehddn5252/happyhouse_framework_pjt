<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#mvIndex").click(function () {
                location.href = "${root}";
            });
        });
    </script>
	<main id="main"> 
    <div class="container text-center mt-3">
        <div class="col-lg-8 mx-auto">
            <div class="jumbotron">
                <h2 class="text-danger">${msg}</h2>
                <p class="mt-4"><button type="button" id="mvIndex" class="btn btn-outline-dark">메인으로 이동</button></p>
            </div>
        </div>
    </div>
    </main>

<%@ include file="../footer.jsp" %>