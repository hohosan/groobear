<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<style>
.wdBtn {
	--bs-btn-padding-y: .25rem;
	--bs-btn-padding-x: 4rem;
	--bs-btn-font-size: .75rem;
	background-color: pink;
	color: white;
}

.actBtn {
	width: 50px;
	height: 20px;
	font-size: 0.8em;
	padding: 0;
	border: 0;
	text-align: center;
}

.atrzContSc {
	border: 1px solid lightgray;
	border-radius: 10px;
	height: 300px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 10px;
	margin-right: 10px;
	padding: 20px;
	padding-bottom: 50px;
}

.atrzTabCont {
	border: 1px solid lightgray;
	border-radius: 10px;
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
.listCont {
        width: 400px;
        display: block;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;

    }

#contact1-tab-pane {
	padding-bottom: 10px;;
}

#critical {
	padding-left: 4px;
}
.newAtrzDocBtn{
	padding: 0.5rem 1rem; 
	font-size: 0.875rem;
}
.modalBtn{
	padding: 10px 20px;
	font-size: 1.1em;
}
.emptyList{
	padding: 50px 0; 
	font-size: 1.2rem; 
	color: gray;
}

.nav-link.active {
  background-color: rgb(45, 132, 200); /* 원하는 색상으로 변경 */
  color: white; /* 텍스트 색상 */
}

