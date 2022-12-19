<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="./conn.jsp"%>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
%>
<script type="text/javascript">
function fnSubmit()
{
   var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
                //alert("hai if");
				alert("Please Select District");
				return false;
			}
           if(document.f1.demo1.value=='')
			{
                //alert("hai if");
				alert("Please Select From Implementation Date");
				return false;
			}
          if(document.f1.demo2.value=='')
			{
                //alert("hai if");
				alert("Please Select To Implementation Date");
				return false;
			} 
			else
			{
                //alert("hai else");
				if(loggedUser=="admin"||loggedUser=="100000"||loggedUser=="1000DR")
				{
                 //alert("hai else if ");
				document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
				 //alert(document.f1.dname1.value);        
				}
				
				else
				{    //alert("hai else else");
					document.f1.dname1.value = document.f1.district1.value;
				    alert(document.f1.dname1.value); 
				}
                //alert("....hai....."+document.f1.dname1.value);
                var d=document.getElementById('demo1').value;
                var d1=document.getElementById('demo2').value;//date value
                document.f1.mydate.value=d; 
                document.f1.mydate1.value=d1; 
    			//document.f1.action="./rws_ntr_sujala_impl_detail_rpt.jsp";
    			document.f1.action="./rws_ntr_sujala_impl_detail_frm.jsp";
				  //alert("hai");
				document.f1.submit();
			}		
  

}
</script>
<%

ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null;
int count=1;

//first time display purpose
//String s;
StringBuffer s=new StringBuffer();
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
//s = formatter.format(date);
s.append(formatter.format(date));
StringBuffer currentdate=new StringBuffer(s.toString().replace("/","-"));
//System.out.println("current"+currentdate);



StringBuffer rvalue=new StringBuffer();
rvalue.append(request.getParameter("mydate"));
if(rvalue!=null){
session.setAttribute("rvalue",rvalue.toString());
}
if(rvalue==null || rvalue.toString().equals("null")){
	rvalue.delete(0,rvalue.length());	
rvalue.append(currentdate);
}
//System.out.println("rvalue........"+rvalue);



StringBuffer rvalue1=new StringBuffer();
rvalue1.append(request.getParameter("mydate1"));
if(rvalue1!=null){
session.setAttribute("rvalue1",rvalue1.toString());
}
if(rvalue1==null || rvalue1.toString().equals("null")){
	rvalue1.delete(0,rvalue1.length());	
	rvalue1.append(currentdate);
}
//System.out.println("rvalue1........"+rvalue1);







StringBuffer dname=new StringBuffer();
dname.append(request.getParameter("dname1"));
if(dname!=null){
session.setAttribute("dname",dname.toString());
}


StringBuffer dist_code=new StringBuffer();
dist_code.append(String.valueOf(session.getAttribute("dcode")));
if(dist_code!=null){
session.setAttribute("distcode",dist_code.toString());
}
//System.out.println("this is distcode..."+dist_code);
%>

<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
</head>
<form name=f1>
<body bgcolor="#edf2f8">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="30%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
    <caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
   <!-- <tr bgcolor="#8A9FCD" align="center"> -->
   
   <tr bgcolor="#4B708B" align="center">
		<td align="center" class="gridhdbg" colspan=3>Sujala Pathakam Implementation Details report</td>	
	</tr>
 <%
 StringBuffer dcode=new StringBuffer();
 StringBuffer divcode=new StringBuffer();
 StringBuffer dcode1=new StringBuffer();
 StringBuffer divcode1=new StringBuffer();

 StringBuffer query=new StringBuffer();
 
 try{
    dcode.append(request.getParameter("district1"));
    //System.out.println("this is dcode..."+dcode.toString());
    session.setAttribute("dcode",dcode.toString());
  	
	divcode.append(request.getParameter("division"));
	dcode1.append(request.getParameter("district1"));
	divcode1.append(request.getParameter("division"));
  %>
 
 
 
<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST)||loggedUser.toString().equals(Constants.DROUGHT_USER)||loggedUser.toString().equals(Constants.SEC_USER)))
		{
		%>
			<SELECT name="district1" id="combo" class="mycombo" style="width:150px" >
			<option value="">SELECT</option>
		<%
			stmt = conn.createStatement();
			query.append("SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname");
	        rs = stmt.executeQuery(query.toString());
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode1.toString()))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
		}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			query.delete(0,query.length());
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.toString().substring(1,3)+"'");
			rs = stmt.executeQuery(query.toString());
			if(rs.next())
			{
				dcode1.append(rs.getString(1));
	%>
				<input type="text" name="dname1" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district1" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
 <tr><td class=rptLabel>Implementation From Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="10" value="<%=rvalue%>">
       <a href="javascript:NewCal('demo1','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td></tr>
<tr>
<td class=rptLabel>Implementation To Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo2" type="text" size="10" value="<%=rvalue1%>">
       <a href="javascript:NewCal('demo2','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
    </tr> 
 
 <tr bgcolor="#4B708B" align="center"> 
		 <!--<tr bgcolor="#F7F2E0" align="center">#8A9FCD-->
		
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
  </table>

<%
}
catch(Exception e1)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }

%>
  

<input type="hidden" name="mydate">
<input type="hidden" name="mydate1">
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="dname1">



<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="../home.jsp">Home</a>|
					<a href="./rws_ntr_sujala_impl_detail_xls.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
  


		<!-- <tr bgcolor="#8A9FCD" align="center"> -->
		<tr bgcolor="#F7F2E0" align="center">
			<td align="center" class="rptHeading" colspan=15>Sujala Pathakam Implementation Details OF&nbsp;:&nbsp;&nbsp;<%=dname%>&nbsp;&nbsp; ON &nbsp;&nbsp;<%=rvalue%> &nbsp;&nbsp; To &nbsp;&nbsp;<%=rvalue1%><font color="blue"></font></td>	
		</tr>
		
<%
int j=0;
StringBuffer distcode=new StringBuffer();

try
{   
     distcode.append(String.valueOf(session.getAttribute("dcode")));
     //System.out.println("this is dcode..."+distcode.toString());
     
     
     int styleCount=0;
     String style="";
  
	%>
		   <tr align="center" bgcolor="#ffffff">
			<tr>	
			<td class=gridhdbg   align=center rowspan="3">Sl.No</td>
			<td class=gridhdbg  align=center rowspan="3">District</td>
			<td class=gridhdbg  align=center rowspan="3">Mandal</td>
			<td class=gridhdbg  align=center rowspan="3">Panchayat</td>
			<td class=gridhdbg  align=center rowspan="3">Village</td>
			<td class=gridhdbg  align=center rowspan="3">Habitation</td>
			<td class=gridhdbg  align=center rowspan="3">Implementation Date</td>
			<td class=gridhdbg  align=center rowspan="3">Plant Type Installed</td>
			<td class=gridhdbg  align=center rowspan="3">Plant Capacity</td>
			<td class=gridhdbg  align=center rowspan="3">Installation Agency Type</td>
			<td class=gridhdbg  align=center rowspan="3">Installation Agency Name</td>
			<td class=gridhdbg  align=center rowspan="3">Maintenance Agency Type</td>
			<td class=gridhdbg  align=center rowspan="3">Maintenance Agency Name</td>
			<!-- <td class=btext  align=center rowspan="3">Prepared By</td> -->
			<td class=gridhdbg  align=center rowspan="3">Update Date</td>
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