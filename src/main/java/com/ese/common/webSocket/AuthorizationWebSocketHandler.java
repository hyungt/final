package com.ese.common.webSocket;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ese.mappers.servicecenter.ServicecenterMapper;
import com.ese.vo.User;

public class AuthorizationWebSocketHandler extends TextWebSocketHandler {

	private Map<Integer, WebSocketSession> sessions = new HashMap<Integer, WebSocketSession>();
	
	@Autowired
	ServicecenterMapper scMapper;
	
	public String sendMessage(Integer userNo, String phone) throws Exception {
		WebSocketSession session = sessions.get(userNo);
		if (session != null) {
			User loginUser = scMapper.getUserByNo(userNo);
			String loginUserPhoneNumber = loginUser.getPhone().replaceAll("-", "");
			System.out.println(loginUserPhoneNumber);
			
			if(loginUserPhoneNumber.equals(phone)) {
				session.sendMessage(new TextMessage("ok"));
				return "ok\n";
			} else {
				session.sendMessage(new TextMessage("deny"));
				return "deny\n";
			}
		}
		return "deny\n";
	}

	// WebSocket 연결이 열리고 사용할 준비가 됐을 때 실행된다.
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.put(getUserNo(session), session);
	}

	// WebSocket 연결이 닫혔을 때 실행된다.
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 해당 클라이언트와 연결된 WebSocketSession을 제거한다.
		int userNo = getUserNo(session);
		sessions.remove(userNo);
		System.out.println("연결종료 : "+userNo);
	}

	// 전송 에러가 발생했을 때 실행된다.
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// 해당 클라이언트와 연결된 WebSocketSession을 제거한다.
		int userNo = getUserNo(session);
		sessions.remove(userNo);
		System.out.println("연결종료 : "+userNo);
	}
	
	private Integer getUserNo(WebSocketSession session) {
		Map<String, Object> attributes = session.getAttributes();
		return (Integer) attributes.get("LOGIN_USER_NO");
	}

}
