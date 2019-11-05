package com.common.constantes;

import com.common.util.PropertiesFactory;

public class BaseConstantes {
	public final static String OPEN_API_KEY = PropertiesFactory.devProperties.getProperty("openApi.Key");
	
	public final static String OPEN_API_URL = PropertiesFactory.devProperties.getProperty("openApi.URL");
	
}
