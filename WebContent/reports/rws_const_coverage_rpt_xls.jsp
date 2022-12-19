<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "conn.jsp" %>
<%		
		String qrystr="",habstr="",fieldstr="",grpstr="",orstr="";

        String dcode=(String)session.getAttribute("dcode");
		//System.out.println("dcode value:"+dcode);
		
		String dname=(String)session.getAttribute("districtName");
		//System.out.println("dname value:"+dname);

        String ccode=(String)session.getAttribute("ccode");
		//System.out.println("ccode value:"+ccode);
		
        String cname=(String)session.getAttribute("constituencyName");
		//System.out.println("cname value:"+cname);

        String mcode=(String)session.getAttribute("mcode");
		//System.out.println("mcode value:"+mcode);
		
        String mname=(String)session.getAttribute("mandalName");
		//System.out.println("mname value:"+mname);

        String pcode=(String)session.getAttribute("pcode");
		//System.out.println("pcode value:"+pcode);
		
        String pname=(String)session.getAttribute("panchayatName");
		//System.out.println("pname value:"+pname);

        String vcode=(String)session.getAttribute("vcode");
		//System.out.println("vcode value:"+vcode);
		
        String vname=(String)session.getAttribute("villageName");
		//System.out.println("vname value:"+vname);

        


	String dcmquery="",const_qry="",query = null,query1=null,currentYear=null,fdate=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null,
	query8=null,query9=null,query10=null,query33=null,query44=null,query55=null,query66=null,query441=null,query551=null,query552=null,query553=null;
	Statement dcmst2=null,const_st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null,st14=null;
	ResultSet dcmrs2=null,const_rs=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs33=null,rs44=null,rs55=null,rs66=null,rs441=null,rs551=null,rs552=null,rs553=null;
	int sno=0,poptotals=0,habtotals=0,FChabtotals=0,FCPoptotals=0,PC1habtotals=0,PC2habtotals=0,PC3habtotals=0,PC4habtotals=0,QAhabtotals=0,NShabtotals=0;
	int PC1Poptotals=0,PC2Poptotals=0,PC3Poptotals=0,PC4Poptotals=0,QAPoptotals=0,NSPoptotals=0;
	
	
    String[] popRange = {"FC","NC","PC1","PC2","PC3","PC4","NSS"};

%>
<html>
<title> WaterSoft </title>
<head>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">Population Report </font></td>
	</tr>
<tr><td valign=top>

