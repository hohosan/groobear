<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="데모" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta
			name="viewport"
			content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
	<c:import url="../layout/prestyle.jsp" />
 
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	
	<section class="section mt-4">
		<div class="container-fluid">
			
			<div class="row mb-4">
				<div class="col-12">
					<div class="card-style">
					  <ul>
						<li>설명</li>
						<li>url => 현재 페이지 정보 (/project/list?currentPage=1&)</li>
						<li>current => 현재 페이지 정보</li>
						<li>total => 최대 페이지 수</li>
						<li>show-max = > 보여주는 페이지 수 (기본 10)</li>
					  </ul>
					  
					  ${articlePage}
					<page-navi
						url="/demo?${articlePage.getSearchVo()}"
						current="${articlePage.getCurrentPage()}"
						show-max="3"
						total="${articlePage.getTotal()}"
					></page-navi>
					  
					  <page-navi
						url="/demo?"
						current="${param.get("currentPage")}"
						show-max="10"
						total="5"></page-navi>
					</div>
				</div>
			</div>
			
			<div class="row mb-4">
				<div class="col-6">
					<div class="card-style">
						<h1>파일 업로드 추가</h1>
						<ul>
							<li>name => 파라미터명 (백에서 받기위한 값)</li>
							<li>label => 파일 업로드 명</li>
							<li>max-files => 최대 추가 가능한 이미지 갯수</li>
							<li>context-path => 이미지 루트 경로 ex)localhost 걍로</li>
							<li>uploaded-file => 업로드 된 파일 목록</li>
							<li>max-files="1" 1을 할당하면 1개만 단일 피일 업로드 로 사용 가능</li>
						</ul>
