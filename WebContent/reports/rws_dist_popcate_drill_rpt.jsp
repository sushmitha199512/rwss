<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%		
		
	String query = null,query1=null,currentYear=null,fdate=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null,
	query8=null,query9=null,query10=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;
	ResultSet rs2=null,rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	int sno=0;
	int total1=0,total2=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0;
    String[] popRange = {"SC","ST","PLAIN"};
	String per = request.getParameter("per");
	String dcode=request.getParameter("district");
	String dName=request.getParameter("dName");
%>
<html>
<title> WaterSoft </title>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table width="880" align="center">
</table>
<%if(per!=null && !per.equals("")){
		int percentage = Integer.parseInt(per);
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">District-CategoryWise-Population Report </font></td>
	</tr>
<tr><td valign=top>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="btext" colspan=47>Report for District: <%=dName%> and Percentage: <%=per%>%</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 9 rowspan=2 align="center">Total(Without Applying Percentage criteria)</td>
		<td class=btext colspan = 36 align="Center">Population Based On <%=per%>%</td>
	</tr>
	<tr>
		<td class=btext colspan = 12 align="center">PLAIN</td>
		<td class=btext colspan = 12 align="center">SC</td>
		<td class=btext colspan = 12 align="center">ST</td>
		</tr>
	<tr align = center>
		<td class=btext>Total Habs</td>
		<td class=btext>FC</td>
		<td class=btext>PC4</td>
		<td class=btext>PC3</td>
		<td class=btext>PC2</td>
		<td class=btext>PC1</td>
		<td class=btext>NC</td>				
		<td class=btext>NSS</td>		
		<td class=btext>Pop</td> 
		<td class=btext>Total Habs</td>
		<td class=btext>FC</td>
		<td class=btext>PC4</td>
		<td class=btext>PC3</td>
		<td class=btext>PC2</td>
		<td class=btext>PC1</td>
		<td class=btext>NC</td>				
		<td class=btext>NSS</td>	
		<td class=btext>Plain</td>
		<td class=btext>SC</td>				
		<td class=btext>ST</td>	
		<td class=btext>Pop</td> 
		<td class=btext>Total Habs</td>
		<td class=btext>FC</td>
		<td class=btext>PC4</td>
		<td class=btext>PC3</td>
		<td class=btext>PC2</td>
		<td class=btext>PC1</td>
		<td class=btext>NC</td>				
		<td class=btext>NSS</td>		
		<td class=btext>Plain</td>
		<td class=btext>SC</td>				
		<td class=btext>ST</td>	
		<td class=btext>Pop</td>
		<td class=btext>Total Habs</td>
		<td class=btext>FC</td>
		<td class=btext>PC4</td>
		<td class=btext>PC3</td>
		<td class=btext>PC2</td>
		<td class=btext>PC1</td>
		<td class=btext>NC</td>				
		<td class=btext>NSS</td>	
		<td class=btext>Plain</td>
		<td class=btext>SC</td>				
		<td class=btext>ST</td>	
		<td class=btext>Pop</td>
	</tr>
	<%


	try
		{
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

rs2=st2.executeQuery("select distinct m.mcode,m.mname from rws_mandal_tbl m  where  m.dcode='"+dcode+"'  order by m.mcode,m.mname");
int fc=0,pc4=0,pc3=0,pc2=0,pc1=0,nc=0,nss=0;
int plainfc=0,plainpc4=0,plainpc3=0,plainpc2=0,plainpc1=0,plainnc=0,plainnss=0;
int scfc=0,scpc4=0,scpc3=0,scpc2=0,scpc1=0,scnc=0,scnss=0;
int stfc=0,stpc4=0,stpc3=0,stpc2=0,stpc1=0,stnc=0,stnss=0;
int scfctot=0,scpc4tot=0,scpc3tot=0,scpc2tot=0,scpc1tot=0,scnctot=0,scnsstot=0;
int stfctot=0,stpc4tot=0,stpc3tot=0,stpc2tot=0,stpc1tot=0,stnctot=0,stnsstot=0;
int plainfctot=0,plainpc4tot=0,plainpc3tot=0,plainpc2tot=0,plainpc1tot=0,plainnctot=0,plainnsstot=0;
int fctot=0,pc4tot=0,pc3tot=0,pc2tot=0,pc1tot=0,nctot=0,nsstot=0;
int scpop4=0,stpop4=0,plainpop4=0;
int scpop5=0,stpop5=0,plainpop5=0;
int scpop6=0,stpop6=0,plainpop6=0;
while(rs2.next())
{
	int count=0,count1=0,count2=0,plaintot=0,sctot=0,sttot=0;
	scfc=0;scpc4=0;scpc3=0;scpc2=0;scpc1=0;scnc=0;scnss=0;
	stfc=0;stpc4=0;stpc3=0;stpc2=0;stpc1=0;stnc=0;stnss=0;
	plainfc=0;plainpc4=0;plainpc3=0;plainpc2=0;plainpc1=0;plainnc=0;plainnss=0;
	fc=0;pc4=0;pc3=0;pc2=0;pc1=0;nc=0;nss=0;
	int j=0;
	query3 = "select HD.census_plain_popu,hd.census_sc_popu,hd.census_st_popu,hd.hab_code,hd.coverage_status from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and m.dcode='"+dcode+"' and m.mcode='"+rs2.getString(1)+"'";
	String habCode = "";
	try
	{
	st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	int total = 0,sc=0,st=0,plain=0,totalhabs=0,scpop=0,stpop=0,plainpop=0,totals=0;
	int scpop1=0,stpop1=0,plainpop1=0;
	int scpop2=0,stpop2=0,plainpop2=0;
	int scpop3=0,stpop3=0,plainpop3=0;
	double plainper=0.0,scper=0.0,stper=0.0;
	rs3 = st3.executeQuery(query3);
	while(rs3.next())
	{
		totalhabs++;
		habCode = rs3.getString(4);
		String covStatus = rs3.getString("coverage_status");
		//System.out.println(covStatus);
		total = rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
		totals += total;
		if(covStatus.equals("FC"))
				fc++;
			if(covStatus.equals("PC4"))
				pc4++;
			if(covStatus.equals("PC3"))
				pc3++;
			if(covStatus.equals("PC2"))
				pc2++;
			if(covStatus.equals("PC1"))
				pc1++;
			if(covStatus.equals("NC"))
				nc++;
			if(covStatus.equals("NSS"))
				nss++;
			 plainper=0.0;scper=0.0;stper=0.0;
			 try
			{
				plainper = (rs3.getInt(1)*100)/total;
				scper = (rs3.getInt(2)*100)/total;
				stper = (rs3.getInt(3)*100)/total;
			}
			catch(Exception e)
			{
				//System.out.println("aa:"+e.getMessage());
			}
		if(scper>=percentage)
		{
			sc++;
			scpop += total;
			if(covStatus.equals("FC"))
				scfc++;
			if(covStatus.equals("PC4"))
				scpc4++;
			if(covStatus.equals("PC3"))
				scpc3++;
			if(covStatus.equals("PC2"))
				scpc2++;
			if(covStatus.equals("PC1"))
				scpc1++;
			if(covStatus.equals("NC"))
				scnc++;
			if(covStatus.equals("NSS"))
				scnss++;
			scpop2 += rs3.getInt("census_sc_popu");
			stpop2 += rs3.getInt("census_st_popu");
			plainpop2 += rs3.getInt("census_plain_popu");

			scpop5 += rs3.getInt("census_sc_popu");
			stpop5 += rs3.getInt("census_st_popu");
			plainpop5 += rs3.getInt("census_plain_popu");
			//System.out.println("in sc:"+rs3.getInt("census_sc_popu")+"----:"+rs3.getInt("census_st_popu")+"----"+rs3.getInt("census_plain_popu"));
		}
		else if(stper>=percentage)
		{
			st++;
			stpop += total;
			if(covStatus.equals("FC"))
				stfc++;
			if(covStatus.equals("PC4"))
				stpc4++;
			if(covStatus.equals("PC3"))
				stpc3++;
			if(covStatus.equals("PC2"))
				stpc2++;
			if(covStatus.equals("PC1"))
				stpc1++;
			if(covStatus.equals("NC"))
				stnc++;
			if(covStatus.equals("NSS"))
				stnss++;
			scpop3 += rs3.getInt("census_sc_popu");
			stpop3 += rs3.getInt("census_st_popu");
			plainpop3 += rs3.getInt("census_plain_popu");

			scpop6 += rs3.getInt("census_sc_popu");
			stpop6 += rs3.getInt("census_st_popu");
			plainpop6 += rs3.getInt("census_plain_popu");
		//	System.out.println("in st");
		}
		else
		{
			plain++;
			plainpop += total;
			if(covStatus.equals("FC"))
				plainfc++;
			if(covStatus.equals("PC4"))
				plainpc4++;
			if(covStatus.equals("PC3"))
				plainpc3++;
			if(covStatus.equals("PC2"))
				plainpc2++;
			if(covStatus.equals("PC1"))
				plainpc1++;
			if(covStatus.equals("NC"))
				plainnc++;
			if(covStatus.equals("NSS"))
				plainnss++;
			scpop1 += rs3.getInt("census_sc_popu");
			stpop1 += rs3.getInt("census_st_popu");
			plainpop1 += rs3.getInt("census_plain_popu");

			scpop4 += rs3.getInt("census_sc_popu");
			stpop4 += rs3.getInt("census_st_popu");
			plainpop4 += rs3.getInt("census_plain_popu");
		}
	}
		total1 += totalhabs;
		total2 += totals;
		total3 += plain;
		total4 += plainpop;
		total5 += sc;
		total6 += scpop;
		total7 += st;
		total8 += stpop;
		
		scfctot += scfc;
		scpc4tot += scpc4;
		scpc3tot += scpc3;
		scpc2tot += scpc2;
		scpc1tot += scpc1;
		scnctot += scnc;
		scnsstot += scnss;
		
		stfctot += stfc;
		stpc4tot += stpc4;
		stpc3tot += stpc3;
		stpc2tot += stpc2;
		stpc1tot += stpc1;
		stnctot += stnc;
		stnsstot += stnss;

		plainfctot += plainfc;
		plainpc4tot += plainpc4;
		plainpc3tot += plainpc3;
		plainpc2tot += plainpc2;
		plainpc1tot += plainpc1;
		plainnctot += plainnc;
		plainnsstot += plainnss;

		fctot += fc;
		pc4tot += pc4;
		pc3tot += pc3;
		pc2tot += pc2;
		pc1tot += pc1;
		nctot += nc;
		nsstot += nss;
	%>
			<tr>	
		     <td class=rptValue><%=++sno%></td>
		     <td class=rptValue><%=rs2.getString(2)%></td>
			 <td class=btext><font color=red><%=totalhabs%></font></td>
			 <td class=rptValue><%=fc%></td>
			 <td class=rptValue><%=pc4%></td>
			 <td class=rptValue><%=pc3%></td>
			 <td class=rptValue><%=pc2%></td>
			 <td class=rptValue><%=pc1%></td>
			 <td class=rptValue><%=nc%></td>
			 <td class=rptValue><%=nss%></td>
			 <td class=btext><%=totals%></td>
		     <td class=rptValue><font color=red><%=plain%></font></td>
			 <td class=rptValue><%=plainfc%></td>
			 <td class=rptValue><%=plainpc4%></td>
			 <td class=rptValue><%=plainpc3%></td>
			 <td class=rptValue><%=plainpc2%></td>
			 <td class=rptValue><%=plainpc1%></td>
			 <td class=rptValue><%=plainnc%></td>
			 <td class=rptValue><%=plainnss%></td>
			 <td class=rptValue><%=plainpop1%></td>
 			 <td class=rptValue><%=scpop1%></td>
			 <td class=rptValue><%=stpop1%></td>
			 <td class=rptValue><%=plainpop%></td>
			 <td class=rptValue><font color=red><%=sc%></font></td>
			 <td class=rptValue><%=scfc%></td>
			 <td class=rptValue><%=scpc4%></td>
			 <td class=rptValue><%=scpc3%></td>
			 <td class=rptValue><%=scpc2%></td>
			 <td class=rptValue><%=scpc1%></td>
			 <td class=rptValue><%=scnc%></td>
			 <td class=rptValue><%=scnss%></td>
 			 <td class=rptValue><%=plainpop2%></td>
 			 <td class=rptValue><%=scpop2%></td>
			 <td class=rptValue><%=stpop2%></td>
			 <td class=rptValue><%=scpop%></td>
			 <td class=rptValue><font color=red><%=st%></font></td>
			 <td class=rptValue><%=stfc%></td>
			 <td class=rptValue><%=stpc4%></td>
			 <td class=rptValue><%=stpc3%></td>
			 <td class=rptValue><%=stpc2%></td>
			 <td class=rptValue><%=stpc1%></td>
			 <td class=rptValue><%=stnc%></td>
			 <td class=rptValue><%=stnss%></td>
 			<td class=rptValue><%=plainpop3%></td>
 			 <td class=rptValue><%=scpop3%></td>
			 <td class=rptValue><%=stpop3%></td>
			 <td class=rptValue><%=stpop%></td>
			</tr>
<%
			}
				catch(Exception e)
			{System.out.println(e.getMessage());}
				finally
			{
					if(rs3!=null)rs3.close();
					if(st3!=null)st3.close();
			}
				}
				%>
				<tr>	
					 <td class="btext" colspan="2">Total</td>
					<td class="btext"><font color=red><%=total1%></font></td> 
					<td class=rptValue><%=fctot%></td>
					 <td class=rptValue><%=pc4tot%></td>
					 <td class=rptValue><%=pc3tot%></td>
					 <td class=rptValue><%=pc2tot%></td>
					 <td class=rptValue><%=pc1tot%></td>
					 <td class=rptValue><%=nctot%></td>
					 <td class=rptValue><%=nsstot%></td>
					<td class="btext"><%=total2%></td> 
					<td class="btext"><font color=red><%=total3%></font></td> 
					<td class=rptValue><%=plainfctot%></td>
					 <td class=rptValue><%=plainpc4tot%></td>
					 <td class=rptValue><%=plainpc3tot%></td>
					 <td class=rptValue><%=plainpc2tot%></td>
					 <td class=rptValue><%=plainpc1tot%></td>
					 <td class=rptValue><%=plainnctot%></td>
					 <td class=rptValue><%=plainnsstot%></td>
					 <td class=rptValue><%=plainpop4%></td>
 					 <td class=rptValue><%=scpop4%></td>
					<td class=rptValue><%=stpop4%></td>
					<td class="btext"><%=total4%></td> 
					<td class="btext"><font color=red><%=total5%></font></td> 
					<td class=rptValue><%=scfctot%></td>
					 <td class=rptValue><%=scpc4tot%></td>
					 <td class=rptValue><%=scpc3tot%></td>
					 <td class=rptValue><%=scpc2tot%></td>
					 <td class=rptValue><%=scpc1tot%></td>
					 <td class=rptValue><%=scnctot%></td>
					 <td class=rptValue><%=scnsstot%></td>
					 <td class=rptValue><%=plainpop5%></td>
 					 <td class=rptValue><%=scpop5%></td>
					<td class=rptValue><%=stpop5%></td>
					<td class="btext"><%=total6%></td> 
					<td class="btext"><font color=red><%=total7%></font></td> 
					<td class=rptValue><%=stfctot%></td>
					 <td class=rptValue><%=stpc4tot%></td>
					 <td class=rptValue><%=stpc3tot%></td>
					 <td class=rptValue><%=stpc2tot%></td>
					 <td class=rptValue><%=stpc1tot%></td>
					 <td class=rptValue><%=stnctot%></td>
					 <td class=rptValue><%=stnsstot%></td>
					 <td class=rptValue><%=plainpop6%></td>
 					 <td class=rptValue><%=scpop6%></td>
					<td class=rptValue><%=stpop6%></td>
					<td class="btext"><%=total8%></td> 
			</tr>
				<%
		}
		catch(Exception e)
		{e.printStackTrace();}
		finally
		{
			if(rs2!=null)rs2.close();
			if(st2!=null)st2.close();
			if(conn!=null)conn.close();
		}
	%>
</table>
</table>
<%}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>