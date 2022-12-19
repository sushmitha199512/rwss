<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

   
	%>
	<form>
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
					<td class="bwborder"><a href="./rws_lpcd_greatethan500_hab_excel.jsp">Excel</a></td></tr>
				
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class=gridhdbg colspan=8>Habitations having lpcd less than 50</font></td>	
	</tr>
		<tr >
		<td class=gridhdbg>Sl.No</td>
		<td class=gridhdbg>District</td>
		<td class=gridhdbg>Mandal</td>
		<td class=gridhdbg>Panchayath</td>
		<td class=gridhdbg>Village</td>
		<td class=gridhdbg>Hab Code</td>
		<td class=gridhdbg>Hab Name</td>
		<td class=gridhdbg>Lpcd Range</td>
</tr>



<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();
String householdzeroqry="select dname,mname,pname,vname,panch_code,panch_name,nvl(a.EXIST_WATER_LEVEL,0) from   RWS_HABITATION_DIRECTORY_TBL a,RWS_COMPLETE_HAB_VIEW b where a.hab_code=b.panch_code and nvl(a.EXIST_WATER_LEVEL,0)>500 order by dcode,mcode,pcode,vcode,panch_code";
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
<td class="<%=style %>" style="text-align: left;" ><%=rs1.getString(7) %></td>
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
</form>