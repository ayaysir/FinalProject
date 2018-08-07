package kh.sns.interfaces;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;

import java.util.List;
public interface BoardDAO {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<BoardDTO> getBoard(String id);
	
	public int insertNewBoardContent(BoardDTO article) throws Exception;
	
	public int insertNewMedia(Board_MediaDTO media) throws Exception;
	
	public int selectBoardSeqRecentCurrVal() throws Exception;

	
}
