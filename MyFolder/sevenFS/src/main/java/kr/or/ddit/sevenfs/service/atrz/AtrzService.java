package kr.or.ddit.sevenfs.service.atrz;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;

public interface AtrzService {
	//기안진행문서 최신순 5개
	public List<AtrzVO> atrzMinSubmitList(String emplNo);
	//기안완료문서 최신순 5개
	public List<AtrzVO> atrzMinCompltedList(String emplNo);
	
	//결재 대기중인 문서리스트
	public List<AtrzVO> atrzApprovalList(Map<String, Object> map);
	// 결재대기문서목록 행의 수
	public int approvalTotal(Map<String, Object> map);
	
	//기안중인 문서리스트
	public List<AtrzVO> atrzSubmitList(String emplNo);
	
	//참조대기문서 목록
	public List<AtrzVO> atrzReferList(Map<String, Object> map);
	//참조대기문서목록 행의 갯수
	public int referTotal(Map<String, Object> map);
	//결재예정문서 목록
	public List<AtrzVO> atrzExpectedList(Map<String, Object> map);
	//결재예정문서목록 행의수
	public int expectedTotal(Map<String, Object> map);
	//결재진행문서
	public List<AtrzVO> atrzAllApprovalList(Map<String, Object> map);
	//결재진행문서 행의수
	public int allApprovalTotal(Map<String, Object> map);
	
	//기안문서함
	public List<AtrzVO> atrzAllSubmitList(Map<String, Object> map);
	//기안문서함 행의수
	public int allSubmitTotal(Map<String, Object> map);
	//임시저장함 
	public List<AtrzVO> atrzStorageList(Map<String, Object> map);
	//임시저장함 행의수
	public int storageTotal(Map<String, Object> map);

	//결재완료함
	public List<AtrzVO> atrzCompletedList(Map<String, Object> map);
	//결재완료함 행의수
	public int completedTotal(Map<String, Object> map);
	
	//반려문서함
	public List<AtrzVO> atrzCompanionList(Map<String, Object> map);
	//반려문서함 행의수
	public int companionTotal(Map<String, Object> map);
	
	//전자결재 테이블 등록
	public int insertAtrz(AtrzVO atrzVO);
	//전자결재선 등록
	public int insertAtrzLine(AtrzLineVO atrzLineVO);
	//연차신청서 등록
	public int insertHoliday(HolidayVO holidayVO);
	//지출결의서 등록
	public int insertSpending(SpendingVO spendingVO);
	//급여계좌변경신청서 등록
	public int insertBankAccount(BankAccountVO bankAccountVO);
	//기안서 등록
	public int insertDraft(DraftVO draftVO);
	
	//전자결재 상세보기
	public AtrzVO getAtrzDetail(String atrzDocNo);
	
	//2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
	public int insertUpdateAtrz(AtrzVO atrzVO);
	//급여명세서 결재선 지정후 제목 내용 일자 상태 업데이트
	public int insertUpdateMyAtrz(AtrzVO atrzVO);
	
	//연차신청서 상세보기
	public HolidayVO holidayDetail(String atrzDocNo);
	//기안문서 상세보기
	public DraftVO draftDetail(String draftNo);
	
	//전자결재 문서 상세보기 결재라인 수정(업데이트) 승인시
	public int atrzDetailAppUpdate(AtrzVO atrzVO);
	
	//전자결재 문서 상세보기 결재라인 수정(업데이트) 반려시
	public int atrzDetilCompUpdate(AtrzVO atrzVO);
	//전자결재 기안취소
	public int atrzCancelUpdate(AtrzVO atrzVO);
	
	//연차신청서 임시저장
	public int atrzHolidayStorage(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, HolidayVO documHolidayVO);
	
	//연차신청서 임시저장후 get
	public AtrzVO getAtrzStorage(String atrzDocNo);
	
	//연차신청서 임시저장후 post보내는것
	public void updateHoliday(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, HolidayVO documHolidayVO) throws Exception;
	//임시저장후 결재선 인서트(업데이트처럼 활용)
	public void updateAtrzLine(AtrzLineVO atrzLineVO);
	
	//연차신청서에서 남은 연차 갯수 가져오기
	public Double readHoCnt(String empNo);
	
	//기안서 임시저장
	public void updateDraft(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, DraftVO draftVO) throws Exception;
	
	
	//반려 문서 재기안 get
	public AtrzVO selectDocumentReturn(String atrzDocNo);
	
	//임시저장함 삭제하기 (일괄삭제 포함)
	public void storageListDelete(List<String> atrzDocNos);
	
	//기안작성중 도중 취소한경우에는 남은 atrz와 atrzLine을 삭제처리해야한다.
	public void deleteAtrzWriting(String atrzDocNo);
	
	
	// home 결재대기문서목록
	public List<AtrzVO> homeAtrzApprovalList(String emplNo);
	public void deleteAtrzLineByDocNo(String atrzDocNo);
	
	//첨부파일 상세보기를 위한것
	public List<AttachFileVO> getAtchFile(long atchFileNo);
	
	//지출결의서 임시저장을 위한것
	public int atrzSpendingStorage(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, SpendingVO spendingVO);
	//지출결의서 상세보기
	public SpendingVO spendingDetail(String atrzDocNo);
	
	//급여명세서 등록
	public void insertSalaryForm(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, SalaryVO salaryVO);
	//급여명세서 상세보기
	public SalaryVO salaryDetail(String atrzDocNo);
	
	//기안서 임시저장
	public int atrzDraftStorage(AtrzVO atrzVO, List<AtrzLineVO> atrzLineList, DraftVO draftVO);

	


	
	
	
}
