<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="title" scope="application" value="프로젝트 업무 수정" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
  <style>
  .file-action-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 40px;
    height: 36px;
    font-size: 14px;
    padding: 0 10px;
    border-radius: 6px;
    border: 1px solid transparent;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
  }

  .file-action-btn.btn-outline-success {
    color: #198754;
    border-color: #198754;
    background-color: white;
  }

  .file-action-btn.btn-outline-danger {
    color: #dc3545;
    border-color: #dc3545;
    background-color: white;
  }

  .file-action-btn.active-download {
    background-color: #d1ecf1;
    border-color: #0dcaf0;
  }

  .file-action-btn.active-delete {
    background-color: #f8d7da;
    border-color: #dc3545;
  }
</style>
  
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
  <section class="section">
    <div class="container-fluid">
      <div class="row">
        <!-- 좌측 업무 수정 -->
        <div class="col-md-8">
          <div class="card p-4">
            <h4 class="fw-bold mb-3"><i class="fas fa-edit me-2 text-primary"></i>업무 수정</h4>

            <form action="/projectTask/update" method="post" enctype="multipart/form-data">
              <input type="hidden" name="taskNo" value="${task.taskNo}" />
              <input type="hidden" name="prjctNo" value="${task.prjctNo}" />
              <input type="hidden" name="chargerEmpno" id="chargerEmpno" value="${task.chargerEmpno}" />
              <input type="hidden" name="atchFileNo" value="${task.atchFileNo}" />
              
              <!-- 상위 업무 ID 추가 -->
              <input type="hidden" name="upperTaskNo" value="${task.upperTaskNo}" />

				<c:if test="${not empty task.parentTaskNm}">
				  <div class="mb-3">
				    <label class="form-label fw-semibold">상위 업무</label>
				    <input type="text" class="form-control bg-light" value="${task.parentTaskNm}" readonly />
				  </div>
				</c:if>


              <div class="mb-3">
                <label class="form-label fw-semibold">업무명</label>
                <input type="text" name="taskNm" class="form-control" value="${task.taskNm}" required />
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">담당자</label>
                <input type="text" class="form-control bg-light" id="chargerEmpNm" value="${task.chargerEmpNm}" readonly />
              </div>

              <div class="row mb-3">
                <div class="col">
                  <label class="form-label fw-semibold">시작일</label>
                  <input type="date" name="taskBeginDt" class="form-control"
                         value="<fmt:formatDate value='${task.taskBeginDt}' pattern='yyyy-MM-dd'/>" />
                </div>
                <div class="col">
                  <label class="form-label fw-semibold">종료일</label>
                  <input type="date" name="taskEndDt" class="form-control"
                         value="<fmt:formatDate value='${task.taskEndDt}' pattern='yyyy-MM-dd'/>" />
                </div>
              </div>

              <div class="row mb-3">
                <div class="col-md-6">
                  <label class="form-label fw-semibold">중요도</label>
                  <select name="priort" class="form-select">
                    <option value="00" ${task.priort == '00' ? 'selected' : ''}>낮음</option>
                    <option value="01" ${task.priort == '01' ? 'selected' : ''}>보통</option>
                    <option value="02" ${task.priort == '02' ? 'selected' : ''}>높음</option>
                    <option value="03" ${task.priort == '03' ? 'selected' : ''}>긴급</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-semibold">업무 등급</label>
                  <select name="taskGrad" class="form-select">
                    <option value="A" ${task.taskGrad == 'A' ? 'selected' : ''}>A등급</option>
                    <option value="B" ${task.taskGrad == 'B' ? 'selected' : ''}>B등급</option>
                    <option value="C" ${task.taskGrad == 'C' ? 'selected' : ''}>C등급</option>
                    <option value="D" ${task.taskGrad == 'D' ? 'selected' : ''}>D등급</option>
                    <option value="E" ${task.taskGrad == 'E' ? 'selected' : ''}>E등급</option>
                  </select>
                </div>
              </div>

              <!-- 업무 상태와 진행률 -->
              <div class="row mb-3">
                <div class="col-md-6">
                  <label class="form-label fw-semibold">진행률 (%)</label>
                  <input type="number" name="progrsrt" min="0" max="100" class="form-control" value="${task.progrsrt}" />
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-semibold">업무 상태</label>
                  <select name="taskSttus" class="form-select">
                    <option value="00" ${task.taskSttus == '00' ? 'selected' : ''}>대기</option>
                    <option value="01" ${task.taskSttus == '01' ? 'selected' : ''}>진행중</option>
                    <option value="02" ${task.taskSttus == '02' ? 'selected' : ''}>완료</option>
                  </select>
                </div>
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">업무 내용</label>
                <textarea name="taskCn" class="form-control" rows="4">${task.taskCn}</textarea>
              </div>

              <!-- 파일 업로드 -->
              <div class="mb-3">
                <label class="form-label fw-semibold">첨부파일 (최대 5개)</label>
                <input type="file" name="uploadFiles" class="form-control" multiple />
              </div>

              <!-- 기존 파일 리스트 -->
              <c:if test="${not empty task.attachFileList}">
