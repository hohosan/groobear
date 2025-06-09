<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--해당 파일에 타이틀 정보를 넣어준다--%>

<form action="/depInsertPost" method="post" id="depInsertForm" class="needs-validation" novalidate>
	<div class="card-style chat-about h-100"
		style="justify-content: center;">
		<h6 class="text-sm text-medium"></h6>
		<div class="chat-about-profile">
			<div class="content text-center">
				<h5 class="text-bold mb-10"></h5>
				<span class="status-btn success-btn">부서 등록</span>
			</div>
		</div>
		<div class="activity-meta text-start" style="margin-top: 20px;">
			<%-- 상위부서 값 --%>
			<%-- 여기가 실제 보내야할 값 --%>
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="upperDep" class="form-label required">소속부서
						<span class="text-danger">*</span>
				</label> 
				<select id="upperDep" class="form-select w-auto" name="upperCmmnCode" >
					<c:forEach var="upperDep" items="${upperList}">
						<option value="${upperDep.cmmnCode}" id="upperDepClick">${upperDep.cmmnCodeNm}</option>
					</c:forEach>
				</select>
			</div>
			
			<%-- 부서 선택하면 소속팀 출력 --%>
			<%--
			<div class="form-group col-8" style="margin-left: 15%;">
				<label for="" class="form-label required">소속팀
						<span class="text-danger">*</span>
				</label> 
			    <div class="" id="lowerDepartment">
			    
			    </div>
			</div>
			 --%>
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="cmmnCodeNm" class="form-label required">신규 부서팀명 <span
					class="text-danger">*</span></label> 
					<input type="text" name="cmmnCodeNm" class="form-control" id="cmmnCodeNm" required>
				<div class="invalid-feedback">부서명을 작성하세요.</div>
			</div>
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="cmmnCodeDc" class="form-label required">부서설명
					<span class="text-danger">*</span>
				</label> 
				<input type="text" name="cmmnCodeDc" class="form-control" id="cmmnCodeDc" required>
				<div class="invalid-feedback">부서 설명을 작성하세요.</div>
			</div>
			<div class="content text-center">
				<button type="button" id="insertBtn"
					class="main-btn primary-btn-light square-btn btn-hover btn-sm">확인</button>
			</div>
			<button type="button" class="btn btn-outline-warning d-flex align-items-center gap-1" id="depInsertDataButton">자동입력</button>
		</div>
	</div>
</form>    

<script>

// 체크박스 부서 정보 입력
$(function(){
	$('#depInsertDataButton').on('click' , function(){
		$('#cmmnCodeNm').val('404 팀');
		$('#cmmnCodeDc').val('2024.05.08 신규 팀');
	})
})

</script>

</body>
</html>
