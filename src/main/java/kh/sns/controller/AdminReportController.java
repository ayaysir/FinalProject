package kh.sns.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportOutputSet;
import kh.sns.interfaces.AdminReportsService;

@Controller
public class AdminReportController {
	
	@Autowired
	AdminReportsService ars;
	
	@RequestMapping("/report.admin")
	public ModelAndView reportManagementMain(HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		// 나중에 관리 권한을 가진 사람들만 접속되도록 변경
		if(session.getAttribute("loginId") == null) {
			mav.setViewName("redirect:에러페이지");
			return mav;
		}
		
		AdminReportOutputSet aros = ars.getAllReports();						
		
		mav.addObject("list", aros.getReportList());
		mav.addObject("code", aros.getCodeList());
		mav.addObject("result", aros.getResultList());
		mav.setViewName("admin_report.jsp");
		return mav;
	}
	
	@RequestMapping("/idunno.test")
	public ModelAndView writeProcBoard(HttpServletRequest request) {		
		
//		System.out.println(request.getSession().getServletContext().getRealPath("AttachedMedia"));
		
		try {
//			profileService.toggleProfileCheckbox(profileService.getOneProfile("yukirinu"), "is_allow_sms");
//			List<BoardDTO> list = boardService.getBoard("yukirinu");
//			System.out.println(new Gson().toJson(list));
						
			List<AdminReportCode> list = ars.getReportCodeList();
			System.out.println(list);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("/send.admin")
	public void sendReport(HttpServletResponse response, AdminReportDTO dto) throws Exception {
		response.setCharacterEncoding("UTF-8");
		int result = ars.insertAnReport(dto);
		if (result == 1) {
			response.getWriter().print("신고가 완료되었습니다.");
		}else {
			response.getWriter().print("신고에 실패하였습니다.");
		}
		response.getWriter().flush();
		response.getWriter().close();
	}
	
}