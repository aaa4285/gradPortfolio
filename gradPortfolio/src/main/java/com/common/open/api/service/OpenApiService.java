package com.common.open.api.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.common.constantes.BaseConstantes;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OpenApiService {

	public Map<String, Object> OrganicAnimalsSearch(String searchRequirement, Map<String, Object> searchJSON) {
		Map<String, Object> resultMap = new HashMap<>();

		try {
			StringBuilder urlBuilder = new StringBuilder(BaseConstantes.OPEN_API_URL);

			if (!StringUtils.isEmpty(searchRequirement)) {
				urlBuilder.append("/".concat(searchRequirement));
			}

			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + BaseConstantes.OPEN_API_KEY);
			
			if (searchJSON != null) {
				searchJSON.forEach((k, v) -> {
					urlBuilder.append("&" + k + "=" + v);
				});
			}
			

			URL url = new URL(urlBuilder.toString());

			System.out.println("###url=>" + url);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type", "application/json");
			System.out.println("Response Code:" + conn.getResponseCode());

			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();

			JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());
			String xmlJSONObjString = xmlJSONObj.toString();
			System.out.println("### xmlJSONObjString=>" + xmlJSONObjString);

			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, Object> map = new HashMap<>();
			map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>() {
			});
			Map<String, Object> dataResponse = (Map<String, Object>) map.get("response");
			Map<String, Object> body = (Map<String, Object>) dataResponse.get("body");
			Map<String, Object> items = null;
			List<Map<String, Object>> itemList = null;
			if (body.get("items") != "") {
				items = (Map<String, Object>) body.get("items");
				System.out.println("********* "+items.get("item").getClass());
				if (items.get("item").getClass().toString().lastIndexOf("LinkedHashMap")>-1) {
					itemList = new ArrayList<Map<String, Object>>();
					itemList.add((Map<String, Object>) items.get("item"));
				} else {
					itemList = (List<Map<String, Object>>) items.get("item");
				}
			}
			
			
/*
			System.out.println("### map=" + map);
			System.out.println("### dataResponse=" + dataResponse);
			System.out.println("### body=" + body);
			System.out.println("### items=" + items);
			System.out.println("### itemList=" + itemList);
*/

			resultMap.put("Result", "0000");
			resultMap.put("numOfRows", body.get("numOfRows"));
			resultMap.put("pageNo", body.get("pageNo"));
			resultMap.put("totalCount", body.get("totalCount"));
			resultMap.put("data", itemList);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.clear();
			resultMap.put("Result", "0001");
		}

		return resultMap;
	}
}
