<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file="./conn.jsp"%>
<%@ page import = "nic.watersoft.works.WorksData1" %>


<script type="text/javascript">

</script>
<% 
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "sujala_impl_detail.xls");
%>


<%

ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null;
int count=1;


//String dname=(String)session.getAttribute("dname");
StringBuffer dname=new StringBuffer();
dname.append(session.getAttribute("dname"));


//String dist_code=(String)session.getAttribute("dcode");
StringBuffer dist_code=new StringBuffer();
dist_code.append(session.getAttribute("dcode"));

//String rvalue=(String)session.getAttribute("rvalue");
StringBuffer rvalue=new StringBuffer();
rvalue.append(session.getAttribute("rvalue"));


//String rvalue1=(String)session.getAttribute("rvalue1");
StringBuffer rvalue1=new StringBuffer();
rvalue1.append(session.getAttribute("rvalue1"));
%>

<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
</head>
<form name=f1>
<body bgcolor="#edf2f8">


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		


		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=15>Sujala Pathakam Implementation Details OF&nbsp;:&nbsp;&nbsp;<%=dname%>&nbsp;&nbsp; ON &nbsp;&nbsp;<%=rvalue%> &nbsp;&nbsp; To &nbsp;&nbsp;<%=rvalue1%><font color="blue"></font></td>	
		</tr>
		
<%

StringBuffer distcode=new StringBuffer();
StringBuffer dcode=new StringBuffer();
StringBuffer query=new StringBuffer();
int j=0;


try
{   
     distcode.append(String.valueOf(session.getAttribute("dcode")));
     //System.out.println("this is -distcode-..."+distcode.toString());
  
     dcode.append(String.valueOf(session.getAttribute("dcode")));
     
     
     int styleCount=0;
     String style="";
  
	%>
		   <tr align="center" bgcolor="#ffffff">
			<tr>	
			<td class=btext  align=center rowspan="3">Sl.No</td>
			<td class=btext  align=center rowspan="3">District</td>
			<td class=btext  align=center rowspan="3">Mandal</td>
			<td class=btext  align=center rowspan="3">Panchayat</td>
			<td class=btext  align=center rowspan="3">Village</td>
			<td class=btext  align=center rowspan="3">Habitation</td>
			<td class=btext  align=center rowspan="3">Implementation Date</td>
			<td class=btext  align=center rowspan="3">Plant Type Installed</td>
			<td class=btext  align=center rowspan="3">Plant Capacity</td>
			<td class=btext  align=center rowspan="3">Installation Agency Type</td>
			<td class=btext  align=center rowspan="3">Installation Agency Name</td>
			<td class=btext  align=center rowspan="3">Maintenance Agency Type</td>
			<td class=btext  align=center rowspan="3">Maintenance Agency Name</td>
			<!-- <td class=btext  align=center rowspan="3">Prepared By</td> -->
			<td class=btext  align=center rowspan="3">Update Date</td>
			
					

				</tr>
		<tr></tr>
		<tr></tr>
      <tr align="center">
            <td class=gridhdbg>1</td>	
			<td class=gridhdbg>2</td>	
			<td class=gridhdbg>3</td>
            <td class=gridhdbg>4</td>
			<td class=gridhdbg>5</td>
			<td class=gridhdbg>6</td>
			<td class=gridhdbg>7</td>
            <td class=gridhdbg>8</td>
            <td class=gridhdbg>9</td>
			<td class=gridhdbg>10</td>
            <td class=gridhdbg>11</td>
			<td class=gridhdbg>12</td>
			<td class=gridhdbg>13</td>
			<td class=gridhdbg>14</td>
            <!-- <td class=btext>15</td> -->
            
		</tr>
     
     <%
     //main qry
     Statement stmt8=null;
     ResultSet rs8=null;
     int sno=1;
     stmt8=conn.createStatement();
    

     
     query.delete(0,query.length());
     query.append("select dname,mname,pname,vname,panch_name,panch_code,to_char(IMPLEMENTATION_DT,'dd/mm/yyyy'),PLANT_TYPE_INSTALLED,PLANT_CAPACITY,INSTALLATION_AGENCY_TYPE,INSTALLATION_AGENCY_NAME,MAINTENANCE_AGENCY_TYPE,MAINTENANCE_AGENCY_NAME,PREPARED_BY,to_char(UPDATE_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_ntr_sujala_hab_impl_tbl b where a.panch_code=b.habitation_code and dcode='"+dcode.toString()+"' and b.IMPLEMENTATION_DT>=to_date('"+rvalue+"','dd-mm-yyyy') and b.IMPLEMENTATION_DT<=to_date('"+rvalue1+"','dd-mm-yyyy')");

  if(dcode.toString() !=null && !dcode.toString().equals(""))
  {
  	//qry+="and mcode='"+mcode+"'";
  	query.append("and dcode='"+dcode.toString()+"'");
  	
  }
  //qry+="order by dcode,mcode,pcode,vcode,panch_code";
  query.append("order by dcode,mcode,pcode,vcode,panch_code");
     
     
     
  	 
     rs8=stmt8.executeQuery(query.toString());
     while(rs8.next())
     {
     	
  		
    	
  	 if(styleCount%2==0){
  		 style="gridbg1";
  	 }else{
  		 style="gridbg2";
  	 }
  	 styleCount++;
  	
   	j++;
	
  	 
  %>
  	<tr>
  	
      <td class="<%=style%>" style="text-align: right;"> <%=sno++%></td>
     <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(1)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(2)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(3)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(4)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(5)%>/<br>&nbsp;<%=rs8.getString(6)%></br></td>

  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(7)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(8)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(9)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(10)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(11)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(12)%></td>
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(13)%></td>
 <!--  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(14)%></td> -->
  <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(15)%></td>
     
     
          
   
     	</tr>
     	<%
}
     if(j==0)
  	{%>
  	<tr>
  	<td colspan=14 align="center">No Records</td>
  	</tr>
  	
  	<%}
      
     
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>