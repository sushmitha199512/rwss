
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>


<%

		StringBuffer dcode =new StringBuffer(request.getParameter("dcode"));
        StringBuffer type = new StringBuffer(request.getParameter("type"));
       
        if(type.toString()!=null && type.toString().equals("sch")){
        	 type.delete(0,type.length());
        	type.append(" and  sm.SCHOOL_CATEGORY_CODE <>'01'");
        }else{
        	 type.delete(0,type.length());
        	type.append(" and  sm.SCHOOL_CATEGORY_CODE ='01'");
        }
        StringBuffer query =  new StringBuffer();
        StringBuffer selectedPrograms =  new StringBuffer(); 
        StringBuffer style =new StringBuffer(); 
    
        
		nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

		//22/08/2013
		//System.out.println("Server Date:"+w.getServerDate());

StringBuffer cYear=new StringBuffer();
cYear.append(w.getServerDate().substring(6,10));
StringBuffer currentMonth=new StringBuffer();
currentMonth.append(RwsUtils.getCurrentMont());  
if(currentMonth.toString()!=null&& !(currentMonth.toString().equals("APR") || currentMonth.toString().equals("MAY") || currentMonth.toString().equals("JUN")
		|| currentMonth.toString().equals("JUL")
		|| currentMonth.toString().equals("AUG")
		|| currentMonth.toString().equals("SEP")
		|| currentMonth.toString().equals("OCT")
		|| currentMonth.toString().equals("NOV")
		|| currentMonth.toString().equals("DEC")

		)){
			int tempYear=Integer.parseInt(cYear.toString());
			tempYear-=1;
			cYear.delete(0,cYear.length());
			cYear.append(String.valueOf(tempYear));
		}

	%>


<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script>
</head>
	<html>
	<body>
<table width="1004" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center">
<caption>
		<table  width="1004" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center">			
			<tr align="right">
               <td class="gridhdbg"><a href="#" onClick="window.close();">Close</a>
</td>
	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" >Coverage Habitations</td><td align="right" class="gridhdbg" ></td>
</tr>
</table>
<table   width="40%" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center" >
<tr align=center>
<td class=gridhdbg ><b>SNO   </b></td>
<td class=gridhdbg ><b>District</b></td>
<td class=gridhdbg ><b>Mandal</b></td>
<td class=gridhdbg ><b>Panchayath</b></td>
<td class=gridhdbg ><b>Village</b></td>
<td class=gridhdbg ><b>WorkID </b></td>
<td class=gridhdbg ><b>Work Name </b></td>
<td class=gridhdbg ><b>School Code </b></td>
<td class=gridhdbg ><b>School Name </b></td>
    
<td class=gridhdbg ><b>HabCode</b></td>  
<td class=gridhdbg ><b>HabName </b></td>
<td class=gridhdbg ><b>Coverage&nbsp;Status </b></td>  
  
</tr>

	<%try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       stmt1=conn.createStatement();
       selectedPrograms.append("'01','02','18','23','32','48','49','51','53','58','59','60','04','57','65','46','12'");
      
       query.append("select d.dname,ch.MNAME,ch.PNAME,ch.VNAME,b.work_id,ad.work_name,ch.PANCH_CODE ,ch.PANCH_NAME,ch.COVERAGE_STATUS,sm.school_code,sm.school_name from rws_work_admn_tbl a,RWS_WORK_SCHOOL_LNK_TBL b,RWS_SCHOOL_MASTER_TBL sm,rws_district_tbl d ,rws_complete_hab_view ch,rws_work_admn_tbl ad  where  d.dcode='"+dcode.toString()+"' and sm.hab_code=b.hab_code "+type.toString()+" and b.school_code=sm.school_code and  b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' )  and a.WORK_CANCEL_DT is null and ad.work_id=b.work_id and a.type_of_asset='11'  and ch.panch_code=b.hab_code and  a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2) and substr(a.work_id,1,2) in ("+selectedPrograms.toString()+")");
       
         rs1=stmt1.executeQuery(query.toString());
         int styleCount=0;
       while(rs1.next())
       {
    	   style.delete(0,style.length());
    	   if(styleCount%2==0){
    		   style.append("gridbg1");
  		     }else{
  			
  			 style.append("gridbg2");
			 }
			 styleCount++;
       	%>
			                                                
                <tr>
                
                <td  class=<%=style %> style="text-align: left;">&nbsp;<%=count++%> </td>
				<td  class=<%=style %> style="text-align: left;">&nbsp;<%=rs1.getString(1)%> </td>    
				<td  class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%>   </td>  
				<td  class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%>   </td>  
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(4)%>  </td> 
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(5)%>  </td>
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(6)%>  </td>
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(10)%>  </td>
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(11)%>  </td>
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(7)%>  </td>
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(8)%>  </td>
				<td  class=<%=style %> style="text-align: left;" ><%=rs1.getString(9)%>  </td>  
				</tr>
		<% 
           
       }
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
<script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Footer.js' />"></script>                                
 
</body>
</html>


