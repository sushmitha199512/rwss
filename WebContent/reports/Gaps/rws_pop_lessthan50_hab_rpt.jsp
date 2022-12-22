<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	int popgreater=0,poplesser=50;
	if(request.getParameter("popgr")!=null && !request.getParameter("popgr").equals("")){
popgreater=Integer.parseInt(request.getParameter("popgr"));}
	if(request.getParameter("pople")!=null && !request.getParameter("pople").equals("")){
poplesser=Integer.parseInt(request.getParameter("pople"));}
//System.out.println(popgreater+"--"+poplesser);
   session.setAttribute("popgreater",popgreater);
   session.setAttribute("poplesser",poplesser);
	%>
	<html>
	<head>
	<script type="text/javascript">
	function getvalues1(){
		//alert("this is first");
		var popgre='<%=popgreater%>';
		var poplee='<%=poplesser%>';
		var popgr=document.getElementById("popgr");
		var pople=document.getElementById("pople");
		popgr.setAttribute("value",popgre);
		pople.setAttribute("value",poplee);
		}
	function getvalues(){
var popgr=parseInt(document.getElementById("popgr").value);
var pople=parseInt(document.getElementById("pople").value);
if(popgr>pople)
{
	alert("left side population value should be less than right side population");
return false;
	}else{
		document.f1.action="./rws_pop_lessthan50_hab_rpt.jsp";
		document.f1.submit();
		}
		}
	</script>
	</head>
	<body onload="getvalues1()">
		<form name="f1">
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		
			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td>
				<td class="bwborder"><a href="./rws_pop_lessthan50_hab_excel.jsp">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	
	</table>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="30%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
	<tr><td class=gridhdbg>Population>=<input type="text" name="popgr" id="popgr" size="6" onkeypress="return decimalsOnly(event)"/></td><td class=gridhdbg>Population<=<input type="text" size="6" name="pople" id="pople" onkeypress="return decimalsOnly(event)"/></td><td class=gridhdbg><input type="button" value="submit" onclick="getvalues()"/></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class=gridhdbg colspan=11>Habitations having population greater than <%=popgreater %> and less than <%=poplesser %></font></td>	
	</tr>
		<tr >
		<td class=gridhdbg>Sl.No</td>
		<td class=gridhdbg>District</td>
		<td class=gridhdbg>Mandal</td>
		<td class=gridhdbg>Panchayath</td>
		<td class=gridhdbg>Village</td>
		<td class=gridhdbg>Hab Code</td>
		<td class=gridhdbg>Hab Name</td>
		<td class=gridhdbg>Plain Population</td>
		<td class=gridhdbg>SC Population</td>
		<td class=gridhdbg>ST Population</td>
		<td class=gridhdbg>Total Population</td>
		
</tr>



<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();
String householdzeroqry="select dname,mname,pname,vname,panch_code,panch_name,nvl(a.CENSUS_PLAIN_POPU,0),nvl(a.CENSUS_ST_POPU,0),nvl(a.CENSUS_SC_POPU,0) from   RWS_HABITATION_DIRECTORY_TBL a,RWS_COMPLETE_HAB_VIEW b where a.hab_code=b.panch_code and (nvl(a.CENSUS_PLAIN_POPU,0)+nvl(a.CENSUS_ST_POPU,0)+nvl(a.CENSUS_SC_POPU,0))>="+popgreater+" and (nvl(a.CENSUS_PLAIN_POPU,0)+nvl(a.CENSUS_ST_POPU,0)+nvl(a.CENSUS_SC_POPU,0))<="+poplesser+" order by dcode,mcode,pcode,vcode,panch_code";
System.out.println("qry is:"+householdzeroqry);
rs1=stmt2.executeQuery(householdzeroqry);
int styleCount=0;
String dname="",mname="",pname="",vname="";
String tdname="",tmname="",tpname="",tvname="";
String style="";
System.out.println("qry is:"+householdzeroqry);
while(rs1.next()){
	
	if(dname.equals(rs1.getString(1))||tdname.equals(rs1.getString(1))){
 	   dname="-";
    }else{
 	   dname=rs1.getString(1);
    }
	
	if(mname.equals(rs1.getString(2))||tmname.equals(rs1.getString(2))){
		mname="-";
	    }else{
	    	mname=rs1.getString(2);
	    }
	if(pname.equals(rs1.getString(3))||tpname.equals(rs1.getString(3))){
		pname="-";
	    }else{
	    	pname=rs1.getString(3);
	    }
	if(vname.equals(rs1.getString(4))||tvname.equals(rs1.getString(4))){
		vname="-";
	    }else{
	    	vname=rs1.getString(4);
	    }
	if(styleCount%2==0){
		 style="gridbg1";
	}else{
		 style="gridbg2";
	}
	styleCount++;
	%>
	<tr>
<td class="<%=style %>" style="text-align: left;" ><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" ><%=dname %></td>
<td class="<%=style %>" style="text-align: left;" ><%=mname %></td>
<td class="<%=style %>" style="text-align: left;" ><%=pname %></td>
<td class="<%=style %>" style="text-align: left;" ><%=vname %></td>
<td class="<%=style %>" style="text-align: left;" ><%=rs1.getString(5) %></td>
<td class="<%=style %>" style="text-align: left;" ><%=rs1.getString(6) %></td>
<td class="<%=style %>" style="text-align: left;" ><%=rs1.getInt(7) %></td>
<td class="<%=style %>" style="text-align: left;" ><%=rs1.getInt(9) %></td>
<td class="<%=style %>" style="text-align: left;" ><%=rs1.getInt(8) %></td>
<td class="<%=style %>" style="text-align: left;" ><%=rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9) %></td>
</tr>
	<%

	tdname=rs1.getString(1);
	tmname=rs1.getString(2);
	tpname=rs1.getString(3);
	tvname=rs1.getString(4);
}
if(stmt2!=null){
	stmt2.close();
}
	if(rs1!=null){
		rs1.close();
	}

}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</form></body></html>