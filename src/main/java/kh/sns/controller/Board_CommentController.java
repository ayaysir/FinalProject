package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_CommentDTO;
import kh.sns.interfaces.BoardDAO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_CommentService;

@Controller
public class Board_CommentController {

   @Autowired
   private Board_CommentService boardcommentservice;
   @Autowired
   private BoardDAO boarddao;
  
   @RequestMapping("/comment.co")
   public void insertComment(Board_CommentDTO dto, HttpSession session, HttpServletResponse response) {
	   response.setCharacterEncoding("UTF-8");
	   response.setContentType("application/json");
      System.out.println(dto.getComment_seq());
      String id = (String)session.getAttribute("loginId");
      dto.setId(id);
      
      int commentseq = 0;
      
      try {    
         commentseq = this.boardcommentservice.getCommentSeq();
        // count = this.boardcommentservice.commentCount(dto.getBoard_seq());
         dto.setComment_seq(commentseq);
         int result =this.boardcommentservice.insertComment(dto);
         
         BoardDTO board_dto = new BoardDTO(dto.getBoard_seq(),dto.getComment_contents(),"","","","");
         int[] hashTagResult = boarddao.insertHashTags(board_dto,commentseq);   
         ////////요기서 태그인설트들어가용
         
//      JsonObject object = new JsonObject();
      String bid = boarddao.getBoardId(dto.getComment_seq());
//      object.addProperty("seq", dto.getComment_seq());
//      object.addProperty("bid", bid);
      System.out.println("bid:" + bid);
      
      List<Object> result1 = new ArrayList<>();
		result1.add(dto.getComment_seq());
		result1.add(bid);
	
		
         
         if(result >0) {  
            System.out.println("success");
            System.out.println(dto.getComment_seq()); 
            
//            new Gson().toJson(object, response.getWriter());
         }
         else {  
            System.out.println("failed");  
         }

         
         

 		new Gson().toJson(result1,response.getWriter());
       
       
      }catch(Exception e) {
         System.out.println("요기는 comment.co입니다");
         e.printStackTrace();
      }
   
   }
   
   @RequestMapping("/commentdel.co")
   public void delComment(int board_seq,int comment_seq, HttpSession session, HttpServletResponse response)  {
      System.out.println(comment_seq);  
      int result = 0; 
      int count = 0;
      int delrs = 0;
      try {
         result = this.boardcommentservice.delComment(comment_seq);
         count = this.boardcommentservice.commentCount(board_seq); 
         delrs = this.boarddao.deleteTags(comment_seq);     
         
         
         System.out.println(result);   
         if(result > 0 ) {
            System.out.println("del success");   
         }   
         else {
            System.out.println("del failed");
         }
         System.out.println(count); 
       response.getWriter().print(count);
 		response.getWriter().flush();
 		response.getWriter().close();
           
      }catch(Exception e) {
         System.out.println("요기는  commentdel.co입니다");
         e.printStackTrace();
      }
     
   }
   
   @RequestMapping("/commentmod.co")
   public void modComment(Board_CommentDTO dto, HttpSession session, HttpServletResponse response)  {
      System.out.println(dto.getComment_seq() + " : " + dto.getComment_contents());  
      int result = 0; 
      int delrs=0;
      try { 
    	  
    	
    	 delrs = this.boarddao.deleteTags(dto.getComment_seq()); 
         result = this.boardcommentservice.modComment(dto);
         
         int board_seq =boardcommentservice.getBoard_seq(dto.getComment_seq());
         BoardDTO board_dto = new BoardDTO(board_seq,dto.getComment_contents(),"","","","");
         int[] hashTagResult = boarddao.insertHashTags(board_dto,dto.getComment_seq());        
         ////////요기서 태그인설트들어가용  
         System.out.println(result);   
         if(result > 0 ) {
            System.out.println("mod success");   
         }   
         else {
            System.out.println("mod failed");
         }
         
      }catch(Exception e) {
         System.out.println("요기는  commentmod.co입니다");
         e.printStackTrace();
      }
     
   }
   
   
   @RequestMapping("/insertComment.co")
   public void insertComment(HttpServletResponse response, Board_CommentDTO dto, HttpSession session)  {
	
	   	int result = 0;
	   	String id = (String)session.getAttribute("loginId");
	   	dto.setId(id);
	   	int comment_seq = 0;
	   	
	   	try {
	   		comment_seq = boardcommentservice.getCommentSeq();
	   		dto.setComment_seq(comment_seq);	
			result = boardcommentservice.insertComment(dto);
			
			 response.getWriter().print(comment_seq);
		 		response.getWriter().flush();
		 		response.getWriter().close();
		           
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   	
	   
	   
   }
}