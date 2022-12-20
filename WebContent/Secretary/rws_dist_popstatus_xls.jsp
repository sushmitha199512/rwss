<%@ include file="/commons/rws_header1.jsp"%>
<% java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%		
		
	String query = null,query1=null,currentYear=null,fdate=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null,
	query8=null,query9=null,query10=null,query33=null,query44=null,query55=null,query66=null,query441=null,query551=null,query552=null,query553=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null,st14=null;
	ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs33=null,rs44=null,rs55=null,rs66=null,rs441=null,rs551=null,rs552=null,rs553=null;
	int sno=0,poptotals=0,habtotals=0,FChabtotals=0,FCPoptotals=0,PC1habtotals=0,PC2habtotals=0,PC3habtotals=0,PC4habtotals=0,QAhabtotals=0,NShabtotals=0;
	int PC1Poptotals=0,PC2Poptotals=0,PC3Poptotals=0,PC4Poptotals=0,QAPoptotals=0,NSPoptotals=0;
	
    String[] popRange = {"FC","NC","PC1","PC2","PC3","PC4","NSS"};

%>
<html>
<title> WaterSoft </title>
<head>
<script>
// window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1>

	<tr>
		<td align="center" class="rptHeading"> District-StatusWise-Population Report </td>
	</tr>
<tr><td valign=top>


<table border = 1 >	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
		<td class=btext rowspan = 4>District</td>
		<td class=btext colspan = 42 align="Center">Population&nbsp;&nbsp;</td>
	</tr>
	<tr>
	    <td class=btext colspan = 2  rowspan=2 align="center">Total</td>
		<td class=btext colspan = 5 rowspan=2  align="center">FC</td>
		<td class=btext colspan = 5 rowspan=2 align="center">NC</td>
		<td class=btext colspan=20  align="center">PC</td>
		<td class=btext colspan = 5 rowspan=2 align="center">QA</td>
		
	</tr>
	<tr><td class=btext colspan = 5  align="center" >PC1</td>
	<td class=btext colspan = 5  align="center">PC2</td>
	<td class=btext colspan = 5  align="center">PC3</td>
	<td class=btext  colspan = 5  align="center">PC4</td></tr>
	
	<tr align = center>
		 <td class=btext>Tot(Habs)</td>
		  <td class=btext>Tot(Pop)</td>
		 <td class=btext>Plain</td>
		 <td class=btext>SC</td>
		 <td class=btext>ST</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain</td>
		 <td class=btext>SC</td>
		 <td class=btext>ST</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain</td>
		 <td class=btext>SC</td>
		 <td class=btext>ST</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain</td>
		 <td class=btext>SC</td>
		 <td class=btext>ST</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain</td>
		 <td class=btext>SC</td>
		 <td class=btext>ST</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain</td>
		 <td class=btext>SC</td>
		 <td class=btext>ST</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain</td>
		 <td class=btext>SC</td>
		 <td class=btext>ST</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  group by d.dcode,d.dname order by dcode";
		// System.out.println(query);
		rs2=st2.executeQuery(query);
		while(rs2.next())
		{
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and coverage_status='NSS'";
			}

			try
			{
				st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st4=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st5=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
                st11=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
                st12=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
                st13=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
                st14=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				int c1=0,c2=0,c3=0,c4=0,c5=0,c6=0,c7=0,c8=0,c9=0,c10=0,c11=0,c12=0,c13=0,c14=0,c15=0,c16=0,c17=0,c18=0,c19=0,c20=0,c21=0,poptot=0,poptot1=0,poptot2=0,poptot3=0,poptot4=0,poptot5=0,poptot6=0;
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
	                if(rs33.getInt(3) >= ((rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3))/2))
					{
						c3++;
					}
					else  if(rs33.getInt(2) >= ((rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3))/2))
					{
						c2++;
					}
					else
					{
						c1++;
					}
			    }
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
	                if(rs44.getInt(3) >= ((rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3))/2))
					{
						c6++;
						
					}
					else  if(rs44.getInt(2) >= ((rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3))/2))
					{
						c5++;
						
					}
					else
					{
						c4++;
					}
				}
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
	                if(rs55.getInt(3) >= ((rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3))/2))
					{
						c9++;
						
					}
					else  if(rs55.getInt(2) >= ((rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3))/2))
					{
						c8++;
						
					}
					else
					{
						c7++;
					}
				}
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
	                if(rs66.getInt(3) >= ((rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3))/2))
					{
						c12++;
						
					}
					else  if(rs66.getInt(2) >= ((rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3))/2))
					{
						c11++;
						
					}
					else
					{
						c10++;
					}
				}
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
	                if(rs441.getInt(3) >= ((rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3))/2))
					{
						c15++;
						
					}
					else  if(rs441.getInt(2) >= ((rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3))/2))
					{
						c14++;
						
					}
					else
					{
						c13++;
					}
				}
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
	                if(rs551.getInt(3) >= ((rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3))/2))
					{
						c18++;
						
					}
					else  if(rs551.getInt(2) >= ((rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3))/2))
					{
						c17++;
						
					}
					else
					{
						c16++;
					}
				}
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
	                if(rs552.getInt(3) >= ((rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3))/2))
					{
						c21++;
						
					}
					else  if(rs552.getInt(2) >= ((rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3))/2))
					{
						c20++;
						
					}
					else
					{
						c19++;
					}
				}
			 habtotals=habtotals+c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21;			
             poptotals=poptotals+poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6;   
             FChabtotals=FChabtotals+c1+c2+c3;
             FCPoptotals=FCPoptotals+poptot;
             NShabtotals=NShabtotals+c4+c5+c6;
             NSPoptotals=NSPoptotals+poptot1;
             PC1habtotals=PC1habtotals+c13+c14+c15;
             PC1Poptotals=PC1Poptotals+poptot4;
             PC2habtotals=PC2habtotals+c7+c8+c9;
             PC2Poptotals=PC2Poptotals+poptot2;
             PC3habtotals=PC3habtotals+c16+c17+c18;
             PC3Poptotals=PC3Poptotals+poptot5;
             PC4habtotals=PC4habtotals+c19+c20+c21;
             PC4Poptotals=PC4Poptotals+poptot6;
             QAhabtotals=QAhabtotals+c10+c11+c12;
             QAPoptotals=QAPoptotals+poptot3;
             
             
             
             
