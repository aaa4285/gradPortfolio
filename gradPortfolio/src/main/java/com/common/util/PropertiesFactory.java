package com.common.util;

import java.util.Properties;

public class PropertiesFactory {
	public final static Properties configProperties =  PropertiesReader.getInstance("config.properties");
}
