package web.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/myplant")
public class MyPlantController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyPlantController.class);
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(HttpSession session, Model model) {
		
		logger.info("myplant/list [GET]");
		
		return "/myplant/list";
		
	}

}