%> 

		<tr>
		     <td class=rptValue><%=++sno%></td>
			 <td class=rptValue><%=rs2.getString(2)%></td>

			 <td class=btext><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue><%=c1%></td>
			 <td class=rptValue><%=c2%></td>
		     <td class=rptValue><%=c3%></td>
			 <td class=btext><%=c1+c2+c3%></td>
			 <td class=btext><%=poptot%></td>
			 <td class=rptValue><%=c4%></td>
			 <td class=rptValue><%=c5%></td>
		     <td class=rptValue><%=c6%></td>
			 <td class=btext><%=c4+c5+c6%></td>
			 <td class=btext><%=poptot1%></td>
			 
			 
			 <td class=rptValue><%=c13%></td>
			 <td class=rptValue><%=c14%></td>
		     <td class=rptValue><%=c15%></td>
			 <td class=btext><%=c13+c14+c15%></td>
			 <td class=btext><%=poptot4%></td>
			 
			 
			 <td class=rptValue><%=c7%></td>
			 <td class=rptValue><%=c8%></td>
		     <td class=rptValue><%=c9%></td>
			 <td class=btext><%=c7+c8+c9%></td>
			 <td class=btext><%=poptot2%></td>
			 
			 <td class=rptValue><%=c16%></td>
			 <td class=rptValue><%=c17%></td>
		     <td class=rptValue><%=c18%></td>
			 <td class=btext><%=c16+c17+c18%></td>
			 <td class=btext><%=poptot5%></td>
			 
			 <td class=rptValue><%=c19%></td>
			 <td class=rptValue><%=c20%></td>
		     <td class=rptValue><%=c21%></td>
			 <td class=btext><%=c19+c20+c21%></td>
			 <td class=btext><%=poptot6%></td>
			 
			 <td class=rptValue><%=c10%></td>
			 <td class=rptValue><%=c11%></td>
		     <td class=rptValue><%=c12%></td>
			 <td class=btext><%=c10+c11+c12%></td>
			 <td class=btext><%=poptot3%></td>
		</tr>
<%		}
		catch(Exception e)
		{
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
		}
	  }
	}
	catch(Exception e)
	{}
	finally
	{
		rs2.close();
		st2.close();
		conn.close();
	}
%>
<tr><td class=btext colspan=2>Grand Totals</td>
	<td class=btext ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext ><%=FChabtotals%></td>
	<td class=btext ><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext ><%=NShabtotals%></td>
	<td class=btext ><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext ><%=PC1habtotals%></td>
	<td class=btext ><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext ><%=PC2habtotals%></td>
	<td class=btext ><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext ><%=PC3habtotals%></td>
	<td class=btext ><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext ><%=PC4habtotals%></td>
	<td class=btext ><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext ><%=QAhabtotals%></td>
	<td class=btext ><%=QAPoptotals%></td>
	
</tr>
</table>

</form>
</body>
</html>

