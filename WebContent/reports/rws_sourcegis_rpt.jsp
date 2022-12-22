<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null,stmt131=null;
    StringBuffer qry=new StringBuffer();

	ResultSet rs8=null,rs131=null;
	StringBuffer dname=new StringBuffer(request.getParameter("dname"));
    session.setAttribute("dname",dname); 
	StringBuffer mname=new StringBuffer(request.getParameter("mname"));
    session.setAttribute("mname",mname);
	StringBuffer dcode=new StringBuffer(request.getParameter("district"));
    session.setAttribute("dcode",dcode);
	StringBuffer mcode=new StringBuffer(request.getParameter("mandal"));
    session.setAttribute("mcode",mcode);
	//System.out.println("mcode***********"+mcode);
	int i=0;
	StringBuffer sname=new StringBuffer(request.getParameter("sname"));
    session.setAttribute("sname",sname);
	//System.out.println("sname*************"+sname);
	StringBuffer categorytype=new StringBuffer();
	StringBuffer name=new StringBuffer();
	if(sname.toString().equals("SUBSURFACE"))
	{
		categorytype.append("SUBSURFACE");
		name.append("1");
	}
	else if(sname.toString().equals("SURFACE"))
	{
		categorytype.append("SURFACE");
		name.append("2");
	}
   else if(sname.toString().equals("SUBSURFACE(Handpump)"))
   {
//System.out.println("sna"+sname);
	   categorytype.append("SUBSURFACE(Handpump)");
	   name.append("3");
   }
   else if(sname.toString().equals("SUBSURFACE(ShallowHandpump)"))
   {
      // System.out.println("sna"+sname);
	   categorytype.append("SUBSURFACE(ShallowHandpump)");
	   name.append("4");
   }
else if(sname.toString().equals("SUBSURFACE(Openwell)"))
   {
      // System.out.println("sna"+sname);
	   categorytype.append("SUBSURFACE(Openwell)");
	   name.append("5");
	   
   }
else if(sname.toString().equals("GLSR"))
   {
      // System.out.println("sna"+sname);
	   categorytype.append("GLSR");
	   name.append("6");
   }
else if(sname.toString().equals("OHSR"))
   {
     //  System.out.println("sna"+sname);
	   categorytype.append("OHSR");
	   name.append("7");
   }
else if(sname.toString().equals("GLBR"))
	
		
   {
       //System.out.println("sna"+sname);
	   categorytype.append("GLBR");
	    name.append("8");
   }



//SUBSURFACE(OW)
   	int sno=1;
   	String []sh=null;
    StringBuffer sh1=new StringBuffer();
    StringBuffer sh2=new StringBuffer();
    StringBuffer sh3=new StringBuffer();
    StringBuffer sh4=new StringBuffer();
    StringBuffer sh5=new StringBuffer();
    StringBuffer sw=new StringBuffer();
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back |&nbsp;</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	</a></td><td><a href="./rws_sourcegis_excel.jsp" target=_new>Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > GIS Sources  Information - Report</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
	<td class=btext>District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Source Type:<font color=red><%=categorytype%> </font></td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext  nowrap align=center>Sl.No</td>
    <td class=btext  nowrap align=center>Mandal</td>
	<td class=btext  nowrap align=center>Panchayat</td>
	<td class=btext  nowrap align=center>Habitation Name</td>
    	<td class=btext  nowrap align=center>Habitation Code</td>
    <td class=btext  nowrap align=center>Source Code</td>
	<td class=btext  nowrap align=center>Source Name</td>
	<td class=btext  nowrap align=center>Way Point</td>
	<td class=btext  nowrap align=center>Latitude -N</td>
    <td class=btext  nowrap align=center>Longitude -E</td>
	<td class=btext  nowrap align=center>Elevation</td>
	</tr>