<%if(dcode.equals("00")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40>All Districts</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{
	    boolean flag2=false;
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode  group by d.dcode,d.dname order by d.dcode";
		//System.out.println("All Districts"+query);
		rs2=st2.executeQuery(query);
        flag2=true;
		while(rs2.next())
		{
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and d.dcode='"+rs2.getString(1)+"' and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and d.dcode='"+rs2.getString(1)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and d.dcode='"+rs2.getString(1)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+rs2.getString(1)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+rs2.getString(1)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+rs2.getString(1)+"' and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+rs2.getString(1)+"' and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
		conn.close();
	}
%>
<tr><td class=btext colspan=2>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>

<%@ include file = "footer.jsp" %>
</td>
</tr>
</table>
<%} %>
<%if(!dcode.equals("00") && ccode.equals("00")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Constituency Wise Report of <%=dname%> District</font>   </td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{
	    boolean flag3=false;
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"'  group by d.dcode,d.dname,c.constituency_code,c.constituency_name order by d.dcode,constituency_code";
		//System.out.println("District-All Const..");
		rs2=st2.executeQuery(query);
        flag3=true;
		while(rs2.next())
		{
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode     and c.constituency_code='"+rs2.getString(3)+"' and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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

		<tr><%if(flag3){ %>
		     <td class=rptValue><%=++sno%></td>
			 <td class=rptValue><%=rs2.getString(2)%></td>
              <%}else{ %><td class=rptValue></td>
			 <td class=rptValue>""</td>
              <%} %>
             <td class=rptValue><%=rs2.getString(4)%></td>
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	flag3=false;	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
		conn.close();
	}
%>
<tr><td class=btext colspan=3>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%}%>

<%if(!dcode.equals("00") && !ccode.equals("00") && mcode.equals("00")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Mandal Wise Report of <%=dname%> District,<%=cname%> Constituency</font>   </td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
        <td class=btext rowspan = 4>Mandal Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{
	    boolean flag4=false;
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"' and c.constituency_code='"+ccode+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname order by d.dcode,constituency_code,m.mcode";
		//System.out.println("District-Const-All Mandals...");
		rs2=st2.executeQuery(query);
        flag4=true;
		while(rs2.next())
		{
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"'  and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"'and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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

		<tr><%if(flag4){ %>
		     <td class=rptValue><%=++sno%></td>
			 <td class=rptValue><%=rs2.getString(2)%></td>
             <td class=rptValue><%=rs2.getString(4)%></td>
              <%}else{ %><td class=rptValue></td>
			 <td class=rptValue>""</td>
             <td class=rptValue>""</td>
              <%} %>
             <td class=rptValue><%=rs2.getString(6)%></td>
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	flag4=false;	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
		conn.close();
	}
%>
<tr><td class=btext colspan=5>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%}%>

<%if(!dcode.equals("00") && !ccode.equals("00") && !mcode.equals("00") && pcode.equals("00")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Panchayat Wise Report Of <%=dname%> District,<%=cname%> Constituency,<%=mname%> Mandal</font></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
        <td class=btext rowspan = 4>Mandal Name</td>
        <td class=btext rowspan = 4>Panchayat Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{   boolean flag5=false;
	   // System.out.println("hai...............");
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"' and c.constituency_code='"+ccode+"' and m.mcode='"+mcode+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname order by d.dcode,constituency_code,m.mcode,p.pcode";
		//System.out.println("District-Const-Mandals-All Panchayats");
		rs2=st2.executeQuery(query);flag5=true;
		while(rs2.next())
		{
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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

		<tr><%if(flag5){ %>
		     <td class=rptValue><%=++sno%></td>
			 <td class=rptValue><%=rs2.getString(2)%></td>
             <td class=rptValue><%=rs2.getString(4)%></td>
             <td class=rptValue><%=rs2.getString(6)%></td>
			<%}else{%>
			<td class=rptValue></td>
			 <td class=rptValue>""</td>
             <td class=rptValue>""</td>
             <td class=rptValue>""</td>
			
			<%} %>
             <td class=rptValue><%=rs2.getString(8)%></td>
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	flag5=false;	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
		conn.close();
	}
%>
<tr><td class=btext colspan=5>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%} %>
<%if(!dcode.equals("00") && !ccode.equals("00") && !mcode.equals("00") && !pcode.equals("00") && vcode.equals("00")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Village Wise Report Of <%=dname%> District,<%=cname%> Constituency,<%=mname%> Mandal,<%=pname%> Panchayat</font></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
        <td class=btext rowspan = 4>Mandal Name</td>
        <td class=btext rowspan = 4>Panchayat Name</td>
        <td class=btext rowspan = 4>Village Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{   boolean flag1=false;
	  //  System.out.println("hai...............");
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"' and c.constituency_code='"+ccode+"' and m.mcode='"+mcode+"' and p.pcode='"+pcode+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname order by d.dcode,constituency_code,m.mcode,p.pcode,v.vcode";
		//System.out.println("District-Const-Mandals-Panchayat-All Villages");
		rs2=st2.executeQuery(query);
        flag1=true;
		while(rs2.next())
		{   
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and p.pcode='"+rs2.getString(9)+"' and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and p.pcode='"+rs2.getString(9)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and p.pcode='"+rs2.getString(9)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and p.pcode='"+rs2.getString(9)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and p.pcode='"+rs2.getString(9)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and p.pcode='"+rs2.getString(9)+"' and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and p.pcode='"+rs2.getString(9)+"' and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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

		<tr><%if(flag1){ %>
		     <td class=rptValue><%=++sno%></td>
			 <td class=rptValue><%=rs2.getString(2)%></td>
             <td class=rptValue><%=rs2.getString(4)%></td>
             <td class=rptValue><%=rs2.getString(6)%></td>
             <td class=rptValue><%=rs2.getString(8)%></td>
             <%}else{ %>
            <td class=rptValue></td>
			<!--  <td class=rptValue></td> -->
             <td class=rptValue>""</td>
             <td class=rptValue>""</td>
             <td class=rptValue>""</td>
             <td class=rptValue>""</td>
            
            <%} %> <td class=rptValue><%=rs2.getString(10)%></td>
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	flag1=false;	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
		conn.close();
	}
%>
<tr><td class=btext colspan=6>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%}%>

<!-- ////////////////////////////////individuals///////////////////////////////////////////////-->

<!-- ////////////////////////////////individuals///////////////////////////////////////////////-->

<%if(!dcode.equals("00") && !dcode.equals("-1")&& !ccode.equals("00") && !ccode.equals("-1") && mcode.equals("-1")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Of <%=dname%> District&nbsp;:&nbsp;<%=cname%> Constituency</font></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{   
	   // System.out.println("hai...............");
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"' and c.constituency_code='"+ccode+"'  group by d.dcode,d.dname,c.constituency_code,c.constituency_name order by d.dcode,constituency_code";
		//System.out.println("District-Const");
		rs2=st2.executeQuery(query);
        
		while(rs2.next())
		{   
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and c.constituency_code='"+rs2.getString(3)+"'and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'   and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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
             <td class=rptValue><%=rs2.getString(4)%></td>                       
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
           
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
       
	}
%>
<tr><td class=btext colspan=3>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%}%>

<%if(!dcode.equals("00") && !dcode.equals("-1") && !ccode.equals("00") && !ccode.equals("-1") && !mcode.equals("00") && !mcode.equals("-1") && pcode.equals("-1")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Of <%=dname%> District&nbsp;:&nbsp;<%=cname%> Constituency&nbsp;:&nbsp;<%=mname%> Mandal</font></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
        <td class=btext rowspan = 4>Mandal Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{   
	  //  System.out.println("hai...............");
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"' and c.constituency_code='"+ccode+"' and m.mcode='"+mcode+"'  group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname order by d.dcode,constituency_code";
		//System.out.println("District-Const");
		rs2=st2.executeQuery(query);
        
		while(rs2.next())
		{   
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and m.mcode='"+rs2.getString(5)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"'  and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"'  and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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
             <td class=rptValue><%=rs2.getString(4)%></td> <td class=rptValue><%=rs2.getString(6)%></td>                       
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
           
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
       
	}
%>
<tr><td class=btext colspan=4>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%}%>


<%if(!dcode.equals("00") && !dcode.equals("-1") && !ccode.equals("00") && !ccode.equals("-1") && !mcode.equals("00") && !mcode.equals("-1") && !pcode.equals("00") && !pcode.equals("-1") && vcode.equals("-1") ){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Of <%=dname%> District&nbsp;:&nbsp;<%=cname%> Constituency&nbsp;:&nbsp;<%=mname%> Mandal&nbsp;:&nbsp;<%=pname%> Panchayat</font></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
        <td class=btext rowspan = 4>Mandal Name</td>
        <td class=btext rowspan = 4>Panchayat Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{   
	    //System.out.println("hai...............");
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"' and c.constituency_code='"+ccode+"' and m.mcode='"+mcode+"' and p.pcode='"+pcode+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname order by d.dcode,constituency_code";
		//System.out.println("District-Const");
		rs2=st2.executeQuery(query);
        
		while(rs2.next())
		{   
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"'  and  HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"'  and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"'  and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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
             <td class=rptValue><%=rs2.getString(4)%></td> <td class=rptValue><%=rs2.getString(6)%></td>
<td class=rptValue><%=rs2.getString(8)%></td>                       
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
           
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
       
	}
%>
<tr><td class=btext colspan=5>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%}%>

<%if(!dcode.equals("00") && !dcode.equals("-1") && !ccode.equals("00") && !ccode.equals("-1") && !mcode.equals("00") && !mcode.equals("-1") && !pcode.equals("00") && !pcode.equals("-1") && !vcode.equals("00") && !vcode.equals("-1")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=40><font color="blue">Of <%=dname%> District&nbsp;:&nbsp;<%=cname%> Constituency&nbsp;:&nbsp;<%=mname%> Mandal&nbsp;:&nbsp;<%=pname%> Panchayat&nbsp;:&nbsp;<%=vname%> Village</font></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 4>Sl.No</td>
        <td class=btext rowspan = 4>District Name</td>
		<td class=btext rowspan = 4>Constituency Name</td>
        <td class=btext rowspan = 4>Mandal Name</td>
        <td class=btext rowspan = 4>Panchayat Name</td>
        <td class=btext rowspan = 4>Village Name</td>
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
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<BR>(FC Habs)</td>
		  <td class=btext>Total<BR>(FC Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(NC Habs)</td>
		 <td class=btext>Total<BR>(NC Pop)</td>
		<td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC1 Habs)</td>
		 <td class=btext>Total<BR>(PC1 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC2 Habs)</td>
		 <td class=btext>Total<BR>(PC2 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC3 Habs)</td>
		 <td class=btext>Total<BR>(PC3 Pop)</td>
		  <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(PC4 Habs)</td>
		 <td class=btext>Total<BR>(PC4 Pop)</td>
		 <td class=btext>Plain-Pop</td>
		 <td class=btext>SC-Pop</td>
		 <td class=btext>ST-Pop</td>
		 <td class=btext>Total<br>(QA Habs)</td>
		 <td class=btext>Total<BR>(QA Pop)</td>
			
	</tr>
	
<%
	try
	{   
	   // System.out.println("hai...............");
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query="select distinct d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and c.dcode=d.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"' and c.constituency_code='"+ccode+"' and m.mcode='"+mcode+"' and p.pcode='"+pcode+"' and v.vcode='"+vcode+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname order by d.dcode,constituency_code";
		//System.out.println("District-Const");
		rs2=st2.executeQuery(query);
        
		while(rs2.next())
		{   
			int j=0;
			if(popRange[j].equals("FC"))
			{
				query33="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_constituency_tbl c where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and v.vcode='"+rs2.getString(9)+"'  and  HD.coverage_status='FC' "; 
			}
			if(popRange[j+1].equals("NC") )
			{
				query44="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and v.vcode='"+rs2.getString(9)+"' and (coverage_status='NC') ";
			}
			if( popRange[j+2].equals("PC1")){
			query441="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"'  and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and v.vcode='"+rs2.getString(9)+"' and (coverage_status='PC1') ";
			}
			if(popRange[j+3].equals("PC2"))
			{
				query55="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and v.vcode='"+rs2.getString(9)+"' and (coverage_status='PC2')";
			}
			if(popRange[j+4].equals("PC3"))
			{
			query551="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and v.vcode='"+rs2.getString(9)+"' and (coverage_status='PC3')";
			}
			if( popRange[j+5].equals("PC4"))
			{
			query552="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and v.vcode='"+rs2.getString(9)+"' and (coverage_status='PC4')";
			}
			if(popRange[j+6].equals("NSS"))
			{
			    query66="SELECT hd.census_plain_popu,hd.census_sc_popu,hd.census_st_popu  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd ,rws_constituency_tbl c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and c.dcode=d.dcode and m.mcode=c.mcode  and c.constituency_code='"+rs2.getString(3)+"' and m.mcode='"+rs2.getString(5)+"' and p.pcode='"+rs2.getString(7)+"' and v.vcode='"+rs2.getString(9)+"'  and coverage_status='NSS'";
			}
			//System.out.println("query33"+query33);
			//System.out.println("query44"+query44);
			//System.out.println("query55"+query55);
			//System.out.println("query551"+query551);
			//System.out.println("query5523"+query552);
			//System.out.println("query66"+query66);
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
				int d1=0,d2=0,d3=0,d4=0,d5=0,d6=0,d7=0,d8=0,d9=0,d10=0,d11=0,d12=0,d13=0,d14=0,d15=0,d16=0,d17=0,d18=0,d19=0,d20=0,d21=0;

				// System.out.println("33:"+query33);
				rs33 = st3.executeQuery(query33);
				while(rs33.next())
				{
				poptot=poptot+rs33.getInt(1)+rs33.getInt(2)+rs33.getInt(3);	
				d1+=rs33.getInt(1);
					d2+=rs33.getInt(2);
					d3+=rs33.getInt(3);

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
			    // System.out.println("44:"+query44);
				rs44 = st4.executeQuery(query44);
				while(rs44.next())
				{
				poptot1=poptot1+rs44.getInt(1)+rs44.getInt(2)+rs44.getInt(3);		
								d4+=rs44.getInt(1);
					d5+=rs44.getInt(2);
					d6+=rs44.getInt(3);

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
				// System.out.println("55:"+query55);
				rs55 = st5.executeQuery(query55);
				while(rs55.next())
				{
				poptot2=poptot2+rs55.getInt(1)+rs55.getInt(2)+rs55.getInt(3);		
								d7+=rs55.getInt(1);
					d8+=rs55.getInt(2);
					d9+=rs55.getInt(3);

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
				// System.out.println("66:"+query66);
				rs66 = st6.executeQuery(query66);
				while(rs66.next())
				{
			     poptot3=poptot3+rs66.getInt(1)+rs66.getInt(2)+rs66.getInt(3);	
				 								d10+=rs66.getInt(1);
					d11+=rs66.getInt(2);
					d12+=rs66.getInt(3);
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
				// System.out.println("441:"+query441);
				rs441 = st11.executeQuery(query441);
				while(rs441.next())
				{
			     poptot4=poptot4+rs441.getInt(1)+rs441.getInt(2)+rs441.getInt(3);	
				 	d13+=rs441.getInt(1);
					d14+=rs441.getInt(2);
					d15+=rs441.getInt(3);
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
				// System.out.println("551:"+query551);
				rs551 = st12.executeQuery(query551);
				while(rs551.next())
				{
			     poptot5=poptot5+rs551.getInt(1)+rs551.getInt(2)+rs551.getInt(3);	
				 								d16+=rs551.getInt(1);
					d17+=rs551.getInt(2);
					d18+=rs551.getInt(3);
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
				// System.out.println("552:"+query552);
				rs552 = st13.executeQuery(query552);
				while(rs552.next())
				{
			     poptot6=poptot6+rs552.getInt(1)+rs552.getInt(2)+rs552.getInt(3);	
				 								d19+=rs552.getInt(1);
					d20+=rs552.getInt(2);
					d21+=rs552.getInt(3);
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
             <td class=rptValue><%=rs2.getString(4)%></td> <td class=rptValue><%=rs2.getString(6)%></td>
<td class=rptValue><%=rs2.getString(8)%></td> <td class=rptValue><%=rs2.getString(10)%></td>                      
             <td class=btext align="right"><%=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c12+c13+c14+c15+c16+c17+c18+c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot+poptot1+poptot2+poptot3+poptot4+poptot5+poptot6%></td>
		     <td class=rptValue align="right"><%=d1%></td>
			 <td class=rptValue align="right"><%=d2%></td>
		     <td class=rptValue align="right"><%=d3%></td>
			 <td class=btext align="right"><%=c1+c2+c3%></td>
			 <td class=btext align="right"><%=poptot%></td>
			 <td class=rptValue align="right"><%=d4%></td>
			 <td class=rptValue align="right"><%=d5%></td>
		     <td class=rptValue align="right"><%=d6%></td>
			 <td class=btext align="right"><%=c4+c5+c6%></td>
			 <td class=btext align="right"><%=poptot1%></td>
			 
			 
			 <td class=rptValue align="right"><%=d13%></td>
			 <td class=rptValue align="right"><%=d14%></td>
		     <td class=rptValue align="right"><%=d15%></td>
			 <td class=btext align="right"><%=c13+c14+c15%></td>
			 <td class=btext align="right"><%=poptot4%></td>
			 
			 
			 <td class=rptValue align="right"><%=d7%></td>
			 <td class=rptValue align="right"><%=d8%></td>
		     <td class=rptValue align="right"><%=d9%></td>
			 <td class=btext align="right"><%=c7+c8+c9%></td>
			 <td class=btext align="right"><%=poptot2%></td>
			 
			 <td class=rptValue align="right"><%=d16%></td>
			 <td class=rptValue align="right"><%=d17%></td>
		     <td class=rptValue align="right"><%=d18%></td>
			 <td class=btext align="right"><%=c16+c17+c18%></td>
			 <td class=btext align="right"><%=poptot5%></td>
			 
			 <td class=rptValue align="right"><%=d19%></td>
			 <td class=rptValue align="right"><%=d20%></td>
		     <td class=rptValue align="right"><%=d21%></td>
			 <td class=btext align="right"><%=c19+c20+c21%></td>
			 <td class=btext align="right"><%=poptot6%></td>
			 
			 <td class=rptValue align="right"><%=d10%></td>
			 <td class=rptValue align="right"><%=d11%></td>
		     <td class=rptValue align="right"><%=d12%></td>
			 <td class=btext align="right"><%=c10+c11+c12%></td>
			 <td class=btext align="right"><%=poptot3%></td>
		</tr>
		
		
<%	}
		catch(Exception e)
		{
          e.printStackTrace();
		}
		finally
		{
			rs33.close();rs44.close();rs55.close();rs66.close();rs441.close();rs551.close();rs552.close();
			st3.close();st4.close();st5.close();st6.close();st11.close();st12.close();st13.close();
           
		}
	  }
	}
	catch(Exception e1)
	{
      e1.printStackTrace();
    }
	finally
	{
		rs2.close();
		st2.close();
       
	}
%>
<tr><td class=btext colspan=5>Grand Totals</td>
	<td class=btext align="right" ><%=habtotals%></td>
	<td class=btext ><%=poptotals%></td>
	<td colspan=3></td>	
	<td class=btext align="right"><%=FChabtotals%></td>
	<td class=btext align="right"><%=FCPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=NShabtotals%></td>
	<td class=btext align="right"><%=NSPoptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC1habtotals%></td>
	<td class=btext align="right"><%=PC1Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC2habtotals%></td>
	<td class=btext align="right"><%=PC2Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right" ><%=PC3habtotals%></td>
	<td class=btext align="right"><%=PC3Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=PC4habtotals%></td>
	<td class=btext align="right"><%=PC4Poptotals%></td>
	<td colspan=3></td>
	<td class=btext align="right"><%=QAhabtotals%></td>
	<td class=btext align="right"><%=QAPoptotals%></td>
	
</tr>
</table>
<%}%>


<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