</style>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
<%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
		 	<!-- 여기서 작업 시작 -->
			<div class="col-sm-13" id="divCard">
				<div class="card">
					<div class="card-body">
						<div class="d-flex justify-content-between align-items-center">
							<div id="atrNavBar">
								<ul class="nav nav-pills" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
										<button class="nav-link ${param.tab == null || param.tab == '1' ? 'active' : ''}" id="contact1-tab"
											data-bs-toggle="tab" data-bs-target="#contact1-tab-pane"
											type="button" role="tab" aria-controls="contact1-tab-pane"
											aria-selected="true" onclick="moveTab(1)" >결재대기문서</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link ${param.tab == '2' ? 'active' : ''}" id="contact2-tab"
											data-bs-toggle="tab" data-bs-target="#contact2-tab-pane"
											type="button" role="tab" aria-controls="contact2-tab-pane"
											aria-selected="false" onclick="moveTab(2)">참조대기문서</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link ${param.tab == '3' ? 'active' : ''}" id="contact3-tab"
											data-bs-toggle="tab" data-bs-target="#contact3-tab-pane"
											type="button" role="tab" aria-controls="contact3-tab-pane"
											aria-selected="false" onclick="moveTab(3)">결재예정문서</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link ${param.tab == '4' ? 'active' : ''}" id="contact4-tab"
											data-bs-toggle="tab" data-bs-target="#contact4-tab-pane"
											type="button" role="tab" aria-controls="contact4-tab-pane"
											aria-selected="false" onclick="moveTab(4)">결재진행문서</button>
									</li>
								</ul>
							</div>                           
							<!-- 오른쪽: 검색창 -->
							<div class="table_search d-flex align-items-center gap-2">
								<button type="button" id="s_eap_btn" class="main-btn active-btn rounded-full btn-hover newAtrzDocBtn"
									data-bs-toggle="modal" data-bs-target="#newAtrzDocModal">
									새 결재 진행</button>
									<form id="searchForm" method="get" action="/atrz/approval" class="d-flex gap-2">
										<input type="hidden" name="currentPage" id="currentPage" value="${param.currentPage}" />
										<input type="hidden" name="tab" id="tab" value="${param.tab}" />
										<input type="hidden" name="duration" value="${param.duration}" />
									<select id="duration" class="form-select w-auto">
									<option value="all" <c:if test="${param.duration == 'all'}">selected</c:if>>전체기간</option>
									<option value="1" <c:if test="${param.duration == '1'}">selected</c:if>>1개월</option>
									<option value="6" <c:if test="${param.duration == '6'}">selected</c:if>>6개월</option>
									<option value="12" <c:if test="${param.duration == '12'}">selected</c:if>>1년</option>
									<option value="period" <c:if test="${param.duration == 'period'}">selected</c:if>>기간입력</option>
								</select>
								<div id="durationPeriod" class="search_option d-none align-items-center">
									<input id="fromDate" name="fromDate" value="${param.fromDate}" class="form-control" type="text" style="width: 150px;"> ~ 
									<input id="toDate" name="toDate" value="${param.toDate}"  class="form-control" type="text" style="width: 150px;">
								</div>
								<!-- 검색 유형 선택 -->
								<select id="searchType" name="searchType" class="form-select w-auto">
									<option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
									<option value="drafterName" ${param.searchType == 'drafterName' ? 'selected' : ''}>기안자</option>
									<option value="drafterDeptName" ${param.searchType == 'drafterDeptName' ? 'selected' : ''}>기안부서</option>
									<option value="formName" ${param.searchType == 'formName' ? 'selected' : ''}>결재양식</option>
								</select>
								<section class="search2">
									<div class="search_wrap d-flex align-items-center border rounded px-2">
										<!--focus되면 "search_focus" multi class로 추가해주세요.-->
										<input id="keyword" class="form-control border-0" type="text" name="keyword" value="${param.keyword}" placeholder="검색"> 
										<button type="button" id="searchBtn" class="border-0 bg-transparent">
											<span class="material-symbols-outlined">search</span>
										</button>
									</div>
					</form>
								</section>
							</div>
						</div>
					</div>
					<!-- <p>결재하기</p> -->
					<!-- <p>${atrzVOList}</p> -->
					<!-- 메뉴바 시작 -->
				<!-- 메뉴바 끝 -->
				<!-- 컨텐츠1 시작 -->

				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade ${param.tab == null || param.tab == '1' ? 'show active' : ''}" id="contact1-tab-pane"
						role="tabpanel" aria-labelledby="contact1-tab" tabindex="0">
						<!-- <div id="critical">
							<a class="btn" data-bs-toggle="modal"
								data-bs-target="#allApproval"> <span
								class="material-symbols-outlined">data_check</span> <span
								class="txt">일괄결재</span>
							</a>
						</div> -->

						<div class="atrzTabCont">
							<!-- <div class="container mt-4"> -->
							<div class="row">
								<div class="col-lg-12">
									<div class="card-style">
										<div class="d-flex justify-content-between align-items-center mb-3">
											<h6 class="mb-0">결재대기문서</h6>
											<p class="mb-0 text-sm text-muted">총 ${approvalTotal}건</p>
										</div>
										<div class="table-wrapper table-responsive">
											<c:choose>
												<c:when test="${empty approvalArticlePage.content}">
													<div class="text-center emptyList" >
														결재 대기중인 문서가 없습니다.
													</div>
												</c:when>
												<c:otherwise>
													<table class="table striped-table">
														<thead>
															<tr>
																<!-- select박스 -->
																<!-- <th class="text-center" style="padding-top: 10px; padding-bottom: 10px;">
																	<input class="form-check-input" type="checkbox" id="checkbox-all">
																</th> -->
																<th class="text-center">
																	<h6 class="fw-bolder">기안일</h6>
																</th>
																<th>
																</th>
																<th style="text-align:left;">
																	<h6 class="fw-bolder">제목</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">기안부서</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">기안자</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">결재상태</h6>
																</th>
															</tr>
														</thead>
														<tbody>
															<!-- forEach var="atrzVO" items="달러{atrzApprovalList}">
															ArticlePage<AtrzVO> approvalArticlePage = new ArticlePage<AtrzVO>(approvalTotal, currentPage, size, atrzApprovalList, keyword);	
															-->
															<c:forEach var="atrzVO" items="${approvalArticlePage.content}">
																<tr>
																	<!-- <td class="text-center">
																		<div class="check-input-primary">
																			<input class="form-check-input" type="checkbox"
																				id="checkbox-1">
																		</div>
																	</td> -->
																	<td class="text-center">
																		<p class="text-sm fw-bolder">
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
																			<b>${onlyDate}</b>&nbsp;&nbsp;&nbsp;&nbsp; </p>
																	</td>
																	<td style="text-align: right;">
																		<c:choose>
																			<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																				<span class="material-symbols-outlined" style="font-size: 14px;">
																					attach_file
																				</span>
																			</c:when>
																			<c:otherwise>
																				<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																					attach_file
																				</span>
																			</c:otherwise>
																		</c:choose>
																	</td>
																	<td style="text-align:left;">
																		<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" >
																			${atrzVO.atrzSj}
																		</a>
																	</td>
																	<td class="text-center">
																		<p>${atrzVO.deptCodeNm}</p>
																	</td>
																	<td class="text-center">
																		<p>${atrzVO.drafterEmpnm}</p>
																	</td>
																	<td class="text-center">
																		<p>
																			<c:choose>
																				<c:when test="${atrzVO.atrzSttusCode == '00' }">
																					<span class="status-btn close-btn actBtn col-sm-6 col-md-4" style="background-color: #fbf5b1; color: #dd9e5f;">진행중</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '10' }">
																					<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '20' }">
																					<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '30' }">
																					<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '40' }">
																					<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4" style="background-color: pink; color: #ed268a;">취소</span>
																				</c:when>
																				<c:otherwise>
																					<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4">임시저장</span>
																				</c:otherwise>
																			</c:choose>
																		</p>
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
													<div style="margin-top: 20px;">
														<!-- 페이지네이션 시작 -->
														<c:if test="${approvalArticlePage.totalPages > 1}">
															${approvalArticlePage.pagingArea}
														</c:if>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							<!-- </div> -->
							<!--기안진행 문서 끝-->
							<!-- 기안 완료 문서 시작 -->
						</div>
					</div>
				</div>
				<!-- 컨텐츠1 끝 -->

				<!-- 컨텐츠2(참조대기문서) 시작 -->
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade ${param.tab == '2' ? 'show active' : ''}" id="contact2-tab-pane" role="tabpanel"
						aria-labelledby="contact2-tab" tabindex="0">
						<div class="atrzTabCont">
							<!--참조대기문서 시작-->
							<div class="row">
								<div class="col-lg-12">
									<div class="card-style">
										<div class="d-flex justify-content-between align-items-center mb-3">
											<h6 class="mb-10">참조대기문서</h6>
											<p class="mb-0 text-sm text-muted">총 ${referTotal}건</p>
										</div>
										<div class="table-wrapper table-responsive">
											<c:choose>
												<c:when test="${empty referArticlePage.content}">
													<div class="text-center py-5">
														<div class="text-center emptyList">
															참조 대기중인 문서가 없습니다.
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<table class="table striped-table">
														<thead>
															<tr>
																<th class="text-center">
																	<h6 class="fw-bolder">기안일</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">완료일</h6>
																</th>
																<th style="text-align:left;">
																	<h6 class="fw-bolder">결재양식</h6>
																</th>
																<th></th>
																<th style="text-align:left;">
																	<h6 class="fw-bolder">제목</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">기안자</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">문서번호</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">결재상태</h6>
																</th>
															</tr>
														</thead>
														<tbody>
															<!-- <p>${referArticlePage.content}</p> -->
															<c:forEach var="atrzVO" items="${referArticlePage.content}">
																<tr>
																	<td class="text-center">
																		<p class="text-sm fw-bolder">
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
																			
																			${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;</p></p>
																	</td>
																	<td class="text-center">
																		<p class="text-sm fw-bolder">
																			<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																			<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="HH:mm:ss" var="onlyTime" />
																			${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;</p></p>
																	</td>
																	<td class="text-center">
																		<p style="text-align:left;">
																			<c:choose>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
																				<c:otherwise>퇴사신청서</c:otherwise>
																			</c:choose>
																		</p>
																	</td>
																	<td style="text-align: right;">
																		<c:choose>
																			<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																				<span class="material-symbols-outlined" style="font-size: 14px;">
																					attach_file
																				</span>
																			</c:when>
																			<c:otherwise>
																				<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																					attach_file
																				</span>
																			</c:otherwise>
																		</c:choose>
																	</td>
																	<td style="text-align:left;">
																		<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																			${atrzVO.atrzSj}
																		</a>
																	</td>
																	<td class="text-center">
																		<p>${atrzVO.drafterEmpnm}</p>
																	</td>
																	<td class="text-center">
																		<p>${atrzVO.atrzDocNo}</p>
																	</td>
																	<td class="text-center">
																		<h6 class="text-sm">
																			<p>
																				<c:choose>
																					<c:when test="${atrzVO.atrzSttusCode == '00' }">
																						<span class="status-btn close-btn actBtn col-sm-6 col-md-4" style="background-color: #fbf5b1; color: #dd9e5f;">진행중</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '10' }">
																						<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '20' }">
																						<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '30' }">
																						<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '40' }">
																						<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4" style="background-color: pink; color: #ed268a;">취소</span>
																					</c:when>
																					<c:otherwise>
																						<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4">임시저장</span>
																					</c:otherwise>
																				</c:choose>
																			</p>
																		</h6>
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
													<div style="margin-top: 20px;">
														<!-- 페이지네이션 시작 -->
														<c:if test="${referArticlePage.totalPages > 1}">
															${referArticlePage.pagingArea}
														</c:if>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							<!--참조대기문서 끝-->
						</div>
					</div>
				</div>
				<!-- 컨텐츠2 끝 -->
				<!-- 컨텐츠3(결재예정문서) 시작 -->
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade ${param.tab == '3' ? 'show active' : ''}" id="contact3-tab-pane" role="tabpanel"
						aria-labelledby="contact3-tab" tabindex="0">
						<div class="atrzTabCont">
							<!--결재예정문서 시작-->
							<div class="row">
								<div class="col-lg-12">
									<div class="card-style">
										<div class="d-flex justify-content-between align-items-center mb-3">
											<h6 class="mb-10">결재예정문서</h6>
											<p class="mb-0 text-sm text-muted">총 ${expectedTotal}건</p>
										</div>
										<div class="table-wrapper table-responsive">
											<c:choose>
												<c:when test="${empty expectedArticlePage.content}">
													<div class="text-center py-5">
														<div class="text-center emptyList">
															결재 예정인 문서가 없습니다.
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<table class="table striped-table">
														<thead>
															<tr>
																<th class="text-center">
																	<h6 class="fw-bolder">기안일</h6>
																</th>
																<th style="text-align: left;">
																	<h6 class="fw-bolder">결재양식</h6>
																</th>
																<th></th>
																<th style="text-align: left;">
																	<h6 class="fw-bolder">제목</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">기안자</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">결재상태</h6>
																</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="atrzVO" items="${expectedArticlePage.content}">
																<tr>
																	<td class="text-center">
																		<p class="text-sm fw-bolder">
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
																			${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;</p></p>
																	</td>
																	<td style="text-align:left;">
																		<p>
																			<c:choose>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
																				<c:otherwise>퇴사신청서</c:otherwise>
																			</c:choose>
																		</p>
																	</td>
																	<td style="text-align: right;">
																		<c:choose>
																			<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																				<span class="material-symbols-outlined" style="font-size: 14px;">
																					attach_file
																				</span>
																			</c:when>
																			<c:otherwise>
																				<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																					attach_file
																				</span>
																			</c:otherwise>
																		</c:choose>
																	</td>
																	<td style="text-align:left;">
																		<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																			${atrzVO.atrzSj}
																		</a>
																	</td>
																	<td class="text-center">
																		<p>${atrzVO.drafterEmpnm}</p>
																	</td>
																	<td class="text-center">
																		<h6 class="text-sm">
																			<p>
																				<c:choose>
																					<c:when test="${atrzVO.atrzSttusCode == '00' }">
																						<span class="status-btn close-btn actBtn col-sm-6 col-md-4" style="background-color: #fbf5b1; color: #dd9e5f;">진행중</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '10' }">
																						<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '20' }">
																						<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '30' }">
																						<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																					</c:when>
																					<c:when test="${atrzVO.atrzSttusCode == '40' }">
																						<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4" style="background-color: pink; color: #ed268a;">취소</span>
																					</c:when>
																					<c:otherwise>
																						<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4">임시저장</span>
																					</c:otherwise>
																				</c:choose>
																			</p>
																		</h6>
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
													<div style="margin-top: 20px;">
														<!-- 페이지네이션 시작 -->
														<c:if test="${expectedArticlePage.totalPages > 1}">
															${expectedArticlePage.pagingArea}
														</c:if>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							<!--결재예정문서 끝-->
						</div>
					</div>
				</div>
				<!-- 컨텐츠3(결재예정문서) 끝 -->
				<!-- 컨텐츠4 시작 -->
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade ${param.tab == '4' ? 'show active' : ''}" id="contact4-tab-pane" role="tabpanel"
						aria-labelledby="contact4-tab" tabindex="0">
						<div class="atrzTabCont">
							<div class="row">
								<div class="col-lg-12">
									<div class="card-style">
										<div class="d-flex justify-content-between align-items-center mb-3">
											<h6 class="mb-10">결재진행문서</h6>
											<p class="mb-0 text-sm text-muted">총 ${allApprovalTotal}건</p>
										</div>
										<div class="table-wrapper table-responsive">
											<c:choose>
												<c:when test="${empty allApprovalArticlePage.content}">
													<div class="text-center emptyList" >
														결재 진행문서에 문서가 없습니다.
													</div>
												</c:when>
												<c:otherwise>
													<table class="table striped-table">
														<thead>
															<tr>
																<!-- select박스 -->
																
																<th>
																	<h6 class="fw-bolder">결재양식</h6>
																</th>
																<th></th>
																<th>
																	<h6 class="fw-bolder">제목</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">기안자</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">문서번호</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">기안일</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">완료(반려)일</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">결재상태</h6>
																</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="atrzVO" items="${allApprovalArticlePage.content}">
																<tr>
																	<td>
																		<p>
																			<c:choose>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
																				<c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
																				<c:otherwise>퇴사신청서</c:otherwise>
																			</c:choose>
																		</p>
																	</td>
																	<td style="text-align: right;">
																		<c:choose>
																			<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																				<span class="material-symbols-outlined" style="font-size: 14px;">
																					attach_file
																				</span>
																			</c:when>
																			<c:otherwise>
																				<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																					attach_file
																				</span>
																			</c:otherwise>
																		</c:choose>
																	</td>
																	<td style="text-align:left;">
																		<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																			${atrzVO.atrzSj}
																		</a>
																	</td>
																	<td class="text-center">
																		<p>${atrzVO.drafterEmpnm}</p>
																	</td>
																	<td class="text-center">
																		<p>${atrzVO.atrzDocNo}</p>
																	</td>
																	<td class="text-center">
																		<p class="fw-bolder">
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																			<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
																			${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;
																		</p>
																	</td>
																	<td class="text-center">
																		<p class="fw-bolder">
																			<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																			<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="HH:mm:ss" var="onlyTime" />
																			${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp;
																		</p>
																	</td>
																	<td class="text-center">
																		<p>
																			<c:choose>
																				<c:when test="${atrzVO.atrzSttusCode == '00' }">
																					<span
																						class="status-btn close-btn actBtn col-sm-6 col-md-4"
																						style="background-color: #fbf5b1; color: #dd9e5f;">진행중</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '10' }">
																					<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '20' }">
																					<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '30' }">
																					<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																				</c:when>
																				<c:otherwise>
																					<span
																						class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
																						style="background-color: pink; color: #ed268a;">취소</span>
																				</c:otherwise>
																			</c:choose>
																		</p>
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
													<div style="margin-top: 20px;">
														<!-- 페이지네이션 시작 -->
														<c:if test="${allApprovalArticlePage.totalPages > 1}">
															${allApprovalArticlePage.pagingArea}
														</c:if>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							<!--결재문서함 끝-->
						</div>
					</div>
				</div>
				<!-- 컨텐츠4 끝 -->
			</div>
		</div>
	</div>
