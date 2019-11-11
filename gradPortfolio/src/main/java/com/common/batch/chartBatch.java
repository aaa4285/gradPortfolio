package com.common.batch;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import com.common.open.api.service.OpenApiService;

public class chartBatch {
	public static String path = "/data/batch/chart/";
	public static String fileNm = "chart_data.json";
	public static OpenApiService openApiService = new OpenApiService();
	public static void main(String[] args) {
		List<Map<String, Object>> upr_cd_list = null;
		List<Map<String, Object>> upkind_list = null;
		try {
			upr_cd_list = getUprCd();
			upkind_list = getUpkind();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (upr_cd_list != null && upkind_list != null) {
			List<String> dateList = new ArrayList();
			// 일주일
			for (int i=0;i<7;i++) {
				Date date = new Date();
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
				cal.setTime(date);
				// 12시 넘어서니까 하루전 부터 7일 @@@
				cal.add(Calendar.DATE, -(7-i));
				dateList.add(df.format(cal.getTime()));
			}
			// 검색조건
			Map<String, Object> searchJSON = new HashMap<String, Object>();
			searchJSON.put("pageNo", "1");
			searchJSON.put("numOfRows", "1");
			//for (String dt : dateList) {
			/*
				searchJSON.put("bgnde", dt); // 시작일
				searchJSON.put("endde", dt); // 종료일
				System.out.println("["+dt+"] start*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*");
				*/
				Map<String,Object> pieData = new HashMap<String,Object>();
				List mapData = new ArrayList(); // [{upr_cd,..},{upr_cd,..}]
				Map mapData2 = new HashMap(); // {upr_cd:mapData}
				for (Map<String, Object> map : upr_cd_list) {
					// 시도코드
					String upr_cd = String.valueOf(map.get("upr_cd"));
					String upr_nm = String.valueOf(map.get("name"));
					System.out.println("upr_cd : " + upr_cd);
					List upkList = new ArrayList();
					int total = 0;
					for (Map<String, Object> map2 : upkind_list) {
						// 축종코드
						String upkind = String.valueOf(map2.get("cd"));
						String upkind_nm = String.valueOf(map2.get("name"));
						searchJSON.put("upr_cd", upr_cd);
						searchJSON.put("upkind", upkind);
						
						Map<String, Object> searchMap = new HashMap<String, Object>();
						searchMap.put("totalCount", Math.round(Math.random()*30));
						/*
						Map<String, Object> searchMap = openApiService.OrganicAnimalsSearch("sido", searchJSON);
						System.out.println(dt+" | "+upr_nm+" | " + upkind_nm + " ok.");
						*/
						total += Integer.parseInt(String.valueOf(searchMap.get("totalCount")));
						map2 = new HashMap();
						map2.put("value", searchMap.get("totalCount"));
						map2.put("code", upkind);
						map2.put("category", upkind_nm);
						map2.put("upr_cd", upr_cd);
						map2.put("upr_nm", String.valueOf(map.get("name")));
						upkList.add(map2);
					} // 축종 end
					
					// sort 추가
					upkList = setSort(upkList,"value");
					
					// pie data put
					pieData.put(upr_cd, upkList);
					
					// map chart data
					map.put("total", total);
					mapData.add(map);
				} // 시도 end
				
				/*
				for (Map<String, Object> map : upr_cd_list) {
					String upr_cd = String.valueOf(map.get("upr_cd"));
					List tmp = (List)pieData.get(upr_cd);
					for (Object object : tmp) {
						Map z = (Map)object;
						System.out.println("*"+upr_cd+" : " +z.get("upr_cd")+"\t"+z.get("sort")+"\t"+z.get("value"));
					}
				}
				System.out.println(pieData);
				*/
				
				// upr_cd sort 추가 + mapData2.put(upr_cd, map);
				mapData = setSort(mapData,"total");
				
				// mapData2
				for (Object object : mapData) {
					Map tmp = (Map)object;
					mapData2.put(tmp.get("upr_cd"), tmp);
				}
				Map outMap = new HashMap();
				outMap.put("mapData2", mapData2);
				outMap.put("mapData", mapData);
				outMap.put("pieData", pieData);
				createJsonStr(outMap);
				//System.out.println("["+dt+"] end*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*");
			//} // 시간 end
		}
	}
	
	public static void createJsonStr(Map<String,Object> map) {
		String outString = "";
		for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
			String key = (String) iterator.next();
			ObjectMapper om = new ObjectMapper();
	        try {
				String jsonStr = om.writeValueAsString(map.get(key));
				outString += "var "+key+"="+jsonStr+";\n";
				System.out.println("org " + key + "\t: "+ map.get(key) );
				System.out.println("prs " + key + "\t: "+ jsonStr );
			} catch (JsonGenerationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// 파일 출력
		try {
			FileUtils.writeFile(outString,path,fileNm);
			FileUtils.readFile(path+fileNm);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static List setSort(List list, String key){
		int[] idxArr = new int[list.size()];
		for (int i=0;i<list.size();i++) {
			idxArr[i] = i;
		}
		
		for (int i=1;i<idxArr.length;i++) {
			for (int j=0;j<idxArr.length-1;j++) {
				int v1 = Integer.parseInt(String.valueOf(((Map)list.get(idxArr[j])).get(key)));
				int v2 = Integer.parseInt(String.valueOf(((Map)list.get(idxArr[j+1])).get(key)));
				if (v1<v2) {
					int tmp = idxArr[j];
					idxArr[j] = idxArr[j+1];
					idxArr[j+1] = tmp;
				}
			}
		}
		
		int prev = -1;
		int cnt = -1;
		for (int i=0;i<idxArr.length;i++) {
			Map tmp = (Map)list.get(idxArr[i]);
			
			int value = Integer.parseInt(String.valueOf(((Map)list.get(idxArr[i])).get(key)));
			if(prev>-1 && value == prev){
				tmp.put("sort", cnt);
			} else {
				tmp.put("sort", ++cnt);
			}
			prev = value;
			
			list.set(idxArr[i],tmp);
		}
		
		return list;
	}
	
	public static List<Map<String, Object>> getUprCd() throws Exception {
		String jsonStr = "[{\"name\":\"강원도\",\"upr_cd\":\"6420000\",\"map_id\":\"42\"},{\"name\":\"경기도\",\"upr_cd\":\"6410000\",\"map_id\":\"41\"},{\"name\":\"광주광역시\",\"upr_cd\":\"6290000\",\"map_id\":\"29\"},{\"name\":\"대구광역시\",\"upr_cd\":\"6270000\",\"map_id\":\"27\"},{\"name\":\"대전광역시\",\"upr_cd\":\"6300000\",\"map_id\":\"30\"},{\"name\":\"부산광역시\",\"upr_cd\":\"6260000\",\"map_id\":\"26\"},{\"name\":\"서울특별시\",\"upr_cd\":\"6110000\",\"map_id\":\"11\"},{\"name\":\"세종특별자치시\",\"upr_cd\":\"5690000\",\"map_id\":\"36\"},{\"name\":\"울산광역시\",\"upr_cd\":\"6310000\",\"map_id\":\"31\"},{\"name\":\"인천광역시\",\"upr_cd\":\"6280000\",\"map_id\":\"28\"}]";
        return parseList(jsonStr);
	}
	
	public static List<Map<String, Object>> getUpkind() throws Exception {
		String jsonStr = "[{\"cd\":417000,\"name\":\"강아지\"},{\"cd\":422400,\"name\":\"고양이\"},{\"cd\":429900,\"name\":\"기타\"}]";
        return parseList(jsonStr);
	}
	
	public static List<Map<String, Object>> parseList(String jsonStr) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		 List<Map<String, Object>> readValue = null;
        try {
            readValue = objectMapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>() {});
        } catch (JsonParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (JsonMappingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return readValue;
	}
}
