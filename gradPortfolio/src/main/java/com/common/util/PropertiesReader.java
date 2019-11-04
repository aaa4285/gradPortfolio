package com.common.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesReader {
	private static PropertiesReader PropertiesReader = null;
	private static Properties properties = null;
	
	public PropertiesReader(String propertiesPath) {
		try {
			// classpath 접근
			InputStream resources = getClass().getClassLoader().getResourceAsStream(propertiesPath);
			properties = new Properties();
			properties.load(resources);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static Properties getInstance(String propertiesPath) {
		if (PropertiesReader == null) {
			PropertiesReader = new PropertiesReader(propertiesPath);
		}
		return properties;
	}
}
