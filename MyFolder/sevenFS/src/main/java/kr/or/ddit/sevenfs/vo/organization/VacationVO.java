package kr.or.ddit.sevenfs.vo.organization;

import java.sql.Date;

import lombok.Data;

// 연차 VO

@Data
public class VacationVO {

	private String emplNo;
	private String yrycYear;
	private String yrycUseBeginDate; 
	private String yrycUseEndDate; 
	private String yrycDetail; 
	private double totYrycDaycnt; // 총 연차일수
	private double yrycUseDaycnt; // 사용 연차일수
	private double yrycMdatDaycnt; // 연차조정일수
	private double yrycRemndrDaycnt; // 연차 잔여일수
	private double excessWorkYryc; // 초과근무연차
	private double cmpnstnYryc; // 보상연차
	
	// 게시글 번호
	private int rnum;
	// 사원이름
	private String emplNm;
	// 연차 유형명
	private String cmmnCodeNm;
	// 연차 시작일
	private Date dclzBeginDt;
	// 연차 종료일
	private Date dclzEndDt;
	// 근태 사유
	private String dclzReason;
	// 입사일자
	private String ecnyDate;
	// 퇴사일자
	private String retireDate;
	

}
