package com.ese.controller.servicecenter.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ese.common.webSocket.AuthorizationWebSocketHandler;

@Controller
public class AuthorizationController {
	
	@Autowired
	AuthorizationWebSocketHandler sock;

	@RequestMapping("/order/genCode.do")
	public ModelAndView generateQRCode(String userId) {
		return new ModelAndView("qrcodeview", "userId", userId);
	}
	
	@RequestMapping("/order/verify.do")
	@ResponseBody
	public String authorization(@RequestParam(value="userId", required=false) String userId, 
			@RequestParam(value="phone", required=false) String phone) {
		
		String returnCode = "deny\n";
		
		try {
			returnCode = sock.sendMessage(Integer.parseInt(userId), phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnCode;
	}
	
}
