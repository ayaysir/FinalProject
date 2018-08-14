package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.Board_CommentDTO;

public interface Board_CommentService {
	
	public int insertComment(Board_CommentDTO dto) throws Exception;
	public List<Board_CommentDTO> getFeedComment(String id) throws Exception;
	public int delComment(int comment_seq) throws Exception ;

}
