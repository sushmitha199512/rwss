<%-- 
    Document   : imageupload
    Created on : 7 Jan, 2017, 10:25:31 AM
    Author     : RWSS_DPT1
--%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.sql.*"%>
<%@ include file="/reports/conn.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
   
    <body>
        <%
        PreparedStatement pre,ps1;
        ps=null;pre=null;ps1=null;
      	ResultSet rs1;
      	rs=null;rs1=null;
  		int n=0;
  		String realPath = request.getRealPath("");
  		
  		out.println("realPath:"+realPath);
        try{ 
        	
        	 int s=0;  
        	
        	String Query="select a.ASSET_CODE,b.HP_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_HP_SUBCOMP_PARAM_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.HP_CODE and substr(b.HP_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.SOURCE_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_SOURCE_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.SOURCE_CODE and substr(b.SOURCE_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.SHALLOWHP_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_SHALLOWHANDPUMPS_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.SHALLOWHP_CODE and substr(b.SHALLOWHP_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.CISSC_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_AST_CIS_SC_PARAM_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.CISSC_CODE and substr(b.CISSC_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.GLBR_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_AST_GLBR_SC_PARAM_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.GLBR_CODE and substr(b.GLBR_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.GLSR_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_AST_GLSR_SC_PARAM_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.GLSR_CODE and substr(b.GLSR_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.OHBR_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_AST_OHBR_SC_PARAM_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.OHBR_CODE and substr(b.OHBR_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.OHSR_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_AST_OHSR_SC_PARAM_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.OHSR_CODE and substr(b.OHSR_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.OPENWELL_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_OPEN_WELL_MAST_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.OPENWELL_CODE and substr(b.OPENWELL_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.POND_CODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_OPENWELL_POND_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.POND_CODE and substr(b.POND_CODE,1,2)='13'"
        		 +" UNION select a.ASSET_CODE,b.SUMPCODE as SOURCE_CODE,bf.LATITUDE,bf.LONGITUDE,bf.IMAGEFILENAME, bf.IMAGEFOLDER,SurveyDate from rws_bluefrog_asset_comp_tbl bf,RWS_ASSET_MAST_TBL a,RWS_AST_SUMP_M_SC_PARAM_TBL b where bf.ASSETCODE=a.ASSET_CODE and bf.ASSETCODE=b.ASSET_CODE and bf.SOURCECODE=b.SUMPCODE and substr(b.SUMPCODE,1,2)='13'"
        		 +" ";
        	        	
        	ps=conn.prepareStatement(Query);
        	rs=ps.executeQuery();
        	while(rs.next()){
        		s=0;
        		String folder=rs.getString("IMAGEFOLDER");
    			String ar[]=folder.split("\\\\");
    			String finalFolder=ar[0]+"/"+ar[1];
        		///usr/local/tomcat1/blue-frog-ap/SRIKAKULAM
        		StringBuffer filepath=new  StringBuffer();
        		/* System.out.println(filepath.length());
        		if(filepath.length()>0){
        			filepath.append("");
        		} */
        			 filepath.append(realPath);
        			 filepath.append("/blue-frog-ap/");
        			 filepath.append(finalFolder.trim());
        			 filepath.append("/");
        			 String imgpath=rs.getString("IMAGEFILENAME").trim();
        			 filepath.append(imgpath+".jpg");
        			 //filepath=filepath+rs.getString("IMAGEFILENAME")+".jpg";
        	    	//System.out.println("realPath :"+realPath);
        			//System.out.println("Image folder :"+folder);
        			//System.out.println("final folder :"+finalFolder);
        			
        		   //  System.out.println("Image filename :"+rs.getString("IMAGEFILENAME"));
        		    //System.out.println("filepath"+filepath);
        		    %>

               		

               		<%
        			//System.out.println(request.getRealPath(""));
        			File imgfile = new File(filepath.toString());
        			
        			if(imgfile.exists()){
        			String q="select ASSET_CODE,ASSET_COMPONENT from RWS_ASSET_COMPONENT_IMAGE_TBL where ASSET_CODE='"+rs.getString(1)+"' and ASSET_COMPONENT='"+rs.getString(2)+"'";
        			ps1=conn.prepareStatement(q);
        			
        			rs1=ps1.executeQuery();
        			
        			if(rs1.next()){
        				
        			}
        			else{
        			
        			pre = conn.prepareStatement("insert into RWS_ASSET_COMPONENT_IMAGE_TBL (ASSET_CODE,ASSET_COMPONENT,COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE) values(?,?,?,?,?,to_date(?,'dd-mm-yyyy'),?,?)");
        			pre.setString(1,rs.getString(1));
        			pre.setString(2,rs.getString(2));
        			FileInputStream fin = new FileInputStream(imgfile);
        			pre.setBinaryStream(3, fin, (int)(imgfile.length()));
        			pre.setString(4,rs.getString(3));
        			pre.setString(5,rs.getString(4));
        			pre.setString(6,rs.getString("SurveyDate"));
        			pre.setString(7,"0");
        			pre.setString(8,"Bluefrog");
        		   s = pre.executeUpdate();
        		 
        		   pre.close();
        		   n++;
        		   if(n%100==0){
        			   
        		   
        		   %>

           		<b><font color="Blue">

           		<% out.println("uploaded count "+n); %>
           		<br/>

           		</font></b>

           		<%
        		   }
        			}
        			ps1.close();
                	rs1.close();
        			}
        			else{
        				%>

                		<b><font color="Blue">

                		<% out.println("File not Exist"); %>
						<br/>
                		</font></b>

                		<%
        			}
        	if(s>0) {

        		%>

        		<b><font color="Blue">

        		<% //out.println("Image Uploaded successfully !"); %>

        		</font></b>

        		<%

        		}

        		else {

        		out.println("unsucessfull to upload image.");
        		%>
        		<br/>
        		<%
        		}
        	
			
        	}
        	ps.close();
        	rs.close();
        	%>

    		<b><font color="Blue">

    		<% 
    		//System.out.println(n+" Images Uploaded successfully !");
    		out.println(n+" Images Uploaded successfully !"); %>
			<br/>
    		</font></b>

    		<%

        }
        
        catch(Exception e){
 		   System.out.println("EXCEPTION "+e.getMessage());
 		   e.printStackTrace();
 	  }
        finally{
        	if(conn!=null){
        	conn.close();
			}
        }
 	 
 	 
 	%>

    </body>
</html>
