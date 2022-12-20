<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String dcode="";
if(session.getAttribute("district")!=null){
	dcode=(String)session.getAttribute("district");
	
}

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="btext" colspan=22>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 26 align="Center">LPCD  Ranges&nbsp;&nbsp;</td>
	</tr>
	<tr>
	    <td class=btext colspan = 2 align="center">Total</td>
		<td class=btext colspan = 2 align="center">> 100</td>
		<td class=btext colspan = 2 align="center">70-100</td>
		<td class=btext colspan = 2 align="center">60-70</td>
		<td class=btext colspan = 2 align="center">50-60</td>
<td class=btext colspan = 2 align="center">50-55</td>
<td class=btext colspan = 2 align="center">55-60</td>
		<td class=btext colspan = 2 align="center">40-50</td>
		<td class=btext colspan = 2 align="center">30-40</td>
		<td class=btext colspan = 2 align="center">20-30</td>
        <td class=btext colspan = 2 align="center">10-20</td>
		<td class=btext colspan = 2 align="center">0-10</td>
	</tr>
	<tr align = center>
		<td class=btext >No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td> 
<td class=btext >No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
	</tr>
	<%
   Statement stmt1=null;
   ResultSet rs1=null;
   int tot=0,tot1=0,tot2=0,tot3=0,tot4=0,tot5=0,tot6=0,tot7=0,tot8=0,tot9=0,tot10=0,tot11=0,tot12=0,tot13=0,tot14=0,tot15=0,tot16=0,tot17=0,tot18=0,tot19=0;
  int stot1=0,stot2=0,stot3=0,stot4=0;
    StringBuffer qry=new StringBuffer();
	int cnt=0;
	qry.append("select dcode,dname,count(panch_code),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU) from rws_complete_hab_view  ");
	if(dcode!=null && !dcode.equals("")){
		qry.append(" where dcode='"+dcode+"'");
	}
	qry.append(" group by dcode,dname order by dcode");
	stmt=conn.createStatement();
	stmt1=conn.createStatement();
	rs=stmt.executeQuery(qry.toString());
	while(rs.next())
	{%> 
         <tr> 
		<td class=rptvalue><%=++cnt%></td>
		<td class=btext><%=rs.getString(2)%></td>
		<td class=rptvalue align="right"><%=rs.getString(3)%></td>
		<td class=rptvalue align="right"><%=rs.getString(4)%></td>
		<%String qry1="select sum(case when exist_water_level>=100 then 1 else 0 end)a,sum(case when exist_water_level>=100 then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)b,sum(case when EXIST_WATER_LEVEL >=70  and EXIST_WATER_LEVEL <100 then 1 else 0 end)c,sum(case when EXIST_WATER_LEVEL >=70  and EXIST_WATER_LEVEL <100  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)d,sum(case when EXIST_WATER_LEVEL >=60  and EXIST_WATER_LEVEL <70 then 1 else 0 end)e,sum(case when EXIST_WATER_LEVEL >=60  and EXIST_WATER_LEVEL <70  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)f,sum(case when EXIST_WATER_LEVEL >=50  and EXIST_WATER_LEVEL <60 then 1 else 0 end)g,sum(case when EXIST_WATER_LEVEL >=50  and EXIST_WATER_LEVEL<60  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)h,	sum(case when EXIST_WATER_LEVEL >=40  and EXIST_WATER_LEVEL <50 then 1 else 0 end)i,sum(case when EXIST_WATER_LEVEL >=40  and EXIST_WATER_LEVEL< 50  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)j,sum(case when EXIST_WATER_LEVEL >=30  and EXIST_WATER_LEVEL <40 then 1 else 0 end)k,sum(case when EXIST_WATER_LEVEL >=30  and EXIST_WATER_LEVEL< 40  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)l,	sum(case when EXIST_WATER_LEVEL >=20  and EXIST_WATER_LEVEL <30 then 1 else 0 end)m,sum(case when EXIST_WATER_LEVEL >=20  and EXIST_WATER_LEVEL< 30  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)n,	sum(case when EXIST_WATER_LEVEL >=10  and EXIST_WATER_LEVEL <20 then 1 else 0 end)o,sum(case when EXIST_WATER_LEVEL >=10  and EXIST_WATER_LEVEL< 20  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)p,sum(case when EXIST_WATER_LEVEL >=0  and EXIST_WATER_LEVEL <10 then 1 else 0 end)q,sum(case when EXIST_WATER_LEVEL >=0  and EXIST_WATER_LEVEL< 10  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)r,sum(case when EXIST_WATER_LEVEL >=50  and EXIST_WATER_LEVEL <55 then 1 else 0 end)s1,sum(case when EXIST_WATER_LEVEL >=50  and EXIST_WATER_LEVEL <55  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)s2,sum(case when EXIST_WATER_LEVEL >=55  and EXIST_WATER_LEVEL <60 then 1 else 0 end)s3,sum(case when EXIST_WATER_LEVEL >=55  and EXIST_WATER_LEVEL <60  then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end)s4 from rws_complete_hab_view  where dcode='"+rs.getString(1)+"' ";
		 rs1=stmt1.executeQuery(qry1);
		 if(rs1.next())
		{%>
		<td class=rptvalue align="right"><%=rs1.getString(1)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(2)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(3)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(4)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(5)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(6)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(7)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(8)%></td>
	<td class=rptvalue align="right"><%=rs1.getString(19)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(20)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(21)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(22)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(9)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(10)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(11)%></td>
	

		<td class=rptvalue align="right"><%=rs1.getString(12)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(13)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(14)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(15)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(16)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(17)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(18)%></td>
		<%
		 tot2+=rs1.getInt(1);tot3+=rs1.getInt(2);tot4+=rs1.getInt(3);tot5+=rs1.getInt(4);
		 tot6+=rs1.getInt(5);tot7+=rs1.getInt(6);tot8+=rs1.getInt(7);tot9+=rs1.getInt(8);
		 tot10+=rs1.getInt(9);tot11+=rs1.getInt(10);tot12+=rs1.getInt(11);
		 tot13+=rs1.getInt(12);tot14+=rs1.getInt(13);tot15+=rs1.getInt(14);
         tot16+=rs1.getInt(15);tot17+=rs1.getInt(16);tot18+=rs1.getInt(17);
		 tot19+=rs1.getInt(18);
stot1+=rs1.getInt(19);
stot2+=rs1.getInt(20);
stot3+=rs1.getInt(21);
stot4+=rs1.getInt(22);

   
		 }
	
		%>
		</tr>
		<%
		tot+=rs.getInt(3);tot1+=rs.getInt(4);		
		
		}%>

	<tr>
	<td align="center" class=btext colspan=2>Total:</td>
	<td class=rptvalue align="right"><%=tot%></td>
	<td class=rptvalue align="right"><%=tot1%></td>
	<td class=rptvalue align="right"><%=tot2%></td>
	<td class=rptvalue align="right"><%=tot3%></td>
	<td class=rptvalue align="right"><%=tot4%></td>
	<td class=rptvalue align="right"><%=tot5%></td>
	<td class=rptvalue align="right"><%=tot6%></td>
	<td class=rptvalue align="right"><%=tot7%></td>
 		
	<td class=rptvalue align="right"><%=tot8%></td>
	<td class=rptvalue align="right"><%=tot9%></td>
<td class=rptvalue align="right"><%=stot1 %></td>
		<td class=rptvalue align="right"><%=stot2 %></td>
		<td class=rptvalue align="right"><%=stot3 %></td>
		<td class=rptvalue align="right"><%=stot4 %></td>
	<td class=rptvalue align="right"><%=tot10%></td>
	<td class=rptvalue align="right"><%=tot11%></td>

	<td class=rptvalue align="right"><%=tot12%></td>
	<td class=rptvalue align="right"><%=tot13%></td>
	<td class=rptvalue align="right"><%=tot14%></td>
	<td class=rptvalue align="right"><%=tot15%></td>
	<td class=rptvalue align="right"><%=tot16%></td>
	<td class=rptvalue align="right"><%=tot17%></td>
	<td class=rptvalue align="right"><%=tot18%></td>
	<td class=rptvalue align="right"><%=tot19%></td>
	</tr>