</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
<!-- jquery 사용시 여기 이후 작성하기 -->
<!-- 새결재 진행 모달import -->
<c:import url="newAtrzDocModal.jsp" />
<script>
// 검색어 입력시 엔터키로 검색하기
// 한 이벤트에 긴코드가 들어갈때 나누서 사용하기 위해서~

document.addEventListener("DOMContentLoaded", function () {
	const input = document.getElementById("keyword");
	const searchBtn = document.getElementById("searchBtn");

	input.addEventListener("keydown", function (event) {
		if (event.key === "Enter") {
		event.preventDefault(); // form 제출 방지 (필요한 경우)
		searchBtn.click(); // 버튼 클릭 트리거
		}
	});
});


function moveTab(tabNo) {
		const form = document.createElement('form');
		form.method = 'get';
		form.action = '/atrz/approval'; // 당신 검색 요청 URL

		const tabInput = document.createElement('input');
		tabInput.type = 'hidden';
		tabInput.name = 'tab';
		tabInput.value = tabNo;
		form.appendChild(tabInput);

		// 검색조건 초기화
		const searchInputs = ['searchType', 'keyword', 'duration', 'fromDate', 'toDate'];
		searchInputs.forEach(name => {
			const input = document.createElement('input');
			input.type = 'hidden';
			input.name = name;
			input.value = ''; // 초기화
			form.appendChild(input);
		});

		document.body.appendChild(form);
		form.submit();
	};


