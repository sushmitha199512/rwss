<%@ include file="conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<html>
<body>
<%
 String habcode=request.getParameter("habcode");
 //System.out.println("habcode:"+habcode);
String val=request.getParameter("value");
String type=request.getParameter("type");
%>
<%
if(type!=null && type.equals("1"))
{
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr class=rptLabel><%=val%></tr>
<tr>
<td class=btext>SNO</td>
<td class=btext>Source Code-Source Name</td>
<td class=btext>Brakish</td>
<td class=btext>Flouride</td>
<td class=gridhdbg>Iron</td> 
<td class=gridhdbg>Nitrate</td> 
<td class=gridhdbg>PH</td>
<td class=gridhdbg>HARDNESS</td> 
<td class=gridhdbg>ALKALINITY</td> 
<td class=gridhdbg>CHLORIDE</td> 
<td class=gridhdbg>SULPHATE</td>
</tr>
<%
String query1="",query2="";
int number=0;
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
String query="select distinct source_code  from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and substr (source_code,1,16)='"+habcode+"' ";
//System.out.println("qry:"+query);
stmt=conn.createStatement();
rs=stmt.executeQuery(query);
while(rs.next())
{%>
	<tr>
	<td class=rptValue><%=++number%></td>

	<%
		//System.out.println("code:"+rs.getString(1).substring(19,21));
	if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("SO") ) {
		   query2="select  distinct s.source_code ,nvl(source_name,'-'),a.test_id from rws_source_tbl s, rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and s.source_code=a.source_code and  a.source_code='"+rs.getString(1)+"' ";
	  }else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("HP") )
		  {
		   query2=" select distinct hp_code,nvl(location,'-'),a.test_id  from rws_hp_subcomp_param_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.hp_code=a.source_code and   hp_code='"+rs.getString(1)+"' ";
		  }
		  
	stmt2=conn.createStatement();
	//System.out.println("qry2:"+query2);
	rs2=stmt2.executeQuery(query2);
	if(rs2.next())
	{%>
		<td class=rptValue ><%=rs2.getString(1)%>-<%=rs2.getString(2)%></td> 
	<%
	//query1="select (select testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05' and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13' and test_id='"+rs2.getString(3)+"' )b1 from dual" ;
	query1="select (select testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05' and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13' and test_id='"+rs2.getString(3)+"' )b1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and test_id='"+rs2.getString(3)+"' )iron ,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and test_id='"+rs2.getString(3)+"') nitrate ,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and test_id='"+rs2.getString(3)+"') chloride , (select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual";	stmt1=conn.createStatement();
	//System.out.println(" qryyyyy:"+query1);
	rs1=stmt1.executeQuery(query1);
	rs1.next();
		if(rs1.getString(1)!=null )
		{%>
		 <td class=rptValue ><%=rs1.getString(1)%></td> 
		 <%}
			else{%><td class=rptValue>-</td><%}
	   if(rs1.getString(2)!=null )
		{%><td class=rptValue ><%=rs1.getString(2)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   if(rs1.getString(3)!=null )
		{%><td class=rptValue ><%=rs1.getString(3)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(4)!=null )
		{%><td class=rptValue ><%=rs1.getString(4)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(5)!=null )
		{%><td class=rptValue ><%=rs1.getString(5)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(6)!=null )
		{%><td class=rptValue ><%=rs1.getString(6)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(7)!=null )
		{%><td class=rptValue ><%=rs1.getString(7)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(8)!=null )
		{%><td class=rptValue ><%=rs1.getString(8)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   
	   if(rs1.getString(9)!=null )
		{%><td class=rptValue ><%=rs1.getString(9)%></td><%}
		else{%><td class=rptValue >-</td><%}
		
	   
	   
	   
	   
	   
	   
	   
	  }%>
	  </tr>
	<%}	%>

</table>

<%}else
{%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr class=rptLabel><%=val%></tr>
<tr>
<td class=btext>SNO</td>
<td class=btext>Source Code-Source Name</td>
<td class=btext>Brakish</td>
<td class=btext>Flouride</td>
<td class=gridhdbg>Iron</td> 
<td class=gridhdbg>Nitrate</td> 
<td class=gridhdbg>PH</td>
<td class=gridhdbg>HARDNESS</td> 
<td class=gridhdbg>ALKALINITY</td> 
<td class=gridhdbg>CHLORIDE</td> 
<td class=gridhdbg>SULPHATE</td>
</tr>
<%
String query1="",query2="";
int number=0;
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
String query="select distinct source_code  from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and substr (source_code,1,16)='"+habcode+"' ";
//System.out.println("qry:"+query);
stmt=conn.createStatement();
rs=stmt.executeQuery(query);
while(rs.next())
{%>
	<tr>
	<td class=rptValue><%=++number%></td>

	<%
		//System.out.println("code:"+rs.getString(1).substring(19,21));
	if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("SO") ) {
		   query2="select  distinct s.source_code ,nvl(source_name,'-'),a.test_id from rws_source_tbl s, rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and s.source_code=a.source_code and  a.source_code='"+rs.getString(1)+"' ";
	  }else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("HP") )
		  {
		   query2=" select distinct hp_code,nvl(location,'-'),a.test_id  from rws_hp_subcomp_param_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.hp_code=a.source_code and   hp_code='"+rs.getString(1)+"' ";
		  }
		  
	stmt2=conn.createStatement();
	//System.out.println("qry2:"+query2);
	rs2=stmt2.executeQuery(query2);
	if(rs2.next())
	{%>
		<td class=rptValue ><%=rs2.getString(1)%>-<%=rs2.getString(2)%></td> 
	<%
	//query1="select (select testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05' and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13' and test_id='"+rs2.getString(3)+"' )b1 from dual" ;
	query1="select (select testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05' and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13' and test_id='"+rs2.getString(3)+"' )b1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and test_id='"+rs2.getString(3)+"' )iron ,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and test_id='"+rs2.getString(3)+"') nitrate ,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and test_id='"+rs2.getString(3)+"') chloride , (select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual";	stmt1=conn.createStatement();
	stmt1=conn.createStatement();
	//System.out.println(" qryyyyy:"+query1);
	rs1=stmt1.executeQuery(query1);
	rs1.next();
		if(rs1.getString(1)!=null )
		{%>
		 <td class=rptValue ><%=rs1.getString(1)%></td> 
		 <%}
			else{%><td class=rptValue>-</td><%}
	   if(rs1.getString(1)!=null )
		{%><td class=rptValue ><%=rs1.getString(2)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(3)!=null )
		{%><td class=rptValue ><%=rs1.getString(3)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(4)!=null )
		{%><td class=rptValue ><%=rs1.getString(4)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(5)!=null )
		{%><td class=rptValue ><%=rs1.getString(5)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(6)!=null )
		{%><td class=rptValue ><%=rs1.getString(6)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(7)!=null )
		{%><td class=rptValue ><%=rs1.getString(7)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   if(rs1.getString(8)!=null )
		{%><td class=rptValue ><%=rs1.getString(8)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   
	   if(rs1.getString(9)!=null )
		{%><td class=rptValue ><%=rs1.getString(9)%></td><%}
		else{%><td class=rptValue >-</td><%}
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	  }%>
	  </tr>
	<%}	%>

</table>
<%}%>
</body>
</html>  