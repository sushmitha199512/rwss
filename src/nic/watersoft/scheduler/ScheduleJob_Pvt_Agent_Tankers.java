package nic.watersoft.scheduler;

import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;

import nic.watersoft.commons.RwsOffices;

import org.json.JSONArray;
import org.json.JSONObject;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class ScheduleJob_Pvt_Agent_Tankers implements Job{
	public void execute(JobExecutionContext context)
            throws JobExecutionException { 
		PreparedStatement stmt = null;
	    Connection conn = null;
	    ResultSet rs = null;
	    Statement countST = null;
	    long tripId=0;
		try
		{	
			int[] distIds = {1,13,16,17,18};
			//1 = Kadapa
			//13 = Nellore
			//16 = Chitoor
			//17 = Anathapur
			//18 = Guntur
		
			System.out.println("In Private agency Service... :");
			  final Calendar cal = Calendar.getInstance();
			    //cal.add(Calendar.DATE, -1);
			    Date yesterDay = cal.getTime();
			    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		        String yesterDayDate = dateFormat.format(yesterDay);

		        conn = RwsOffices.getConn();
				conn.setAutoCommit(false);
				String countQry = "select count(1) from RWS_TANKER_MOVEMENT_PVT_TBL ";
				countST=conn.createStatement();
				rs = countST.executeQuery(countQry);
				if(rs.next())
					tripId = rs.getInt(1);
				rs.close();
				countST.close();
				double p = 0.017453292519943295,distance =0;    // Math.PI / 180
				String sql = "INSERT INTO RWS_TANKER_MOVEMENT_PVT_TBL(TANKER_REG_NO, TANKER_TRIP_START_DATE_TIME, SOURCE_CODE, TANKER_SOURCE_LAT, TANKER_SOURCE_LOG, TRIP_ID,DEST_HABITATION,TANKER_TRIP_END_DATE_TIME,TANKER_DEST_LAT,TANKER_DEST_LOG,TANKER_TRIP_DISTANCE,SOURCE_HAB_NAME,DEST_HAB_NAME,TRIP_STATUS,INSPECTION_STATUS,TANKER_ARIAL_DISTANCE)"
						+ " VALUES(?, TO_DATE(?,'yyyy-mm-dd HH24:MI:SS'), ?, ?, ?, ?,?,TO_DATE(?,'yyyy-mm-dd HH24:MI:SS'),?,?,?,?,?,?,?,?)";
				System.out.println("JSON data in string format pvt "+yesterDayDate);
				/*String dt = "01-01-2020";  // Start date
		        cal.setTime(dateFormat.parse(dt));
		        while(!dt.equals(yesterDayDate)){
		        	cal.add(Calendar.DATE, 1);  // number of days to add
			        dt = dateFormat.format(cal.getTime());  // dt is now the new date
			        System.out.println("Date in loop :"+dt);*/
			        
			        for(int i =0;i<distIds.length;i++){
			    		 conn.setAutoCommit(false);
			    		 URL url = new URL("http://aprws.in/rwsadmin/json.php?districtId="+distIds[i]+"&date="+yesterDayDate);
					     //   URL url = new URL("http://aprws.in/rwsadmin/json.php?districtId=13&date=07-07-2020");
						HttpURLConnection connHttp = (HttpURLConnection) url.openConnection();
						connHttp.setRequestMethod("GET");
						connHttp.setRequestProperty("Accept", "application/json");
						if (connHttp.getResponseCode() != 200) {
							throw new RuntimeException("Failed : HTTP error code : " + connHttp.getResponseCode());
						}
						Scanner sc = new Scanner(url.openStream());
						String inline = new String();
						while(sc.hasNext())
						{
						inline+=sc.nextLine();
						}
						
						System.out.println("in Schedular pvt tanker loop distIds :"+distIds[i]);
						sc.close();

				        stmt=conn.prepareStatement(sql);
				        //String destHab = null,sourceHab = null,distance;
						 JSONArray jsonArray = new JSONArray(inline);
						 for(int k =0;k<jsonArray.length();k++){   
						 //for (JSONObject object : jsonArray) { 
						      //  JSONObject jObj = (JSONObject)object;
							 try{
								 JSONObject jObj = jsonArray.getJSONObject(k);
							       // if(jObj.getString("source_habitation_code") != null && jObj.getString("source_habitation_code").trim().length()>0 ){
							        	tripId++;
								       // System.out.println("jObj :"+jObj);
								        //sourceHab = jObj.getString("source_habitation_code").trim().replaceAll("\\u00a0", "");//\\s
								        //destHab = jObj.getString("destination_habitation_code").trim().replaceAll("\\u00a0", "");//\\s
								       // distance = jObj.getString("distance").trim().replace(" km", "");
							        	if(jObj.isNull("vehicleno") || jObj.getString("vehicleno").isEmpty()){
								        	stmt.setString(1,"0");
							        	}
								        else{
								        stmt.setString(1, jObj.getString("vehicleno"));//.trim().replaceAll(" ", "")
								        }
							        	
							        	if(!jObj.isNull("start_time") && !jObj.getString("start_time").isEmpty()){
								        	stmt.setString(2,jObj.getString("start_time"));
							        	
							        	}
								      
								        
							        	if(!jObj.isNull("source_habitation_code") && !jObj.getString("source_habitation_code").isEmpty()){
							        	
							        		stmt.setString(3,jObj.getString("source_habitation_code"));//source_code -- .trim().replaceAll("\\u00a0", "")
								        	//stmt.setString(3,"0");
							        	}else stmt.setString(3,"0");
								       
								        if(!jObj.isNull("source_latitude") && !String.valueOf(jObj.get("source_latitude")).isEmpty() ){
								        	//stmt.setString(4,"0");
								        	stmt.setString(4,String.valueOf(jObj.get("source_latitude")));
								        }else stmt.setString(4,"0");
								        if(!jObj.isNull("source_longitude") && !String.valueOf(jObj.get("source_longitude")).isEmpty() ){
								        	//stmt.setString(5,"0");
								        	stmt.setString(5,String.valueOf(jObj.get("source_longitude")));
								        }else stmt.setString(5,"0");
								        stmt.setString(6,String.valueOf(tripId));//trip_id
								        
								        if(jObj.isNull("destination_habitation_code") ){
								        	stmt.setString(7,null);
								        }else
								        stmt.setString(7,jObj.getString("destination_habitation_code"));//.trim().replaceAll("\\u00a0", "")
								        
								        if(jObj.isNull("end_time") || jObj.getString("end_time").isEmpty()){
								        	stmt.setString(8,null);
								        }else
								        stmt.setString(8,jObj.getString("end_time"));
								        
								        if(jObj.isNull("destination_latitude") ){
								        	stmt.setString(9,null);
								        }else{
								        stmt.setString(9,String.valueOf(jObj.get("destination_latitude")));
								        }
								        if(jObj.isNull("destination_longitude") ){
								        	stmt.setString(10,null);
								        }else{
								        stmt.setString(10,String.valueOf(jObj.get("destination_longitude")));
								        }
								        if(jObj.isNull("distance") ){//|| jObj.getString("distance").isEmpty()
								        	stmt.setString(11,null);
								        }else{
								        stmt.setString(11,jObj.getString("distance").trim().replace(" km", ""));
								        }
								        if(jObj.isNull("source_habitation") ){//|| jObj.getString("source_habitation").isEmpty()
								        	stmt.setString(12,null);
								        }else{
								        stmt.setString(12,jObj.getString("source_habitation"));
								        }
								        if(jObj.isNull("destination_habitation") ){//|| jObj.getString("destination_habitation").isEmpty()
								        	stmt.setString(13,null);
								        }else{
								        stmt.setString(13,jObj.getString("destination_habitation"));
								        }
								        if(!jObj.isNull("trip_status") && !jObj.getString("trip_status").isEmpty()){
								        stmt.setString(14,jObj.getString("trip_status"));
								        }else stmt.setString(14,null);
								        
								        if(!jObj.isNull("inspection_status") && !jObj.getString("inspection_status").isEmpty()){
								        stmt.setString(15,jObj.getString("inspection_status"));
								        }else stmt.setString(15,null);
								        //double c = Math.cos();
								        distance =0;
								        if(!jObj.isNull("destination_latitude") && !String.valueOf(jObj.get("destination_latitude")).isEmpty() && !jObj.isNull("destination_longitude") && !String.valueOf(jObj.get("destination_longitude")).isEmpty() && !jObj.isNull("source_latitude") && !String.valueOf(jObj.get("source_latitude")).isEmpty() && !jObj.isNull("source_longitude") && !String.valueOf(jObj.get("source_longitude")).isEmpty()){
								        double a = 0.5 - Math.cos(((jObj.getDouble("destination_latitude") - jObj.getDouble("source_latitude")) * p))/2 +
								                Math.cos((jObj.getDouble("source_latitude") * p)) * Math.cos((jObj.getDouble("destination_latitude") * p)) *
								                        (1 - Math.cos(((jObj.getDouble("destination_longitude") - jObj.getDouble("source_longitude")) * p)))/2;

								       // Math.asin(Math.sqrt(a));// 2 * R; R = 6371 km
								        distance = 12742 * Math.asin(Math.sqrt(a));
								        DecimalFormat df = new DecimalFormat("0.000");
								        distance = Double.parseDouble(df.format(distance));
								        
								        }
								        stmt.setString(16,String.valueOf(distance));
								        /*JSONArray imgArray = jObj.getJSONArray("images");

								        String modifiedCtxPath = "E:\\WorkSpace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\PrivateTankerImages";
										 String rootDir = modifiedCtxPath+ File.separator +"TankerImages"+ File.separator +"2020"+ File.separator +"09"+ File.separator +"27" ;
										//String rootDir = modifiedCtxPath +"TankerImages"+ File.separator +year+ File.separator +month+ File.separator +day ;
										////System.out.println("commonPath insp :" + modifiedCtxPath);
										
										File myFilesDir = new File(rootDir);
										if (!myFilesDir.exists())
											myFilesDir.mkdirs();
										
										//String imagePath=context.getRealPath("/")+"TankerImages"+ File.separator + year + File.separator + month + File.separator + day;
										rootDir = rootDir + File.separator ;
										
										File filepath = new File(rootDir);
								        //System.out.println("img url :"+imgArray.getString(0));
								       // System.out.println("imagePath----"+filepath+ File.separator+tripId+"image.jpg");
								        try(InputStream in = new URL(imgArray.getString(0)).openStream()){
								            Files.copy(in, Paths.get(filepath+ File.separator+tripId+"image.jpg"));
								        }*/
								    
								        stmt.addBatch();
						 	
							 }catch(Exception e){
								 e.printStackTrace();
							 }
						    }
						    int[] inserted = stmt.executeBatch();
						    conn.setAutoCommit(true);
						    stmt.close();
			    	 }
			        
		        //}
			    //stmt.close();
		        conn.close();
	    } catch (BatchUpdateException e) {
	    	e.printStackTrace();
	        System.out.println("Batch has managed to process {} entries"+ e.getUpdateCounts().length);
	        
	}catch(Exception e){
	    	e.printStackTrace();
	    	}
		
	}

}