// 검색 후 기간입력이 선택되어 있을 경우 기간입력 div를 보여줌
$(document).ready(function() {
	let duration = $("#duration option:selected").val();
	console.log("duration : ", duration);

	if (duration == "period") {//기간입력 선택 시
		$("#durationPeriod").removeClass("d-none").addClass("d-flex");
	} else {
		$("#durationPeriod").removeClass("d-flex").addClass("d-none");
	}

	// 체크박스 전체 선택
	$("#checkbox-all").click(function() {
		if ($(this).is(":checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
});

//기간입력 선택시 활성화 시키는 스크립트
document.getElementById("duration").addEventListener("change",function() {
	//기간입력 선택시 활성화 시키는 스크립트
	var durationPeriod = document.getElementById("durationPeriod");
	console.log("duration : ",this.value);
	if (this.value == "period") {
		durationPeriod.classList.remove("d-none");
		durationPeriod.classList.add("d-flex");
	} else {
		durationPeriod.classList.remove("d-flex");
		durationPeriod.classList.add("d-none");
	}
});
//검색버튼 클릭시 컨트롤러로 파라이터 넘겨주기
$('#searchBtn').on("click",function(event){
	event.preventDefault(); // 기본 동작 방지

	const keyword = $('#keyword').val();
	const searchType = $('#searchType').val();
	const duration = $('#duration').val();
	const fromDate = $('#fromDate').val();
	const toDate = $('#toDate').val();
	let tab = "${param.tab}";

	if(tab == null || tab == ""){
		tab = "1";
	}

	console.log("keyword : ", keyword);//계란
	console.log("searchType : ", searchType);//title
	console.log("duration : ", duration);//period
	console.log("fromDate : ", fromDate);//2025-04-22
	console.log("toDate : ", toDate);//2025-04-22

	let url = `/atrz/approval?tab=\${tab}&keyword=\${encodeURIComponent(keyword)}&searchType=\${searchType}&duration=\${duration}`;
    if (duration === "period") {
        url += `&fromDate=\${fromDate}&toDate=\${toDate}`;
    }
	console.log("url : ", url);

	location.href = url;
});

</script>
	<!--일괄결재모달 시작-->
	<div class="modal fade" id="allApproval" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form>
						<div class="mt-1 mb-3">
							<h4 class="form-label">정말로 일괄 결재하시겠습니까?</h4>
						</div>
						<div class="mb-3">
							<textarea class="form-control" id="message-text"
								style="height: 200px" placeholder="의견을 작성해주세요"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer border-0">
					<button type="button" class="main-btn primary-btn rounded-full btn-hover modalBtn">확인</button>
					<button type="button" class="main-btn light-btn rounded-full btn-hover modalBtn"
						data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!--일괄결재모달 끝-->
</body>
</html>
