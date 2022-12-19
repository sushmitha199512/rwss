package nic.watersoft.ftp;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class RwsHttpSessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent session) {
		System.out.println("Session Created");
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent session) {
		
		
		System.out.println("Session Destroyed");
		
	}

}
