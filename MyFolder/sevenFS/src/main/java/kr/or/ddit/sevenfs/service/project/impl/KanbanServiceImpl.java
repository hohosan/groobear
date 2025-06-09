package kr.or.ddit.sevenfs.service.project.impl;

import kr.or.ddit.sevenfs.mapper.project.KanbanMapper;
import kr.or.ddit.sevenfs.mapper.project.ProjectMapper;
import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
import kr.or.ddit.sevenfs.service.project.KanbanService;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.GanttTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskEntity;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class KanbanServiceImpl implements KanbanService {

	@Autowired
    private final KanbanMapper kanbanMapper;
	
	@Autowired
	ProjectTaskMapper projectTaskMapper;
	
	@Autowired
	ProjectMapper projectMapper;

    @Override
    public List<ProjectTaskVO> getTasksByProject(Long prjctNo) {
        return kanbanMapper.selectTasksByProjectNo(prjctNo);
    }

    @Override
    public boolean updateTaskStatus(Long taskNo, String newStatus) {
        return kanbanMapper.updateTaskStatus(taskNo, newStatus) > 0;
    }

    @Override
    public ProjectTaskVO getTaskById(Long taskNo) {
        return kanbanMapper.selectTaskById(taskNo);
    }
    

    @Override
    public List<GanttTaskVO> getCardsByProject(Long prjctNo) {
        return projectTaskMapper.selectTaskCardsByProjectNo(prjctNo);
    }

    @Override
    public GanttTaskVO getTaskCardById(Long taskNo) {
        return projectTaskMapper.selectCardById(taskNo);
    }

    @Override
    public List<ProjectTaskEntity> getTaskEntitiesByProject(Long prjctNo) {
        // 엔티티를 가져오는 매퍼 메서드 호출
        return kanbanMapper.selectTaskEntitiesByProjectNo(prjctNo);
    }

}
