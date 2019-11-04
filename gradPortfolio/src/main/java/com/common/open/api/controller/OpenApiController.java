package com.common.open.api.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.common.open.api.service.OpenApiService;

@RestController
public class OpenApiController {
	
	@Autowired
	OpenApiService openApiService;
	
	/**
	 * 시도조회
	 */
	@RequestMapping("/sido")
	public Map<String, Object> sidoSearch(@RequestBody(required = false) Map<String, Object> searchJSON) {
		return openApiService.OrganicAnimalsSearch("sido", searchJSON);
	}
	
	/**
	 * 시군구 조회
	 */
	@RequestMapping("/sigungu")
	public Map<String, Object> sigunguSearch(@RequestBody(required = false) Map<String, Object> searchJSON) {
		return openApiService.OrganicAnimalsSearch("sigungu", searchJSON);
	}
	
	/**
	 * 보호소 조회
	 */
	@RequestMapping("/shelter")
	public Map<String, Object> shelterSearch(@RequestBody(required = false) Map<String, Object> searchJSON) {
		return openApiService.OrganicAnimalsSearch("shelter", searchJSON);
	}
	
	/**
	 * 품종조회
	 */
	@RequestMapping("/kind")
	public Map<String, Object> kindSearch(@RequestBody(required = false) Map<String, Object> searchJSON) {
		return openApiService.OrganicAnimalsSearch("kind", searchJSON);
	}
	
	/**
	 * 유기동물 조회
	 */
	@RequestMapping("/abandonmentPublic")
	public Map<String, Object> abandonmentPublicSearch(@RequestBody(required = false) Map<String, Object> searchJSON) {
		Map<String, Object> map = openApiService.OrganicAnimalsSearch("abandonmentPublic", searchJSON);
		if (map!=null) {
			if(map.containsKey("data") && map.get("data")!=null && map.get("data").getClass().toString().lastIndexOf("ArrayList")>-1) {
				List<Map<String, Object>> list = (ArrayList)map.get("data");
				for (int i = 0; i < list.size(); i++) {
					Map object = list.get(i);
					/* 성별코드
					* M :수컷
					* F :암컷
					* Q : 미상
					*/
					if (object!=null && object.containsKey("sexCd")) {
						String sexCd = object.get("sexCd").toString();
						String sexCdNm = "";
						if ("M".equals(sexCd)) {
							sexCdNm = "수컷";
						} else if ("F".equals(sexCd)) {
							sexCdNm = "암컷";
						} else if ("Q".equals(sexCd)) {
							sexCdNm = "미상";
						}
						object.put("sexCdNm", sexCdNm);
					}
					
					/* 중성화여부 
					* Y : 예
					* N : 아니오
					* U : 미상
					*/
					if (object!=null && object.containsKey("neuterYn")) {
						String neuterYn = object.get("neuterYn").toString();
						String neuterYnNm = "";
						if ("Y".equals(neuterYn)) {
							neuterYnNm = "예";
						} else if ("N".equals(neuterYn)) {
							neuterYnNm = "아니오";
						} else if ("U".equals(neuterYn)) {
							neuterYnNm = "미상";
						}
						object.put("neuterYnNm", neuterYnNm);
					}
					
					list.set(i,object);
				}
				map.put("data",list);
			}
		}
		
		return map;
	}
}
