package com.common.constantes;

import com.common.util.PropertiesFactory;

public class BaseConstantes {
	public final static String OPEN_API_KEY = PropertiesFactory.configProperties.getProperty("openApi.Key");
	
	public final static String OPEN_API_URL = PropertiesFactory.configProperties.getProperty("openApi.URL");
	
	public final static String USER_SESSION_ID = PropertiesFactory.configProperties.getProperty("user.session.id");
	
}
