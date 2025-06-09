package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;

import lombok.Data;

@Data
public class ProjectEmpVO {
	private int prjctNo;
	private String prtcpntEmpno;
	private String prtcpntRole;
	private String prjctAuthor = "0000";      // 기본값
	private String evlManEmpno;              // 기본은 자기 자신
	private String evlCn = "";               // 평가 내용 기본값
	private String evlGrad = "1";            // 기본 등급
	private Date evlWritngDt;                // SYSDATE로 설정
	private Date evlUpdtDt;
	private String secsnYn = "N";            // 참여 상태
	private String EmpNm;
	private String emplNm;   
	private String deptNm;   // 부서명 등도 같이 쓰고 있다면 같이 추가
	private String posNm;    // 직급명 등도 같이 쓰고 있다면 같이 추가
	private String telno;
	private String email;
}