<%
try
{
	qry.delete(0,qry.length());

       qry.append("select mname,pname,panch_code,panch_name,c.hab_code   from rws_complete_hab_view b,rws_asset_mast_tbl c where c.hab_code=b.panch_code and   substr(panch_code,1,2)='"+dcode.toString()+"'");

		   qry.append("order by panch_code");
        stmt8=conn.createStatement(); 
        stmt131=conn.createStatement();
	   //System.out.println(" handpumps:"+qry);
	    rs131=stmt131.executeQuery(qry.toString());
	    Hashtable hp1=new Hashtable();
		while(rs131.next())
	   {
		hp1.put(rs131.getString(5),rs131.getString(1)+"#"+rs131.getString(2)+"#"+rs131.getString(3)+"#"+rs131.getString(4));
       
	   }
	if(rs131!=null)rs131.close();
	if(stmt131!=null)stmt131.close();

	qry.delete(0,qry.length());
	if(name.toString().equals("1"))
    {
       qry.append("select substr(source_code,1,16),source_code,nvl(source_name,'-'),nvl(subCompTbl.way_point,0),nvl(subCompTbl.latitude,0.0),nvl(subCompTbl.longitude,0.0),nvl(subCompTbl.elevation,0.0)  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE in('01','02','03','09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and substr(M.HAB_CODE,1,2)='"+dcode.toString()+"' and subCompTbl. SOURCE_TYPE_CODE ='1' ");
      
	
    if(mcode.toString()!=null && !mcode.toString().equals(""))
		{
	qry.append("and substr(m.hab_code,6,2)='"+mcode.toString()+"'");
	}
	qry.append(" order by source_code ");
   }
	else if(name.toString().equals("2") )
	{		
		
		qry.append("select substr(source_code,1,16),source_code,nvl(source_name,'-'),nvl(subCompTbl.way_point,0),nvl(subCompTbl.latitude,0.0),nvl(subCompTbl.longitude,0.0),nvl(subCompTbl.elevation,0.0)  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE in('01','02','03','09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and substr(M.HAB_CODE,1,2)='"+dcode.toString()+"' and subCompTbl. SOURCE_TYPE_CODE ='2' ");
       
		if(mcode.toString()!=null && !mcode.toString().equals(""))
		{
	     qry.append("and substr(m.hab_code,6,2)='"+mcode.toString()+"'");
	    }
	   qry.append(" order by source_code ");
	}
	else if(name.toString().equals("3"))
	{
		
         qry.append("select substr(hp_code,1,16),hp_code,nvl(b.way_point,0),nvl(b.latitude,0.0),nvl(b.longitude,0.0),nvl(b.elevation,0.0)    from rws_hp_subcomp_param_tbl b,rws_asset_mast_tbl am,rws_asset_scheme_tbl at where    b.asset_code=am.asset_code and b.asset_code=at.asset_code and type_of_asset_code='04'  and  substr(at.scheme_code,1,2)='"+dcode.toString()+"'    ");

		if(mcode.toString()!=null && !mcode.toString().equals(""))
		{
	     qry.append("and substr(at.scheme_code,6,2)='"+mcode.toString()+"'");
		 }
	    qry.append(" order by b.hp_code ");
	}
	///RWS_SHALLOWHANDPUMPS_TBL
    	else if(name.toString().equals("4"))
	{
		
       qry.append("select substr(shallowhp_code,1,16),shallowhp_code,nvl(b.way_point,0),nvl(b.latitude,0.0),nvl(b.longitude,0.0),nvl(b.elevation,0.0)    from rws_shallowhandpumps_tbl b,rws_asset_mast_tbl am,rws_asset_scheme_tbl at where    b.asset_code=am.asset_code and b.asset_code=at.asset_code and type_of_asset_code='05'  and  substr(at.scheme_code,1,2)='"+dcode.toString()+"'    ");
		if(mcode.toString()!=null && !mcode.toString().equals(""))
		{
	    qry.append("and substr(at.scheme_code,6,2)='"+mcode+"'");
		 }
	    qry.append(" order by shallowhp_code ");
	}
//rws_open_well_mast_tbl
    else if(name.toString().equals("5"))
	{
		
        qry.append("select substr(openwell_code,1,16),openwell_code,nvl(b.way_point,0),nvl(b.latitude,0.0),nvl(b.longitude,0.0),nvl(b.elevation,0.0)    from rws_open_well_mast_tbl b,rws_asset_mast_tbl am,rws_asset_scheme_tbl at where    b.asset_code=am.asset_code and b.asset_code=at.asset_code and type_of_asset_code='06'  and  substr(at.scheme_code,1,2)='"+dcode.toString()+"'    ");
		if(mcode!=null && !mcode.equals(""))
		{
	     qry.append("and substr(at.scheme_code,6,2)='"+mcode.toString()+"'");
		 }
	    qry.append(" order by openwell_code ");
	}
    else if(name.toString().equals("6"))
	{
	
        
        qry.append("select     substr(glsr_code,1,16),glsr_code,nvl(subCompTbl.way_point,0),nvl(subCompTbl.latitude,0.0),nvl(subCompTbl.longitude,0.0),nvl(subCompTbl.elevation,0.0)  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE IN ('01','02','03') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and substr(M.HAB_CODE,1,2)='"+dcode.toString()+"'");
		if(mcode!=null && !mcode.equals(""))
		{
	     qry.append("and substr(m.hab_code,6,2)='"+mcode.toString()+"'");
		 }
	    qry.append(" order by glsr_code ");
	}
   else if(name.toString().equals("7"))
	{
		
        
        qry.append("select substr(ohsr_code,1,16),ohsr_code,nvl(subCompTbl.way_point,0),nvl(subCompTbl.latitude,0.0),nvl(subCompTbl.longitude,0.0),nvl(subCompTbl.elevation,0.0)  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE IN ('01','02','03') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and substr(M.HAB_CODE,1,2)='"+dcode.toString()+"'");
		if(mcode.toString()!=null && !mcode.toString().equals(""))
		{
	   
		//  gqry.append("and substr(m.hab_code,6,2)='"+mcode.toString()+"'");
	     qry.append("and substr(m.hab_code,6,2)='"+mcode.toString()+"'");
		 }
	

		 qry.append("order by ohsr code");
	}
    else if(name.toString().equals("8"))
	{
		qry.append("select   substr(glbr_code,1,16),glbr_code,nvl(subCompTbl.way_point,0),nvl(subCompTbl.latitude,0.0),nvl(subCompTbl.longitude,0.0),nvl(subCompTbl.elevation,0.0)  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLBR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE IN ('01','02','03') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and substr(M.HAB_CODE,1,2)='"+dcode.toString()+"'");
        
		if(mcode.toString()!=null && !mcode.toString().equals(""))
		{
	     qry.append("and substr(m.hab_code,6,2)='"+mcode.toString()+"'");
		 }
	    qry.append(" order by glbr_code ");
	}
//

//
		
    //System.out.println("gqry***********:"+gqry);
	rs8=stmt8.executeQuery(qry.toString());
   if(rs8.isBeforeFirst())
   {
	while (rs8.next())
	{
		i=i+1;
		//
sw.delete(0,sw.length());
sh1.delete(0,sh1.length());
sh2.delete(0,sh2.length());
sh3.delete(0,sh3.length());
sh4.delete(0,sh4.length());

		//
      
    sw.append((String.valueOf(hp1.get(rs8.getString(1)))));
	if(sw.toString()!=null && !sw.toString().equals("") && !sw.toString().equals("null"))
		
	{
		
		sh=sw.toString().split("#");
		
    sh1.append(sh[0]);
	sh2.append(sh[1]);
	sh3.append(sh[2]);
    sh4.append(sh[3]);
    
	
	
	}
	else{
	sh1.append("-");
	sh2.append("-");
	sh3.append("-");
    sh4.append("-");
    
	}

//
		%>
	<tr>
    <td class="rptValue"><%=sno++%></td>
    <td class="rptValue" align=left><%=sh1%></td>
    <td class="rptValue" align=left><%=sh2%></td>  
    <td class="rptValue" align=left><%=sh4%></td>
        <td class="rptValue" align=left><%=sh3%></td>
    
 <% if(sname.toString().equals("SUBSURFACE(Handpump)") || sname.toString().equals("OHSR")  || sname.toString().equals("GLBR")  || sname.toString().equals("GLSR") ||  sname.toString().equals("SUBSURFACE(Openwell)") || sname.toString().equals("SUBSURFACE(ShallowHandpump)")){%>
<td class="rptValue" align=center><%=rs8.getString(2)%></td>
<td class="rptValue" align=left>-</td>
	
	<td class="rptValue" align=center><%=rs8.getInt(3)%></td>
	<td class="rptValue" align=center><%=rs8.getDouble(4)%></td>
	<td class="rptValue" align=center><%=rs8.getDouble(5)%></td>
	<td class="rptValue" align=center><%=rs8.getDouble(6)%></td>
   	</tr>
<%}
else{%>
	<td class="rptValue"><%=rs8.getString(2)%></td>
   	<td class="rptValue"><%=rs8.getString(3)%></td>
<td class="rptValue" align=center><%=rs8.getInt(4)%></td>
	<td class="rptValue" align=center><%=rs8.getDouble(5)%></td>
	<td class="rptValue" align=center><%=rs8.getDouble(6)%></td>
	<td class="rptValue" align=center><%=rs8.getDouble(7)%></td> 
</tr>

    <%}
}}else{ %>
		<script>
		alert(" No Matching data is Found- You are redirected to Previous page");
		document.location.href="rws_sourcesgis_frm.jsp";
		</script>
<%
 }
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}
finally
{
	dname=null;
	dcode=null;
	mcode=null;
	sname=null;
	categorytype=null;
	name=null;
	sh=null;
	sh1=null;
	sh2=null;
	sh3=null;
	sh4=null;
	qry=null;
	
			
try
{
if(stmt8 != null)
{
stmt8.close();
}
if(rs8 != null)
{
rs8.close();
}
if( conn != null )
{
conn.close();
}
}
catch(SQLException p)
{
p.printStackTrace();
}
}
%>
     

</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

  