<%--						${fileAttachList}--%>
						<form action="/fileUpload" method="post" enctype="multipart/form-data">
							<file-upload
									label="메뉴 이미지"
									name="uploadFile"
									max-files="5"
									contextPath="${pageContext.request.contextPath  }"
							></file-upload>
							
							<button type="submit" class="btn btn-primary">전송</button>
						</form>
					
					</div>
				</div>
				
				<div class="col-6">
					<div class="card-style">
						<h1>파일 업로드 수정</h1>
						<%-- <file-upload></file-upload> --%>
						<ul>
							<li>name => 파라미터명 (백에서 받기위한 값)</li>
							<li>label => 파일 업로드 명</li>
							<li>max-files => 최대 추가 가능한 이미지 갯수</li>
							<li>context-path => 이미지 루트 경로 ex)localhost 걍로</li>
							<li>uploaded-file => 업로드 된 파일 목록</li>
							<li>atch-file-no => 수정인 경우 필수로 파일 넘버 넘기기</li>
							<li>max-files="1" 1을 할당하면 1개만 단일 피일 업로드 로 사용 가능</li>
						</ul>
					 
						<form action="/fileUpdate" method="post" enctype="multipart/form-data">
							<file-upload
									label="메뉴 이미지"
									name="uploadFile"
									max-files="5"
									contextPath="${pageContext.request.contextPath  }"
									uploaded-file="${fileAttachList}"
									atch-file-no="1"
							></file-upload>
							
							<button type="submit" class="btn btn-primary">전송</button>
						</form>
					
					</div>
				</div>
				
			</div>
			
			
			<div class="row">
				<div class="col-6">
					<div class="card-style">
						
						<h1>다음 주소 API</h1>
						<div class="mb-4">
							<label for="restaurantAdd1" class="form-label mb-3">주소찾기</label>
							<input type="text" name="restaurantAdd1" class="form-control address-select" id="restaurantAdd1" placeholder="주소를 입력하세요." value="" required="required" >
							<div class="invalid-feedback restaurantAdd1">식당 주소 찾기를 진행해주세요</div>
							<input type="text" name="restaurantAdd2" class="form-control mt-3" id="addressDetail" maxlength="30" placeholder="상세주소를 입력하세요." value="" required="required" >
							<div class="invalid-feedback">상세주소를 입력해주세요</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row mt-5">
				<div class="col-12">
					<div class="card-style">
						<%-- 카드 스타일로 넣어야 뒷 배경이 생긴다--%>
						여기 안에서 작업을 진행하면 됩니다~~~~
						<div>
							<a href="https://demo.plainadmin.com/" target="_blank">템플릿 사이트</a>
							<p>여기 들어가면 우리가 사용한 템플릿 데모 보는게 가능</p>
						</div>
						<div>
							<a href="https://getbootstrap.com/docs/5.3/getting-started/introduction/" target="_blank">
								부트스트랩5 사이트
							</a>
							<p>여기 들어가면 클래스가 어떤 css인지, component 정보도 확인 가능</p>
						</div>
					</div>
				</div>
			</div>
		  
		  <div class="card mt-4">
			<div class="card-header p-3">
			  <h5 class="mb-0">Notifications</h5>
			  <p class="text-sm mb-0">Notifications on this page use Toasts from Bootstrap. Read more details <a href="https://getbootstrap.com/docs/5.0/components/toasts/" target="">here</a>.</p>
			</div>
			<div class="card-body p-3">
			  <div class="row">
				<div class="col-lg-3 col-sm-6 col-12">
				  <button class="btn bg-gradient-success w-100 mb-0 toast-btn" type="button" data-target="successToast">Success</button>
				</div>
				<div class="col-lg-3 col-sm-6 col-12 mt-sm-0 mt-2">
				  <button class="btn bg-gradient-info w-100 mb-0 toast-btn" type="button" data-target="infoToast">Info</button>
				</div>
				<div class="col-lg-3 col-sm-6 col-12 mt-lg-0 mt-2">
				  <button class="btn bg-gradient-warning w-100 mb-0 toast-btn" type="button" data-target="warningToast">Warning</button>
				</div>
				<div class="col-lg-3 col-sm-6 col-12 mt-lg-0 mt-2">
				  <button class="btn bg-gradient-danger w-100 mb-0 toast-btn" type="button" data-target="dangerToast">Danger</button>
				</div>
			  </div>
			</div>
		  </div>
		  
		  
		<div class="toast-container position-fixed end-0 p-3" style="top: 80px">
			<div class="toast fade hide p-2 mt-2 bg-gradient-info" role="alert" aria-live="assertive" id="infoToast" aria-atomic="true">
			  <div class="toast-header bg-transparent border-0">
				<i class="material-symbols-rounded text-white me-2">
				  notifications
				</i>
				<span class="me-auto text-white font-weight-bold">Material Dashboard </span>
				<small class="text-white">11 mins ago</small>
				<i class="fas fa-times text-md text-white ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
			  </div>
			  <hr class="horizontal light m-0">
			  <div class="toast-body text-white">
				Hello, world! This is a notification message.
			  </div>
			</div>
			
			<div class="toast fade hide p-2 mt-2 bg-white" role="alert" aria-live="assertive" id="warningToast" aria-atomic="true">
			  <div class="toast-header border-0">
				<i class="material-symbols-rounded text-warning me-2">
				  travel_explore
				</i>
				<span class="me-auto font-weight-bold">Material Dashboard </span>
				<small class="text-body">11 mins ago</small>
				<i class="fas fa-times text-md ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
			  </div>
			  <hr class="horizontal dark m-0">
			  <div class="toast-body">
				Hello, world! This is a notification message.
			  </div>
			</div>
			
			<div class="toast fade hide p-2 mt-2 bg-white" role="alert" aria-live="assertive" id="dangerToast" aria-atomic="true">
			  <div class="toast-header border-0">
				<i class="material-symbols-rounded text-danger me-2">
				  campaign
				</i>
				<span class="me-auto text-gradient text-danger font-weight-bold">Material Dashboard </span>
				<small class="text-body">11 mins ago</small>
				<i class="fas fa-times text-md ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
			  </div>
			  <hr class="horizontal dark m-0">
			  <div class="toast-body">
				Hello, world! This is a notification message.
			  </div>
			</div>
		  </div>
		
		<%--아이콘 사용--%>
			<div class="row mt-5">
				<div class="col-6">
					<div class="card-style">
						<infinite-scroll
								url="/file/list"
								total="1000"
								last-page="100"
								data-search="">
								<template>
									<%--  div안에 감싸줘야 사용 가능 --%>
									<div class="mb-4">
										<!-- 진짜 화면에 보여지는쪽 -->
									  <div>atchFileNo = > {{atchFileNo}}</div>
									  <div>fileSn = > {{fileSn}}</div>
									  <div>fileStrePath = >
										  <img src="/upload/{{fileStrePath}}" alt="" width="100" height="100">
									  </div>
									  <div>파일명 = > {{fileNm}}</div>
									  <div>파일 저장 명 = > {{fileStreNm}}</div>
									  <div>파일 확장자 = > {{fileExtsn}}</div>
									</div>
								</template>
						</infinite-scroll>
					</div>
				</div>
			</div>
		</div>
	</section>
	<c:import url="../layout/footer.jsp" />
</main>

<c:import url="../layout/prescript.jsp" />

</body>
</html>
