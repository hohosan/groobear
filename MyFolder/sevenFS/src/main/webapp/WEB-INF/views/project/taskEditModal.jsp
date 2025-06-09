<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 업무 수정 모달 -->
<div class="modal fade" id="taskEditModal" tabindex="-1" aria-labelledby="taskEditModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <form id="taskEditForm" method="post" enctype="multipart/form-data" action="/projectTask/update">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title" id="taskEditModalLabel"><i class="fas fa-edit me-2"></i>업무 수정</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="닫기"></button>
        </div>
        <div class="modal-body">

          <input type="hidden" name="taskNo" value="${task.taskNo}" />
          <input type="hidden" name="prjctNo" value="${task.prjctNo}" />
          <input type="hidden" name="atchFileNo" value="${task.atchFileNo}" />
          <input type="hidden" name="source" value="gantt" />
          
          <!-- 중요: 상위 업무 ID 추가 -->
          <input type="hidden" name="upperTaskNo" value="${task.upperTaskNo}" />
          

          <c:if test="${not empty task.parentTaskNm}">
            <div class="mb-2">
              <label class="form-label fw-semibold text-muted">상위 업무</label>
              <div class="form-control bg-light">${task.parentTaskNm}</div>
            </div>
          </c:if>

          <div class="mb-3">
            <label class="form-label fw-semibold">업무명</label>
            <input type="text" name="taskNm" class="form-control" value="${task.taskNm}" required />
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">담당자</label>
            <select name="chargerEmpno" class="form-select">
<c:forEach var="emp" items="${project.responsibleList}">
  <option value="${emp.prtcpntEmpno}" ${emp.prtcpntEmpno == task.chargerEmpno ? 'selected' : ''}>${emp.emplNm} (${emp.posNm})</option>
</c:forEach>
<c:forEach var="emp" items="${project.participantList}">
  <option value="${emp.prtcpntEmpno}" ${emp.prtcpntEmpno == task.chargerEmpno ? 'selected' : ''}>${emp.emplNm} (${emp.posNm})</option>
</c:forEach>
<c:forEach var="emp" items="${project.observerList}">
  <option value="${emp.prtcpntEmpno}" ${emp.prtcpntEmpno == task.chargerEmpno ? 'selected' : ''}>${emp.emplNm} (${emp.posNm})</option>
</c:forEach>
            </select>
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

          <div class="mb-3">
            <label class="form-label fw-semibold">첨부파일</label>
            <input type="file" name="uploadFiles" class="form-control" multiple />
          </div>

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


        </div>
        <div class="modal-footer">
          <button type="button" id="submitEditTaskBtn" class="btn btn-primary">수정 완료</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </form>
    </div>
  </div>
</div>


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
    border: 1px solid #198754;
    background-color: white;
  }

  .file-action-btn.btn-outline-danger {
    color: #dc3545;
    border: 1px solid #dc3545;
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


<script>
// IIFE 패턴에서 즉시 실행 함수로 변경하여 중복 바인딩 방지
document.addEventListener("DOMContentLoaded", function() {
  setupModalHandler();
});

// 모달 핸들러 설정 함수 - 중복 바인딩 방지
let isHandlerAttached = false;
function setupModalHandler() {
  if (isHandlerAttached) return;
  
  const submitBtn = document.getElementById("submitEditTaskBtn");
  if (!submitBtn) {
    console.error("❌ 수정 버튼이 존재하지 않음");
    return;
  }

  submitBtn.addEventListener("click", function () {
    const form = document.getElementById("taskEditForm");
    if (!form) {
      console.error("❌ 폼이 존재하지 않음");
      return;
    }

    const formData = new FormData(form);
    
    // 이미 source 필드가 있는지 확인
    if (!formData.has("source")) {
      formData.append("source", "gantt");
    }

    fetch("/projectTask/update", {
      method: "POST",
      body: formData
    })
      .then(res => {
        if (!res.ok) {
          throw new Error("서버 응답 오류: " + res.status);
        }
        return res.text();
      })
      .then(() => {
        const modal = bootstrap.Modal.getInstance(document.getElementById("taskEditModal"));
        if (modal) modal.hide();
        if (typeof loadGanttData === "function") loadGanttData();

        swal("수정 완료!", "업무가 성공적으로 수정되었습니다.", "success");
      })
      .catch(err => {
        console.error("❌ 업무 수정 실패:", err);
        swal("수정 실패", "오류가 발생했습니다.\n" + err.message, "error");
      });
  });
  
  isHandlerAttached = true;
  console.log("✅ 모달 핸들러 설정 완료");
}

function markDownloaded(el) {
    // 다운로드된 항목 외에는 비활성화
    document.querySelectorAll('.file-action-btn.btn-outline-success')
      .forEach(btn => btn.classList.remove('active-download'));
    
    el.classList.add('active-download');
  }

  function toggleDeleteActive(checkbox) {
    const label = checkbox.closest('.file-action-btn');
    label.classList.toggle('active-delete', checkbox.checked);
  }
</script>