package kh.sns.controller;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.MemberBusinessDTO;
import kh.sns.dto.MemberDTO;
import kh.sns.dto.ProfileDTO;
import kh.sns.interfaces.MemberBusinessService;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.ProfileService;

@Controller
public class ProfileController {
	
	@Autowired	private ProfileService profileService;
	@Autowired	private MemberService memberService;
	@Autowired	private MemberBusinessService mBizService;
	
	/*======*/
	@RequestMapping("/profile.member")
	public ModelAndView editProfile(HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView();

		if(session.getAttribute("loginId") != null) {
			String memberId = session.getAttribute("loginId").toString();
			System.out.println("currentLoginId: " + memberId);
			MemberDTO member = memberService.getOneMember(memberId);
			ProfileDTO profile = profileService.getOneProfile(memberId);
			MemberBusinessDTO memberBiz = null;
			try {
				memberBiz = mBizService.selectAnMemberBiz(memberId);
			} catch(IndexOutOfBoundsException e) {
				System.err.println("This is not business account!!");
			}
			
			mav.addObject("member", member);
			mav.addObject("profile", profile);
			mav.addObject("memberBiz", memberBiz);

			mav.setViewName("mypage2.jsp");

		} else {
			// 작업 추가
		}		

		return mav;		

	}

	@RequestMapping("/editProfileProc.member")
	public ModelAndView editProfile(MemberDTO member, ProfileDTO profile, HttpServletRequest request) throws Exception {

		member.setId(request.getSession().getAttribute("loginId").toString());
		profile.setId(request.getSession().getAttribute("loginId").toString());
		System.out.println(member);

		int result = memberService.updateOneMemberProfile(member, profile);

		ModelAndView mav = new ModelAndView();
		mav.addObject("editProfileResult", result);
		mav.setViewName("redirect:profile.member?targetTab=profileTab");	// 리다이렉트? 포워드?
		return mav;		
	}
	
	@RequestMapping("/toggleProfileCheckbox.ajax")
	public void toggleProfileCheckbox(HttpServletRequest request, HttpServletResponse response) {		
		
		response.setCharacterEncoding("UTF8");
		try {
			PrintWriter xout = response.getWriter();
			String fieldName = request.getParameter("fieldName");
			System.out.println("@@fieldName: " + fieldName);
			int result = profileService.toggleProfileCheckbox(profileService.getOneProfile(request.getSession().getAttribute("loginId").toString())
					, fieldName);
			System.out.println("@@result: " + result);
			xout.print(result);
			xout.flush();
			xout.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}   
	}
	
	// 최초 1회 변경입니다.
	@RequestMapping("/changeBizAccount.profile")
	public ModelAndView changeBizAccount(HttpSession session) throws Exception {
		
		String id = session.getAttribute("loginId").toString();
		MemberDTO member = memberService.getOneMember(id);
		
		try {
			if(mBizService.selectAnMemberBiz(id) != null) {
				System.err.println("이미 있는 사람");
				return null;
			}
		} catch(IndexOutOfBoundsException e) {
			System.err.println("IndexOutOfBoundsException이 제일 골치아프다..");
		}
		
		MemberBusinessDTO mbiz = new MemberBusinessDTO();
		mbiz.setBizWebsite(profileService.getOneProfile(id).getWebsite());
		mbiz.setBizEmail(member.getEmail());
		mbiz.setBizPhone(member.getPhone());
		mbiz.setId(id);
		mbiz.setIsAllowEnterProfile("y");
		
		int result = mBizService.insertAnMemberBiz(mbiz);		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:profile.member?targetTab=bizProfile");
		mav.addObject("bizChangeResult", result);
		return mav;
		
	}
	
	@RequestMapping("/updateBizProfileProc.member")
	public ModelAndView updateBizProfileProc(HttpSession session, MemberBusinessDTO memberBiz) throws Exception {
		String id = session.getAttribute("loginId").toString();
		memberBiz.setId(id);
		int result = mBizService.updateAnMemberBiz(memberBiz);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:profile.member?targetTab=bizProfile");
		return mav;
		
	}

}