<ul class="list-group mt-2">
  <c:forEach var="file" items="${task.attachFileList}">
    <li class="list-group-item d-flex justify-content-between align-items-center">
      <span><i class="fas fa-file-alt me-2 text-primary"></i>${file.fileNm}</span>
      <div class="d-flex align-items-center gap-2">
        <!-- 다운로드 버튼 -->
        <button type="button" class="file-action-btn btn-outline-success"
                onclick="markDownloaded(this); location.href='/projectTask/download?fileName=${file.fileStrePath}'">
          <i class="fas fa-download"></i>
        </button>

        <!-- 삭제 체크박스 -->
        <label class="file-action-btn btn-outline-danger m-0">
          <input type="checkbox" name="removeFileId" value="${file.fileSn}" class="form-check-input me-1"
                 onclick="toggleDeleteActive(this)">
          삭제
        </label>
      </div>
    </li>
  </c:forEach>
</ul>

              </c:if>

              <!-- 버튼 -->
              <div class="text-end mt-4">
                <button type="submit" class="btn btn-primary">수정 완료</button>
                <a href="/project/projectDetail?prjctNo=${task.prjctNo}" class="btn btn-secondary">취소</a>
              </div>
            </form>
          </div>
        </div>

        <!-- 우측 담당자 선택 -->
        <div class="col-md-4">
          <div class="card p-3 bg-light">
            <h6 class="mb-3 text-primary"><i class="fas fa-user-check me-2"></i>참여자 중에서 담당자 선택</h6>

            <c:if test="${not empty project}">
              <div class="mb-3">
                <span class="badge btn-danger mb-2">책임자</span>
                <div class="d-flex flex-wrap gap-2 small">
                  <c:forEach var="emp" items="${project.responsibleList}">
                    <button type="button" class="btn btn-outline-danger btn-sm text-start text-dark"
                            onclick="selectCharger('${emp.prtcpntEmpno}', '${emp.emplNm}')">
                      ${emp.emplNm}<div class="text-muted small">${emp.posNm}</div>
                    </button>
                  </c:forEach>
                </div>
              </div>

              <div class="mb-3">
                <span class="badge btn-primary mb-2">참여자</span>
                <div class="d-flex flex-wrap gap-2 small">
                  <c:forEach var="emp" items="${project.participantList}">
                    <button type="button" class="btn btn-outline-primary btn-sm text-start text-dark"
                            onclick="selectCharger('${emp.prtcpntEmpno}', '${emp.emplNm}')">
                      ${emp.emplNm}<div class="text-muted small">${emp.posNm}</div>
                    </button>
                  </c:forEach>
                </div>
              </div>

              <div class="mb-3">
                <span class="badge btn-secondary mb-2">참조자</span>
                <div class="d-flex flex-wrap gap-2 small">
                  <c:forEach var="emp" items="${project.observerList}">
                    <button type="button" class="btn btn-outline-secondary btn-sm text-start text-dark"
                            onclick="selectCharger('${emp.prtcpntEmpno}', '${emp.emplNm}')">
                      ${emp.emplNm}<div class="text-muted small">${emp.posNm}</div>
                    </button>
                  </c:forEach>
                </div>
              </div>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>

<script>
  function selectCharger(empNo, empNm) {
    document.getElementById('chargerEmpno').value = empNo;
    document.getElementById('chargerEmpNm').value = empNm;
  }
  
  function markDownloaded(el) {
	    // 기존 활성화 제거
	    document.querySelectorAll('.file-action-btn.btn-outline-success')
	      .forEach(btn => btn.classList.remove('active-download'));
	    
	    // 현재만 활성화
	    el.classList.add('active-download');
	  }

	  function toggleDeleteActive(checkbox) {
	    const label = checkbox.closest('.file-action-btn');
	    label.classList.toggle('active-delete', checkbox.checked);
	  }
</script>
</body>
</html>