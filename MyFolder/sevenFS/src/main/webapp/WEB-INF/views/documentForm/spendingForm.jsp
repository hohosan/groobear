<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>지출결의서 양식</title> -->
<style>
.s_frm_title {
	font-size: 1em;
	font-weight: bold;
	padding: 5px 0;
}

.s_div_container {
	overflow: auto;
}

#s_eap_draft_info tr th {
	width: 100px;
}

#s_eap_draft_info tr th, #s_eap_draft_info tr td,
#s_eap_draft tr th, #s_eap_draft tr td,
.s_eap_draft_app tr th, .s_eap_draft_app tr td
	{
	padding: 5px;
	border: 1px solid;
	font-size: .9em;
}

#s_eap_draft td, .s_eap_draft_app td {
	width: 100px;
	text-align: center;
}

#s_eap_draft_info tr th,
#s_eap_draft tr th,
.s_eap_draft_app tr th {
	background-color: gainsboro;
	text-align: center;
	
}

#s_eap_draft tr th,
.s_eap_draft_app tr th {
	width: 50px;
}
/* 셀 내부 여백 주기 */
.s_default_tbody_cl td,
.s_default_tbody_cl th {
padding: 5px !important;
}
.s_sp_date {
	text-align: center;
}
	
</style>
</head>
<body>

	<div class="s_div_container" style="height: 730px;">
		<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">지출결의서</div>
		<div style="padding: 50px 10px 20px; clear: both;">
			<div style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목 : </div> 
			<input type="text" class="form-control" style="display: inline-block; width: 583px; margin-left: 5px;" disabled>
		</div>
		
		<div style="border: 1px solid lightgray; margin: 10px;"></div>
		<div style="margin: 0 10px;">
		
			<div style="padding: 10px 0;">
				<div class="s_frm_title"><b>지출 내용</b></div>
				<textarea class="form-control" style="resize: none;" disabled></textarea>
			</div>
			
			<div style="padding: 10px 0;">
				<div class="s_frm_title"><b>지출 내역</b></div>
				<table class="table" style="text-align: center;">
				  <thead>
				    <tr>
				      <th scope="col" style="width: 130px;">날짜</th>
				      <th scope="col" style="width: 300px;">내역</th>
				      <th scope="col" style="width: 70px;">수량</th>
				      <th scope="col" style="width: 150px;">금액</th>
				      <th scope="col" style="width: 170px;">결제수단</th>
				    </tr>
				  </thead>
				  <tbody id="s_default_tbody" class="s_default_tbody_cl">
				    <tr>
				      <th scope="row"><input type="date" class="form-control" name="sp_date" disabled></th>
				      <td><input type="text" class="form-control" name="sp_detail" disabled></td>
				      <td><input type="number" class="form-control" disabled></td>
				      <td><input type="text" class="form-control" disabled></td>
				      <td>
				      	<select class="form-select" aria-label="Default select example" disabled="disabled">
				      		<option value="c">신용카드</option>
				      		<option value="a">가상계좌</option>
				      	</select>
				      </td>
				    </tr>
				    
				    </tbody>
				    <tfoot>
				    <tr>
				    	<th colspan="3">합계</th>
				      	<td colspan="2">\ <span></span> (VAT 포함)</td>
				    </tr>
				    </tfoot>
				</table>
				<!-- <button id="s_add_sp_detail" class="btn btn-success" onclick="addTr()">내역 추가</button> -->
			</div>
			<div style="padding: 10px 0;">
				<div class="s_frm_title">파일첨부</div>
				<div class="input-group mb-3">
					<div class="file-container text-truncate">
					
					<label class="d-flex text-start input-group-text file-label">파일을 선택해주세요</label><input disabled="" type="file" class="form-control file-input">
					</div>
					<button type="button" class="btn btn-danger removeFileBtn">삭제</button>
				</div>
				<input type="hidden" name="fileUrl" id="fileUrl">
			</div>
			
		</div>
	</div>
</body>
</html>