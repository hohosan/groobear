package kr.or.ddit.sevenfs.service.mail.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.mail.internet.MimeMessage;
import kr.or.ddit.sevenfs.mapper.mail.MailMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.mail.MailAsyncService;
import kr.or.ddit.sevenfs.service.mail.MailLabelService;
import kr.or.ddit.sevenfs.service.mail.MailService;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.service.schedule.ScheduleLabelService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.val;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailServiceImpl implements MailService{
	
	@Value("${file.save.abs.path}")
	private String saveDir;
	
	@Autowired
	MailMapper mailMapper;
	
	@Autowired
	MailLabelService labelService;
	
	@Autowired
	AttachFileService attachFileService;
	
	@Autowired
	MailAsyncService asyncService;
	
	@Autowired
	NotificationService notificationService;
	
//	// smtp 설정
//	@Autowired
//	private JavaMailSender mailSender;
	
//	@Value("${spring.mail.username}")
//	private String fromMail;
//	@Value("${spring.mail.password}")
//	private String password;
	
	
	@Override
	public int sendMail(MailVO mailVO, MultipartFile[] uploadFile) {
		/*
		 *  emailTrnsmisTy
	 		전송타입 0 보낸 메일,1 받은 메일, 2 참조, 3 숨은 참조
	 		
			emailClTy 메일함분류시 사용 0 보낸메일, 1 받은메일, 2 임시메일, 3 스팸함, 4 휴지통
		 * */
		String trnsmtEmplNm = mailVO.getEmplNm();
		List<String> recptnEmailList = mailVO.getRecptnEmailList();
		List<String> refEmailList = mailVO.getRefEmailList();
		List<String> hiddenRefEmailList = mailVO.getHiddenRefEmailList();
		List<MailVO> mailVOList = new ArrayList<MailVO>();
		List<EmployeeVO> notificationEmail = new ArrayList<EmployeeVO>();
		MailVO sendVO = null;
		
		int totalMailNoCnt = 1;
		if(recptnEmailList!=null) {
			totalMailNoCnt += recptnEmailList.size();
		}
		if(refEmailList!=null) {
			totalMailNoCnt += refEmailList.size();
		}
		if(hiddenRefEmailList!=null) {
			totalMailNoCnt += hiddenRefEmailList.size();
		}
		int[] mailNos = mailMapper.getMailNos(totalMailNoCnt);
		int emailNoIndex = 0;
		
		// 첨부파일 처리
		if(uploadFile != null && uploadFile.length != 0) {
//			log.info("첨부파일 업로드 경로 saveDir + /mail : "+saveDir+"mail");
			long atchFileNo = attachFileService.insertFileList("mail", uploadFile);
			mailVO.setAtchFileNo(atchFileNo);
		}
		// 보낸 메일함
		mailVO.setEmailTrnsmisTy("0");
		mailVO.setEmailClTy("0");
		mailVO.setReadngAt("Y");
		mailVO.setRecptnEmail(recptnEmailList.get(0).split("_")[1]);
		
		int emailGroupNo = mailMapper.getEmailGroupNo();
		mailVO.setEmailNo(mailNos[emailNoIndex++]);
		mailVO.setEmailGroupNo(emailGroupNo);
		mailVO.setReadngAt("Y");
		mailVOList.add(mailVO);
		
		// 받은 메일함
		if(recptnEmailList != null) {
			for(int i = 0; i < recptnEmailList.size(); i++) {
				MailVO vo = new MailVO(mailVO);
				String[] emplNoEmail = recptnEmailList.get(i).split("_");
				log.info("emplNoEmail"+emplNoEmail);
				log.info("emplNoEmail[1] : "+emplNoEmail[1]);
				log.info("emplNoEmail[0] : "+emplNoEmail[0]);
				
				vo.setEmailTrnsmisTy("1");
				vo.setEmailClTy("1");
				vo.setRecptnEmail(emplNoEmail[1]);
				vo.setEmplNo(emplNoEmail[0]);
				vo.setEmailNo(mailNos[emailNoIndex++]);
				vo.setEmailGroupNo(emailGroupNo);
				vo.setReadngAt("N");
				mailVOList.add(vo);
				
				if(emplNoEmail[0] != null && emplNoEmail[0].equals("")) {
					// smtp전송을 위한 vo세팅
					sendVO = new MailVO(vo);
					sendVO.setEmplNo("");
					continue;
				}
				
				// 알림 추가
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmail(emplNoEmail[1]);
				employeeVO.setEmplNo(emplNoEmail[0]);
				notificationEmail.add(employeeVO);
			}
		}
		// 받은 메일함 - 참조
		if(refEmailList != null) {
			for(int i = 0; i < refEmailList.size(); i++) {
				MailVO vo = new MailVO(mailVO);
				String[] emplNoEmail = refEmailList.get(i).split("_");
				log.info("emplNoEmail[1] : "+emplNoEmail[1]);
				log.info("emplNoEmail[0] : "+emplNoEmail[0]);
				vo.setEmailTrnsmisTy("2");
				vo.setEmailClTy("1");
				vo.setRecptnEmail(emplNoEmail[1]);
				vo.setEmplNo(emplNoEmail[0]);
				vo.setEmailNo(mailNos[emailNoIndex++]);
				vo.setEmailGroupNo(emailGroupNo);
				vo.setReadngAt("N");
				mailVOList.add(vo);
				
				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmail(emplNoEmail[1]);
				employeeVO.setEmplNo(emplNoEmail[0]);
				notificationEmail.add(employeeVO);
			}
		}
		// 받은 메일함 - 숨은참조
		if(hiddenRefEmailList != null) {
			for(int i = 0; i < hiddenRefEmailList.size(); i++) {
				MailVO vo = new MailVO(mailVO);
				String[] emplNoEmail = hiddenRefEmailList.get(i).split("_");
				log.info("emplNoEmail[1] : "+emplNoEmail[1]);
				log.info("emplNoEmail[0] : "+emplNoEmail[0]);
				vo.setEmailTrnsmisTy("3");
				vo.setEmailClTy("1");
				vo.setRecptnEmail(emplNoEmail[1]);
				vo.setEmplNo(emplNoEmail[0]);
				vo.setEmailNo(mailNos[emailNoIndex++]);
				vo.setEmailGroupNo(emailGroupNo);
				vo.setReadngAt("N");
				mailVOList.add(vo);

				EmployeeVO employeeVO = new EmployeeVO();
				employeeVO.setEmail(emplNoEmail[1]);
				employeeVO.setEmplNo(emplNoEmail[0]);
				notificationEmail.add(employeeVO);
			}
		}
		
		if(notificationEmail.size() != 0) {
			NotificationVO notificationVO = new NotificationVO();
			notificationVO.setNtcnSj("[메일 알림]");
			notificationVO.setNtcnCn(trnsmtEmplNm+"님이 메일을 송신하였습니다.");
			// 클릭시 어디로 보내줄 것인지
			notificationVO.setOriginPath("/mail?emailClTy=1");
			notificationVO.setSkillCode("05");
			
			notificationService.insertNotification(notificationVO, notificationEmail);
			log.info("notificationService -> insertNotification -> notificationVO : "+notificationVO);
			log.info("notificationService -> insertNotification -> notificationEmail : "+notificationEmail);
		}
		log.info("MailServiceImpl -> sendMail -> mailVOList : "+mailVOList);
		int result = mailMapper.sendMail(mailVOList);
		if(sendVO!=null) {
			// 프록시를 통해 호출해야 하기때문에 이렇게 하라고 함
			asyncService.sendMailAsync(sendVO);
		}
		return result;
	}
	
	@Override
	public int tempStoreEmail(MailVO mailVO, MultipartFile[] uploadFile) {
		/*
		 *  emailTrnsmisTy
	 		전송타입 0 참조x, 1 참조, 2 숨은 참조
	 		
			emailClTy 메일함분류시 사용 0 보낸메일, 1 받은메일, 2 임시메일, 3 스팸함, 4 휴지통
		 * */
		List<String> recptnEmailList = mailVO.getRecptnEmailList();
		List<String> refEmailList = mailVO.getRefEmailList();
		List<String> hiddenRefEmailList = mailVO.getHiddenRefEmailList();
		List<MailVO> mailVOList = new ArrayList<MailVO>();
		int totalMailNoCnt = 1;
		if(recptnEmailList!=null) {
			totalMailNoCnt += recptnEmailList.size();
		}
		if(refEmailList!=null) {
			totalMailNoCnt += refEmailList.size();
		}
		if(hiddenRefEmailList!=null) {
			totalMailNoCnt += hiddenRefEmailList.size();
		}
		int[] mailNos = mailMapper.getMailNos(totalMailNoCnt);
		int emailNoIndex = 0;
		
		// 첨부파일 처리
		if(uploadFile != null && uploadFile.length != 0) {
//			log.info("첨부파일 업로드 경로 saveDir + /mail : "+saveDir+"mail");
			long atchFileNo = attachFileService.insertFileList("mail", uploadFile);
			mailVO.setAtchFileNo(atchFileNo);
		}
		// 보낸 메일함
		mailVO.setEmailTrnsmisTy("0");
		mailVO.setEmailClTy("2");
		if(recptnEmailList!=null) {
			mailVO.setRecptnEmail(recptnEmailList.get(0).split("_")[1]);
		}else {
			mailVO.setRecptnEmail("");
		}
		
		int emailGroupNo = mailMapper.getEmailGroupNo();
		mailVO.setEmailNo(mailNos[emailNoIndex++]);
		mailVO.setEmailGroupNo(emailGroupNo);
		mailVO.setReadngAt("Y");
		mailVO.setDelAt("N");
		mailVOList.add(mailVO);
		// 받은 메일함
		if(recptnEmailList != null) {
			for(int i = 0; i < recptnEmailList.size(); i++) {
				MailVO vo = new MailVO();
				String[] emplNoEmail = recptnEmailList.get(i).split("_");
				log.info("emplNoEmail"+emplNoEmail);
				log.info("emplNoEmail[1] : "+emplNoEmail[1]);
				log.info("emplNoEmail[0] : "+emplNoEmail[0]);
				vo.setEmailTrnsmisTy("1");
				vo.setEmailClTy("1");
				vo.setRecptnEmail(emplNoEmail[1]);
				vo.setEmplNo(emplNoEmail[0]);
				vo.setEmailNo(mailNos[emailNoIndex++]);
				vo.setEmailGroupNo(emailGroupNo);
				vo.setReadngAt("N");
				vo.setDelAt("Y");
				mailVOList.add(vo);
			}
		}
		// 받은 메일함 - 참조
		if(refEmailList != null) {
			for(int i = 0; i < refEmailList.size(); i++) {
				MailVO vo = new MailVO();
				String[] emplNoEmail = refEmailList.get(i).split("_");
				log.info("emplNoEmail[1] : "+emplNoEmail[1]);
				log.info("emplNoEmail[0] : "+emplNoEmail[0]);
				vo.setEmailTrnsmisTy("2");
				vo.setEmailClTy("1");
				vo.setRecptnEmail(emplNoEmail[1]);
				vo.setEmplNo(emplNoEmail[0]);
				vo.setEmailNo(mailNos[emailNoIndex++]);
				vo.setEmailGroupNo(emailGroupNo);
				vo.setReadngAt("N");
				vo.setDelAt("Y");
				mailVOList.add(vo);
			}
		}
		// 받은 메일함 - 숨은참조
		if(hiddenRefEmailList != null) {
			for(int i = 0; i < hiddenRefEmailList.size(); i++) {
				MailVO vo = new MailVO();
				String[] emplNoEmail = hiddenRefEmailList.get(i).split("_");
				log.info("emplNoEmail[1] : "+emplNoEmail[1]);
				log.info("emplNoEmail[0] : "+emplNoEmail[0]);
				vo.setEmailTrnsmisTy("3");
				vo.setEmailClTy("1");
				vo.setRecptnEmail(emplNoEmail[1]);
				vo.setEmplNo(emplNoEmail[0]);
				vo.setEmailNo(mailNos[emailNoIndex++]);
				vo.setEmailGroupNo(emailGroupNo);
				vo.setReadngAt("N");
				vo.setDelAt("Y");
				mailVOList.add(vo);
			}
		}
		log.info("MailServiceImpl -> tempStoreEmail -> mailVOList : "+mailVOList);
		int result = mailMapper.tempStoreEmail(mailVOList);
		return result;
	}

	@Override
	public List<MailVO> getList(ArticlePage<MailVO> articlePage) {
		List<MailVO> mailVOList = mailMapper.getList(articlePage);
		return mailVOList;
	}

	@Override
	public MailVO emailDetail(MailVO mailVO) {
		// mailVO에 emailNo가 들어있음
		int emailNo = mailVO.getEmailNo();
		String name="";
		log.info("mailVO 확인 : "+mailVO);
		log.info("이메일 번호 확인 : "+emailNo);
		List<MailVO> mailVOList = mailMapper.emailDetail(mailVO);
//		Map<String, Object> returnMap = new HashMap<String, Object>();
		log.info("MailServiceImpl emailDetail -> mailVOList : "+mailVOList);
		Map<String,Object> trnsmitMap = new HashMap<String,Object>();
		List<Map<String, Object>> recptnList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> refEmailList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> hiddenRefEmailList = new ArrayList<Map<String, Object>>();
		for(int i = 0; i < mailVOList.size(); i++ ) {
			Map<String, Object> map = new HashMap<String, Object>();
			log.info("MailServiceImpl emailDetail -> map : "+mailVOList.get(i));
			if(mailVOList.get(i).getEmailNo() == emailNo) {
				mailVO = mailVOList.get(i);
				log.info("if(mailVO.getEmailNo() == emailNo) mailVOList.get(i) "+mailVOList.get(i));
				
			}
			if(mailVOList.get(i).getEmailTrnsmisTy().equals("0")) {
//				mailVOList.get(i).getEmpl
//				map.put("emplNo", (String)mailVOList.get(i).getEmplNo());
//				map.put("emplNm", (String)mailVOList.get(i).getEmplNm());
//				map.put("recptnEmail", (String)mailVOList.get(i).getRecptnEmail());
				log.info("mailVOList.get(i).getEmplNm() : "+mailVOList.get(i).getEmplNm());
				mailVO.setEmplNm(mailVOList.get(i).getEmplNm());
				mailVO.setEmplNo(mailVOList.get(i).getEmplNo());
				log.info("mailVOList.get(i).getEmplNm() 세팅 후 : "+mailVO.getEmplNm());
				name = mailVOList.get(i).getEmplNm();
//				recptnList.add(map);
			} else if(mailVOList.get(i).getEmailTrnsmisTy().equals("1")) {
				map.put("emplNo", (String)mailVOList.get(i).getEmplNo());
				map.put("emplNm", (String)mailVOList.get(i).getEmplNm());
				map.put("recptnEmail", (String)mailVOList.get(i).getRecptnEmail());
				recptnList.add(map);
			}else if(mailVOList.get(i).getEmailTrnsmisTy().equals("2")) {
				log.info("실행여부 mailVOList.get(i).getEmailTrnsmisTy().equals(\"2\")");
				map.put("emplNo", (String)mailVOList.get(i).getEmplNo());
				map.put("emplNm", (String)mailVOList.get(i).getEmplNm());
				map.put("recptnEmail", (String)mailVOList.get(i).getRecptnEmail());
				refEmailList.add(map);
			}else if(mailVOList.get(i).getEmailTrnsmisTy().equals("3")) {
				map.put("emplNo", (String)mailVOList.get(i).getEmplNo());
				map.put("emplNm", (String)mailVOList.get(i).getEmplNm());
				map.put("recptnEmail", (String)mailVOList.get(i).getRecptnEmail());
				hiddenRefEmailList.add(map);
			}
		}
		String lblCol = labelService.getCol(mailVO.getLblNo());
		
		mailVO.setLblCol(lblCol);
		mailVO.setRecptnMapList(recptnList);
		mailVO.setRefMapList(refEmailList);
		mailVO.setHiddenRefMapList(hiddenRefEmailList);
		mailVO.setEmplNm(name);
		log.info("MailServiceImpl emailDetail -> mailVO : "+mailVO);
		return mailVO;
	}
	
	@Override
	public List<AttachFileVO> getAtchFile(long atchFileNo) {
		return mailMapper.getAtchFile(atchFileNo);
	}

	@Override
	public void downloadFile(String fileName) {
		ResponseEntity<Resource> entity = attachFileService.downloadFile(fileName);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		int result = mailMapper.getTotal(map);
		return result;
	}

	@Override
	public int mailDelete(List<String> emailNoList) {
		int result = mailMapper.mailDelete(emailNoList);
		return result;
	}

	@Override
	public int labelingUpt(Map<String, Object> map) {
		int result = mailMapper.labelingUpt(map);
		return result;
	}

	@Override
	public List<MailVO> mailLabeling(int lblNo) {
		return mailMapper.mailLabeling(lblNo);
	}
	/*<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>--- Original Message ---<br><strong>From : </strong>"김지연"&lt;kimdemo@dodemo.com&gt;<br><strong>To : </strong>hoodemo@dodemo.com<br><strong>Date : </strong>2025/04/16 수요일 오전 8:04:37<br><strong>Subject : </strong>[참조자 등록] '김지연 부장'이(가) 작성한 '[승인요청] 2025년 2분기 타운홀 진행'의 참조자로 등록되었습니다.</p>*/

	@Override
	public Map<String, Object> mailRepl(MailVO mailVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		mailVO = mailMapper.mailRepl(mailVO);
		// from
		String trnsmitEmail = mailVO.getTrnsmitEmail();
		Map<String,Object> empMap =  mailMapper.findEmplByEmail(trnsmitEmail);
		log.info("empMap : "+empMap);
		String fromEmplNm = (String)empMap.get("EMPL_NM");
		log.info("empMap : "+empMap+" fromEmplNm :"+fromEmplNm);
		// to
		String recptnEmail = mailVO.getRecptnEmail();
		String toEmplNm = mailVO.getEmplNm();;
		
		String trnsmitDt = mailVO.getTrnsmitDt();
		String emailSj = mailVO.getEmailSj();
		String emailCn = mailVO.getEmailCn();
		
		emailCn = "<p>&nbsp;</p>"
				+ "<p>&nbsp;</p>"
				+ "<p>&nbsp;</p>"
				+ "<p>&nbsp;</p>"
				+ "<p>&nbsp;</p>"
				+ "--- Original Message ---"
				+ "<br>"
				+ "<b>From : </b>"+fromEmplNm + "/"+trnsmitEmail
				+"<br>"
				+ "<b>To : </b>"+toEmplNm + "/"+recptnEmail
				+"<br>"
				+ "<b>Date : </b>"+trnsmitDt
				+"<br>"
				+ "<b>subject : </b>"+emailSj
				+"<br>"
				+emailCn;
		mailVO.setEmailCn(emailCn);
		log.info("service -> mailRepl -> mailVO : "+mailVO);
		mailVO.setEmailSj("");
		map.put("mailVO", mailVO);
		map.put("fromEmplNm", fromEmplNm);
		map.put("fromEmplNo", (String)empMap.get("EMPL_NO"));
		log.info("service -> mailRepl -> map : "+map);
		return map;
	}

	@Override
	public MailVO mailTrnsms(MailVO mailVO) {
		mailVO = mailMapper.mailRepl(mailVO);
		log.info("mailTrnsms 확인"+mailVO);
		return mailVO;
	}

	@Override
	public int restoration(List<MailVO> mailVOList) {
		mailVOList.stream().forEach(mail->{
			log.info(mail.getEmailTrnsmisTy());
		});
		return mailMapper.restoration(mailVOList);
	}

	@Override
	public List<MailVO> emailDetails(List<String> checkedList) {
		return mailMapper.emailDetails(checkedList);
	}
	@Override
	public int mailStarred(Map<String, Object> map) {
		return mailMapper.mailStarred(map);
	}

	@Override
	public int readingAt(int emailNo) {
		return mailMapper.readingAt(emailNo);
	}

	@Override
	public int delLblFromMail(int lblNo) {
		return mailMapper.delLblFromMail(lblNo);
	}

	@Override
	public int mailRealDelete(List<String> emailNoList) {
		int result = mailMapper.mailRealDelete(emailNoList);
		return result;
	}
}
