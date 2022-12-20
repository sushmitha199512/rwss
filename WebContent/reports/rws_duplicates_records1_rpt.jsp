<%@ include file="conn3.jsp"%>

<%
	String dist=request.getParameter("district");
	String mand=request.getParameter("mandal");
	String panch=request.getParameter("panchayat");
	String vill=request.getParameter("village");
	String district1=request.getParameter("district1");

	ResultSet rs2=null,rs3=null;//rs1=null,
    Statement stmt2=null,stmt3=null;//stmt1=null,
    Statement st11=null,st2=null,st3=null,st4=null;
    ResultSet r1=null,r2=null,r3=null,r4=null;
    int sno=1;String noRecords = "";
    int val=0;
    String st10=null;
    String ss10=null;
%>

<table>
<tr rowspan="10"> 
<td></td>
</tr>
</table>

<%
if(dist!=null && district1!=null && district1.equals("04"))
{
 try
 {
 int rowCount=0;
 //System.out.println("in side habitation == ALL");
%>
<table border = 1 cellspacing = 0 cellpadding = 0 bgcolor="#DEE3E0" width=90% height=20% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr class="bwborder" bgcolor="white"><td class="btext" colspan=11></td></tr>

	<tr class="bwborder" bgcolor="white">	
		<td class="btext">S.No.</td>
		<td class="btext">dcode</td>
		<td class="btext">dname</td>
		<td class="btext">mcode</td>
		<td class="btext">mname</td>
		<td class="btext">pcode</td>
		<td class="btext">pname</td>
		<td class="btext">vcode</td>
		<td class="btext">vname</td>
		<td class="btext">Habcode</td>
		<td class="btext">Habname</td>
	</tr>
<%
	if(!dist.equals("ALL"))
	{
		String st101="select mcode,pcode,vcode,vname from rws_village_tbl where dcode='"+dist+"' ";
		if(!mand.equals("ALL"))
		{
			st101+=" and mcode='"+mand+"' ";
		}
		if(!panch.equals("ALL"))
		{
			st101+=" and pcode='"+panch+"' ";
		}
		if(!vill.equals("ALL"))
		{
			st101+=" and vcode='"+vill+"' ";
		}
		
		stmt3=conn.createStatement();
		rs3=stmt3.executeQuery(st101);
		while(rs3.next())
		{
			ss10=" (select panch_name from rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+dist+"' ";
			if(!mand.equals("ALL"))
			{
				ss10+=" and substr(panch_code,6,2)='"+mand+"' ";
			}
			if(mand.equals("ALL"))
			{
				ss10+=" and substr(panch_code,6,2)='"+rs3.getString(1)+"' ";
			}
			if(!panch.equals("ALL"))
			{
				ss10+=" and substr(panch_code,13,2)='"+panch+"' ";
			}
			if(panch.equals("ALL"))
			{
				ss10+=" and substr(panch_code,13,2)='"+rs3.getString(2)+"' ";
			}
			if(!vill.equals("ALL"))
			{
				ss10+=" and substr(panch_code,8,3)='"+vill+"' ";
			}
			if(vill.equals("ALL"))
			{
				ss10+=" and substr(panch_code,8,3)='"+rs3.getString(3)+"' ";
			}
			ss10+=" group by panch_name having count(panch_name)>1 )";	
			//System.out.println("ss10 query "+ss10);
			st10="select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,raj.panch_code,raj.panch_name from rws_mandal_tbl m,rws_district_tbl d,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd where raj.panch_name in "+ss10+" and d.dcode=m.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and hd.hab_code=raj.panch_code and substr(raj.panch_code,1,2)=d.dcode and substr (raj.panch_code,6,2)=m.mcode and substr(raj.panch_code,13,2)=p.pcode and substr(raj.panch_code,8,3)=v.vcode and d.dcode='"+dist+"'  and hd.coverage_status is not null and hd.coverage_status<>'UI' ";
			if(!mand.equals("ALL"))
			{
				st10+=" and m.mcode='"+mand+"' ";
			}
			if(mand.equals("ALL"))
			{
				st10+=" and m.mcode='"+rs3.getString(1)+"' ";
			}
			if(!panch.equals("ALL"))
			{
				st10+=" and p.pcode='"+panch+"' ";
			}
			if(panch.equals("ALL"))
			{
				st10+=" and p.pcode='"+rs3.getString(2)+"' ";
			}
			if(!vill.equals("ALL"))
			{
				st10+=" and v.vcode='"+vill+"' ";
			}
			if(vill.equals("ALL"))
			{
				st10+=" and v.vcode='"+rs3.getString(3)+"' ";
			}
			st10+="group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,raj.panch_code,raj.panch_name order by raj.panch_name ";
			
			//System.out.println("habs query :"+st10);
			st11=conn.createStatement();
			r1=st11.executeQuery(st10);	
			if(r1.isBeforeFirst())
			{
				while(r1.next())
				{
					//System.out.println("before rowcount"+rowCount);
					rowCount++;
					//System.out.println("after rowcount"+rowCount);
				}
			}
			r1=st11.executeQuery(st10);
			if(rowCount>1)
			{
				while(r1.next())
				{
%>
				<tr>
					<td><%=sno++ %></td>
					<td><%=r1.getString(1) %></td>
					<td><%=r1.getString(2) %></td>
					<td><%=r1.getString(3) %></td>		
					<td><%=r1.getString(4) %></td>
					<td><%=r1.getString(5) %></td>
					<td><%=r1.getString(6) %></td>
					<td><%=r1.getString(7) %></td>		
					<td><%=r1.getString(8) %></td>
					<td><%=r1.getString(9) %></td>		
					<td><%=r1.getString(10) %></td>
				</tr>
<%		
				}
				noRecords="a";
			}
		}
	}
	if(noRecords.equals(""))
	{
%>
		<tr>
		<td colspan="11">No Duplicate Records </td>
		</tr>
			
<%
	}
%>
	</table>
<%	
	}catch(Exception e)
	{
		System.out.println("Exception in jsp"+e);
	}
	finally
	{
		try{
		r1.close();
		st11.close();
}catch(Exception e)
{

}
	}
}
else if(dist!=null && district1!=null && district1.equals("01"))
{
	try
	{
		int rowCount=0;
		//System.out.println("in side mandal duplicates"+dist);
%>
<table border = 1 cellspacing = 0 cellpadding = 0 bgcolor="#DEE3E0" width=70% height=20% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr class="bwborder" bgcolor="white"><td class="btext" colspan=11></td></tr>

	<tr class="bwborder" bgcolor="white">	
		<td class="btext">S.No.</td>
		<td class="btext">dcode</td>
		<td class="btext">dname</td>
		<td class="btext">mcode</td>
		<td class="btext">mname</td>
	</tr>
<%	
	if(!dist.equals("ALL"))
	{
		String st101="select dcode,dname from rws_district_tbl where dcode='"+dist+"' ";
		stmt3=conn.createStatement();
		rs3=stmt3.executeQuery(st101);
		while(rs3.next())
		{	
		//System.out.println("rs3.getString(3)"+rs3.getString(1));	
		ss10="(select mname from rws_mandal_tbl where dcode='"+rs3.getString(1)+"' group by mname having count(mname)>1) ";
//		st10="select d.dcode,d.dname,m.mcode,m.mname from rws_mandal_tbl m,rws_district_tbl d,rws_panchayat_tbl p,rws_village_tbl v,rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl raj where  raj.panch_code=hd.hab_code and substr(hd.hab_code,1,2)=d.dcode and substr(hd.hab_code,6,2)=m.mcode and substr(hd.hab_code,13,2)=p.pcode and substr(hd.hab_code,8,3)=v.vcode and hd.coverage_status is not null and hd.coverage_status<>'UI' and m.mname in "+ss10+" and d.dcode=m.dcode and d.dcode='"+rs3.getString(1)+"' group by d.dcode,d.dname,m.mcode,m.mname order by m.mname";
		st10="select d.dcode,d.dname,m.mcode,m.mname from rws_mandal_tbl m,rws_district_tbl d,rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl raj where  raj.panch_code=hd.hab_code and substr(hd.hab_code,1,2)=d.dcode and substr(hd.hab_code,6,2)=m.mcode and hd.coverage_status is not null and hd.coverage_status<>'UI' and m.mname in "+ss10+" and d.dcode=m.dcode and d.dcode='"+rs3.getString(1)+"' group by d.dcode,d.dname,m.mcode,m.mname order by m.mname";
		//System.out.println("query"+st10);
		st11 = conn.createStatement();
		r1=st11.executeQuery(st10);
		//System.out.println("panch query "+st10);
		if(r1.isBeforeFirst())
		{
			while(r1.next())
			{
%>
		<tr>
			<td><%=sno++ %></td>
			<td><%=r1.getString(1) %></td>
			<td><%=r1.getString(2) %></td>
			<td><%=r1.getString(3) %></td>		
			<td><%=r1.getString(4) %></td>
		</tr>
<%		
			}
		}
		else
		{
%>
			<tr>
			<td colspan="5">No Duplicate Records </td>
			</tr>
<%		}
	  }
	}
%>
	</table>
<%
	}catch(Exception e)
	{
		System.out.println("Exception in jsp"+e);
	}
	finally
	{
		try{
			r1.close();
			st11.close();
			}catch(Exception e)
			{
			
			}		
	}
}
else if(dist!=null && district1!=null && district1.equals("02"))
{
  try
  {
	int rowCount=0;
	//System.out.println("in side the panchayat Names");
%>
<table border = 1 cellspacing = 0 cellpadding = 0 bgcolor="#DEE3E0" width=70% height=20% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr class="bwborder" bgcolor="white"><td class="btext" colspan=11></td></tr>

	<tr class="bwborder" bgcolor="white">	
		<td class="btext">S.No.</td>
		<td class="btext">dcode</td>
		<td class="btext">dname</td>
		<td class="btext">mcode</td>
		<td class="btext">mname</td>
		<td class="btext">pcode</td>
		<td class="btext">pname</td>
	</tr>
	<%
	st11=conn.createStatement();
	
	if(!dist.equals("ALL"))
	{
		String st101="select mcode,mname from rws_mandal_tbl where dcode='"+dist+"' ";
		if(!mand.equals("ALL"))
		{
		   st101+=" and mcode='"+mand+"' ";
		}
	
		stmt3=conn.createStatement();
		rs3=stmt3.executeQuery(st101);
		while(rs3.next())
		{	
			//System.out.println("rs3.getString(3)"+rs3.getString(1));	
			ss10="(select pname from rws_panchayat_tbl where dcode='"+dist+"' and ";
			if(!mand.equals("ALL"))
			{
				ss10+="mcode='"+mand+"' ";
			}
			else
			{
				ss10+=" mcode='"+rs3.getString(1)+"' ";
			}
			ss10+=" group by pname having count(pname)>1) ";
			
			st10="select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname from rws_mandal_tbl m,rws_district_tbl d,rws_panchayat_tbl p,rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl raj where  raj.panch_code=hd.hab_code and p.pname in "+ss10+" and d.dcode=m.dcode and p.dcode=m.dcode and p.mcode=m.mcode  and d.dcode='"+dist+"' and substr(hd.hab_code,1,2)=d.dcode and substr(hd.hab_code,6,2)=m.mcode and substr(hd.hab_code,13,2)=p.pcode and hd.coverage_status is not null and hd.coverage_status<>'UI' and "; 
			if(!mand.equals("ALL"))
			{
				st10+=" m.mcode='"+mand+"' ";
			}
			else
			{
				st10+=" m.mcode='"+rs3.getString(1)+"' ";
			}
			st10+=" group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname order by p.pname";
			//System.out.println("query "+st10);
		
			r1=st11.executeQuery(st10);
			//System.out.println("Panchayat query "+st10);
			if(r1.isBeforeFirst())
			{
				while(r1.next())
				{
					//System.out.println("rowCount "+rowCount);
					rowCount++;
					//System.out.println("rowCount++ "+rowCount);
				}
			}
			r1=st11.executeQuery(st10);
			
			if(rowCount>1)
			{
				while(r1.next())
				{
%>
				<tr>
					<td><%=sno++ %></td>
					<td><%=r1.getString(1) %></td>
					<td><%=r1.getString(2) %></td>
					<td><%=r1.getString(3) %></td>		
					<td><%=r1.getString(4) %></td>
					<td><%=r1.getString(5) %></td>		
					<td><%=r1.getString(6) %></td>
				</tr>
<%		
				}
			noRecords = "a";
			}
		}
	}
    if(noRecords.equals(""))
	{
%>
		<tr>
		<td colspan="7">No Duplicate Records </td>
		</tr>
			
<%	}
%>
	</table>
<%
	}catch(Exception e)
	{
		System.out.println("Exception in jsp"+e);
	}
	finally
	{
	try{
		r1.close();
		st11.close();
		}catch(Exception e)
		{}
	}
}
else if(dist!=null && district1!=null && district1.equals("03"))
{
	int count=0;
	int rowCount=0;
	String st101=null;
	try
	{

%>
<table border = 1 cellspacing = 0 cellpadding = 0 bgcolor="#DEE3E0" width=70% height=20% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr class="bwborder" bgcolor="white"><td class="btext" colspan=11></td></tr>

	<tr class="bwborder" bgcolor="white">	
		<td class="btext">S.No.</td>
		<td class="btext">dcode</td>
		<td class="btext">dname</td>
		<td class="btext">mcode</td>
		<td class="btext">mname</td>
		<td class="btext">pcode</td>
		<td class="btext">pname</td>
		<td class="btext">vcode</td>
		<td class="btext">vname</td>
	</tr>
<%
	st11=conn.createStatement();
	//System.out.println("1");
		if(!dist.equals("ALL"))
		{	
		st101="select mcode,pcode,pname from rws_panchayat_tbl where dcode='"+dist+"' ";
		if(!mand.equals("ALL"))
		{
		  st101+=" and mcode='"+mand+"' ";
		}
		if(!panch.equals("ALL"))
		{
		  st101+=" and pcode='"+panch+"' ";
		}
		//System.out.println("2"+st101);
		stmt3=conn.createStatement();
		rs3=stmt3.executeQuery(st101);
		while(rs3.next())
		{	
			ss10="(select vname from rws_village_tbl where dcode='"+dist+"' ";
			if(!mand.equals("ALL"))
			{
				ss10+=" and mcode='"+mand+"' ";
			}
			if(mand.equals("ALL"))
			{
				ss10+=" and mcode='"+rs3.getString(1)+"' ";
			}
			if(!panch.equals("ALL"))
			{
				ss10+=" and pcode='"+panch+"' ";
			}
			if(panch.equals("ALL"))
			{
				ss10+=" and pcode='"+rs3.getString(2)+"' ";
			}
		ss10+=" group by vname having count(vname)>1)";
		//System.out.println("3"+ss10);

		st10="select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl raj where  raj.panch_code=hd.hab_code and v.vname in "+ss10+" and d.dcode=m.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and d.dcode='"+dist+"' and substr(hd.hab_code,1,2)=d.dcode and substr(hd.hab_code,6,2)=m.mcode and substr(hd.hab_code,13,2)=p.pcode and substr(hd.hab_code,8,3)=v.vcode and hd.coverage_status is not null and hd.coverage_status<>'UI' ";
		if(!mand.equals("ALL"))
		{
			st10+=" and m.mcode='"+mand+"' ";
		}
		else
		{
			st10+=" and m.mcode='"+rs3.getString(1)+"' ";
		}
		if(!panch.equals("ALL"))
		{
			st10+=" and p.pcode='"+panch+"' ";
		}
		else
		{		
			st10+=" and p.pcode='"+rs3.getString(2)+"' ";
		}	
		st10+=" group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname order by v.vname";
		//System.out.println("Duplicate query "+st10);
	
		r1=st11.executeQuery(st10);
		//System.out.println("Village query "+st10);
		if(r1.isBeforeFirst())
		{
			while(r1.next())
			{
				//System.out.println("rowCount "+rowCount);
				rowCount++;
				//System.out.println("rowCount++ "+rowCount);
			}
		}
		r1=st11.executeQuery(st10);
		
		if(rowCount>1)
		{
			while(r1.next())
			{
%>
			<tr>
				<td><%=sno++ %></td>
				<td><%=r1.getString(1) %></td>
				<td><%=r1.getString(2) %></td>
				<td><%=r1.getString(3) %></td>		
				<td><%=r1.getString(4) %></td>
				<td><%=r1.getString(5) %></td>		
				<td><%=r1.getString(6) %></td>
				<td><%=r1.getString(7) %></td>		
				<td><%=r1.getString(8) %></td>
			</tr>
<%		
			}
		noRecords="a";
		}
	}
	}
	if(noRecords.equals(""))
	{
%>
	<tr>
	<td colspan="9">No Duplicate Records </td>
	</tr>
		
<%	}
%>
	</table>
<%
	}catch(Exception e)
	{
		System.out.println("Exception in jsp"+e);
	}
	finally
	{
	try{
		r1.close();
		st11.close();
		}catch(Exception e)
		{
		
		}
	}
}
%>


