package web.interceptor;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import web.controller.BoardController;

public class LoginIntcp implements HandlerInterceptor{
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		//세션객체
		HttpSession session  =  request.getSession();
		
		//비 로그인 상태
		if( Integer.parseInt(String.valueOf(session.getAttribute("loginType"))) == 0 ){
			logger.info(" >>접속불가 : 비로그인 상태");
			
			response.sendRedirect("/member/Login");
			return false; 	//컨트롤러 접근 금지
			
		}
		
		//로그인된 상태만 확인
		logger.info(" >>정상적인 접근 : 로그인상태");
		
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

}
