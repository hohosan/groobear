package kr.or.ddit.sevenfs.service.schedule;

import java.util.List;

import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

public interface ScheduleLabelService {
	List<ScheduleLabelVO> getLabel(ScheduleVO scheduleVO);

	int labelAdd(ScheduleLabelVO labelVO);

	int delLabel(ScheduleVO scheduleVO);

	int labelUpdate(ScheduleLabelVO labelVO);
}
