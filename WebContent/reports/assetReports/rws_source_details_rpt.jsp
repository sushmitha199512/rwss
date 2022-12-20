<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>


<form>
<%
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
System.out.println("dcode**********" +dcode);
String source=request.getParameter("sourcetype");
session.setAttribute("source",source);
String mcode=request.getParameter("mandal");
if(mcode!=null){
	session.setAttribute("mcode",mcode);
}

String pcode=request.getParameter("panchayath");
if(pcode!=null){
	session.setAttribute("pcode",pcode);
}

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

   
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="100%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_source_details_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >Source Details</td>
	</tr>
    
	</table>
   
   <table width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <% if(source.equals("source")){ %>
	<tr>
	
	<td class=gridhdbg>Sl.No</td>
	<td class=gridhdbg>District</td>
	<td class=gridhdbg>Mandal</td>
	<td class=gridhdbg>Panchayat</td>
	<td class=gridhdbg>Village</td>
	<td class=gridhdbg>Hab code/Hab Name</td>
    <td class=gridhdbg>Source Code</td>
    <td class=gridhdbg>Source Type</td>
    <td class=gridhdbg>Source Name</td>
    <td class=gridhdbg>Location</td>
    <td class=gridhdbg>Safe LPD</td> 
    <td class=gridhdbg>UnSafe LPD</td> 
	<td class=gridhdbg>Flouride</td>
	<td class=gridhdbg>Brakish</td>
    <td class=gridhdbg>Iron</td>
    <td class=gridhdbg>Nitrate</td>
    <td class=gridhdbg>Latitude</td>
    <td class=gridhdbg>Longitude</td>
    <td class=gridhdbg>Way Point</td>
    
	</tr>
	<%} %>
    <% if(source.equals("hp")){ %>
	<tr>
	
	<td class=gridhdbg>Sl.No</td>
	<td class=gridhdbg>District</td>
	<td class=gridhdbg>Mandal</td>
	<td class=gridhdbg>Panchayat</td>
	<td class=gridhdbg>Village</td>
	<td class=gridhdbg>Hab code/Hab Name</td>
    <td class=gridhdbg>HP Code</td>
    
    <td class=gridhdbg>Location</td>
    <td class=gridhdbg>Safe LPD</td> 
    <td class=gridhdbg>UnSafe LPD</td> 
	<td class=gridhdbg>Flouride</td>
	<td class=gridhdbg>Brakish</td>
    <td class=gridhdbg>Iron</td>
    <td class=gridhdbg>Nitrate</td>
    <td class=gridhdbg>Latitude</td>
    <td class=gridhdbg>Longitude</td>
    <td class=gridhdbg>Way Point</td>
	</tr>
	<%} %> 
	<% if(source.equals("ow")){ %>
	<tr>
	
	<td class=gridhdbg>Sl.No</td>
	<td class=gridhdbg>District</td>
	<td class=gridhdbg>Mandal</td>
	<td class=gridhdbg>Panchayat</td>
	<td class=gridhdbg>Village</td>
	<td class=gridhdbg>Hab code/Hab Name</td>
    <td class=gridhdbg>Open Well Code</td>
    
    <td class=gridhdbg>Location</td>
    <td class=gridhdbg>Safe LPD</td> 
    <td class=gridhdbg>UnSafe LPD</td> 
	<td class=gridhdbg>Flouride</td>
	<td class=gridhdbg>Brakish</td>
    <td class=gridhdbg>Iron</td>
    <td class=gridhdbg>Nitrate</td>
    <td class=gridhdbg>Latitude</td>
    <td class=gridhdbg>Longitude</td>
    <td class=gridhdbg>Way Point</td>
	</tr>
	<%} %>    
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   if(source.equals("source")){
   
qry="select SOURCE_CODE,nvl(SOURCE_NAME,'-'),nvl(LOCATION,'-') ,nvl(SAFE_LPD,0),nvl(UNSAFE_LPD,0),nvl(FLOURIDE,0),nvl(BRAKISH,0),nvl(IRON,0),nvl(NITRATE,0),nvl(LATITUDE,0),nvl(longitude,0),nvl(WAY_POINT,0),dname,mname,pname,vname,panch_code,panch_name,c.source_type_name from rws_source_tbl a,rws_complete_hab_view b,rws_source_type_tbl c where dcode='"+dcode+"' and ((safe_lpd is not null and nvl(safe_lpd,0)>0) or (unsafe_lpd is not null and nvl(unsafe_lpd,0)>0)) and substr(SOURCE_CODE,1,16)=b.panch_code and a.source_type_code=c.source_type_code ";
if(mcode !=null && !mcode.equals(""))
{
	qry+=" and substr(SOURCE_CODE,6,2)='"+mcode+"' ";
}
if(pcode !=null && !pcode.equals(""))
{
	qry+=" and substr(SOURCE_CODE,13,2)='"+pcode+"' ";
}

qry+=" order by substr(SOURCE_CODE,6,2),substr(SOURCE_CODE,13,2),source_code";
   }
   if(source.equals("hp")){
	   
	   qry="select HP_CODE,nvl(LOCATION,'-') ,nvl(SAFE_LPD,0),nvl(UNSAFE_LPD,0),nvl(FLOURIDE,0),nvl(BRAKISH,0),nvl(IRON,0),nvl(NITRATE,0),nvl(LATITUDE,0),nvl(longitude,0),nvl(WAY_POINT,0),dname,mname,pname,vname,panch_code,panch_name from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_view b where dcode='"+dcode+"' and ((safe_lpd is not null and nvl(safe_lpd,0)>0) or (unsafe_lpd is not null and nvl(unsafe_lpd,0)>0)) and substr(HP_code,1,16)=b.panch_code ";
	   if(mcode !=null && !mcode.equals(""))
	   {
	   	qry+=" and substr(HP_CODE,6,2)='"+mcode+"' ";
	   }
	   if(pcode !=null && !pcode.equals(""))
	   {
	   	qry+=" and substr(HP_CODE,13,2)='"+pcode+"' ";
	   }      
	   qry+=" order by substr(HP_CODE,6,2),substr(HP_CODE,13,2),HP_CODE";
   }
 if(source.equals("ow")){
	   
	   qry="select OPENWELL_CODE,nvl(LOCATION,'-') ,nvl(SAFE_LPD,0),nvl(UNSAFE_LPD,0),nvl(FLOURIDE_PER,0),nvl(BRAKISH_PER,0),nvl(IRON_PER,0),nvl(NITRATE,0),nvl(LATITUDE,0),nvl(longitude,0),nvl(WAY_POINT,0),dname,mname,pname,vname,panch_code,panch_name from RWS_OPEN_WELL_MAST_TBL a,rws_complete_hab_view b where dcode='"+dcode+"' and ((safe_lpd is not null and nvl(safe_lpd,0)>0) or (unsafe_lpd is not null and nvl(unsafe_lpd,0)>0)) and substr(OPENWELL_CODE,1,16)=b.panch_code ";
	    
	   if(mcode !=null && !mcode.equals(""))
	   {
	   	qry+=" and substr(OPENWELL_CODE,6,2)='"+mcode+"' ";
	   }
	   if(pcode !=null && !pcode.equals(""))
	   {
	   	qry+=" and substr(OPENWELL_CODE,13,2)='"+pcode+"' ";
	   }      
	   qry+=" order by substr(OPENWELL_CODE,6,2),substr(OPENWELL_CODE,13,2),OPENWELL_CODE";
 }
   //System.out.println("qry is="+qry);
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
   	
		String sourceTypeName=rs8.getString(19);
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 if(source.equals("source")){
%>

	<tr>
	
    <td class="<%=style%>"style="text-align: right;"> <%=sno++%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(13)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(14)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(15)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(16)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(17)%>/<%=rs8.getString(18)%></td>
   <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(1)%></td>
   <td  class="<%=style%>" style="text-align: left;"><%=sourceTypeName %></td>
   
   <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(2)%></td>
   <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(3)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(4)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(5)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(6)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(7)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(8)%></td>
<td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(9)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(10)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(11)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(12)%></td>
   
        
 
   	</tr>
   	
   	
<%
}if(source.equals("hp")){
	%>
<tr>
	
    <td class="<%=style%>"style="text-align: right;"> <%=sno++%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(12)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(13)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(14)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(15)%></td>
   
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(16)%>/<%=rs8.getString(17)%></td>
   <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(1)%></td>
   <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(2)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(3)%></td>
      <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(4)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(5)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(6)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(7)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(8)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(9)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(10)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(11)%></td>

   
        
 
   	</tr><%
}
if(source.equals("ow")){
	%>
<tr>
	
    <td class="<%=style%>"style="text-align: right;"> <%=sno++%></td>
     <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(12)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(13)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(14)%></td>
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(15)%></td>
   
    <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(16)%>/<%=rs8.getString(17)%></td>
   <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(1)%></td>
   <td  class="<%=style%>" style="text-align: left;"><%=rs8.getString(2)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(3)%></td>
      <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(4)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(5)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(6)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(7)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(8)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(9)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getDouble(10)%></td>
   <td  class="<%=style%>" style="text-align: right;"><%=rs8.getInt(11)%></td>

   
        
 
   	</tr><%
}
   
   }
if(rs8!=null){
	rs8.close();
}
if(stmt8!=null){
	stmt8.close();
}
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
</p>