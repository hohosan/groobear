<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="card-style chat-about h-100">
   <h6 class="text-sm text-medium"></h6>
   <div class="chat-about-profile">
     <div class="content text-center">
       <h5 class="text-bold mb-10"></h5>
       <span class="status-btn info-btn">${empDetail.posNm}</span>
       <span class="status-btn info-btn">${empDetail.deptNm}</span>
     </div>
   </div>
   <div class="activity-meta text-start" style="margin-top: 20px;">
     <ul>
       <li class="row">
         <span class="col-4" >사원명</span>
         <c:set var="day" value=""></c:set>
         <span class="col-8 text-medium text-dark">${year}.${month}.${day}</span>
       </li>
       <li class="row">
         <span class="col-4" >직급</span>
         <c:set var="day" value=""></c:set>
         <span class="col-8 text-medium text-dark">${year}.${month}.${day}</span>
       </li>
       <li class="row">
         <span class="col-4" >소속부서</span>
         <c:set var="day" value=""></c:set>
         <span class="col-8 text-medium text-dark">${year}.${month}.${day}</span>
       </li>
       <li class="row">
         <span class="col-4" >입사일자</span>
         <c:set var="year" value="${empDetail.ecnyDate.substring(0,4)}"></c:set>
         <c:set var="month" value="${empDetail.ecnyDate.substring(4,6)}"></c:set>
         <c:set var="day" value="${empDetail.ecnyDate.substring(6,8)}"></c:set>
         <span class="col-8 text-medium text-dark">${year}.${month}.${day}</span>
       </li>
       <hr>
       <li class="row">
         <span class="col-4">이메일</span>
         <span class="col-8 text-medium text-dark">${empDetail.email}</span>
       </li>
       <hr>
       <li class="row">
         <span class="col-4">전화번호</span>
         <c:set var="telno1" value="${empDetail.telno.substring(0,3)}"></c:set>
         <c:set var="telno2" value="${empDetail.telno.substring(3,7)}"></c:set>
         <c:set var="telno3" value="${empDetail.telno.substring(7,11)}"></c:set>
         <span class="col-8 text-medium text-dark">${telno1}-${telno2}-${telno3}</span>
       </li>
       <hr>
       <li class="row">
         <span class="col-4">생년월일</span>
         <c:set var="year" value="${empDetail.brthdy.substring(0,4)}"></c:set>
         <c:set var="month" value="${empDetail.brthdy.substring(4,6)}"></c:set>
         <c:set var="day" value="${empDetail.brthdy.substring(6,8)}"></c:set>
         <span class="col-8 text-medium text-dark">${year}.${month}.${day}</span>
       </li>
       <hr>
       <li class="row">
         <span class="col-4">성별</span>
         <span class="col-8 text-medium text-dark">${empDetail.genderCode}</span>
         <select id="duration" class="form-select w-auto" name="upperCmmnCode">
				<option value="#">없음</option>
			<c:forEach var="departList" items="${depList}">
				<option value="00">남성</option>
				<option value="01">여성</option>
			</c:forEach>
		</select>
       </li>
       <hr>
       <li class="row">
         <span class="col-4">주소</span>
         <span class="col-8 text-medium text-dark">${empDetail.adres}</span>
         <span class="col-8 text-medium text-dark">${empDetail.detailAdres}</span>
       </li>
     </ul>
   </div>
   <div class="profile-info">
     <ul>
       <li>
       <hr>
       <span class="status-btn info-bg text-white">특이사항</span>
       <c:choose>
		    <c:when test="${empDetail.partclrMatter != null}">
		         <div style="margin-top: 20px;" class="text-medium text-dark">${empDetail.partclrMatter}</div>
		    </c:when>
		    <c:otherwise>
		        <p style="margin-top: 20px;">특이사항이 없습니다.</p>
		    </c:otherwise>
		</c:choose>
       </li>
     </ul>
     
     <!-- 로그인한 계정과 사원번호가 일치할경우에만 보이게 -->
     <sec:authentication property="principal.empVO" var="emp" />
     	<c:if test="${emp.emplNo == empDetail.emplNo}">
		     <div class="content text-center" style="margin-top: 40px;">
			     <a href="/emplUpdate?emplNo=${empDetail.emplNo}" class="main-btn success-btn-light square-btn btn-hover btn-sm">수정</a>
			     <button id="deptDeleteBtn" type="button" class="main-btn danger-btn-light square-btn btn-hover btn-sm">삭제</button>
		     </div>
	     </c:if>
   </div>
</div>       

