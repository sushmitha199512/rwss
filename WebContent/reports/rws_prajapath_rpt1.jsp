<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
	
	String rDistrict=null, rProgramme=null,rProg=null,dcode=null, panchcode=null, mancode=null,distcode=null;
	rDistrict = request.getParameter("district");
	//out.println("district"+rDistrict);
	dcode = request.getParameter("dcode1");
	//out.println("dcode"+dcode);
	mancode = request.getParameter("mcode");
   // out.println("mannnn"+mancode);
	distcode = request.getParameter("dcode");
	//out.println("disttttttt"+distcode);
	panchcode=request.getParameter("pcode");
	
	rProgramme = request.getParameter("program");
	//out.println("proggRA"+rProgramme);
	 rProg = request.getParameter("prog");
	 
	
	String districtName = (String)session.getAttribute("circleName");
	String mandalName = (String)session.getAttribute("prName");
	
	
	
	String query=null, query1 = null,query2=null,query3=null,habcode=null;
	ResultSet rs3 = null;
	ResultSet rs2 = null;
	Statement stmt3 = null;
	Statement stmt1 = null;
	//PreparedStatement ps = null;
	int total=0;
	int i = 0;
	//int[] gcount = new int[8];
	//int[] gcount1= new int[8];
	//String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
try
{
%>
<html>
<body bgcolor="white" class="mystyle">

<form method="post">
<table width="100%">
<tr><td>
<font size="1px"  color="blue">
<div align="left" >
<%if(districtName!=null && !districtName.equals("null")){ %>
District: &nbsp;&nbsp;<%= districtName %>&nbsp;&nbsp;&nbsp;
<%}%>
<%if(mandalName!=null && !mandalName.equals("null")) {%>
Program: &nbsp;&nbsp;<%= mandalName %>&nbsp;&nbsp;&nbsp;
<%}
%>

</div></font>
</td></tr>
<tr><td align="right" colspan="20"><a href="/pred/home.jsp?loginMode=prajapatham">Home &nbsp;|</a>&nbsp;<a href="rws_programmes_frm.jsp">Back</a></td></tr>
</table>
<%
     if(rDistrict!=null && rDistrict.equals("0") && rProgramme!=null && rProgramme.equals("0"))
			{ 
	if(dcode==null && rProg==null)
				{
		  
	query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_district_tbl d,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=d.dcode AND HD.HAB_CODE=P.HAB_CODE and pr.panch_code=P.hab_code order by P.HAB_CODE ";
				}
else if(dcode!=null && rProg!=null && distcode==null && mancode==null && panchcode==null)
				{
					
  query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_district_tbl d,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=d.dcode AND HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+dcode+"' and P.programme_code='"+rProg+"' order by P.HAB_CODE ";
				}
				else if(dcode==null && rProg!=null && distcode!=null && mancode!=null && panchcode==null)
				{
                 query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_mandal_tbl m,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=m.dcode AND substr(P.hab_code,6,2)=m.mcode and HD.HAB_CODE=P.HAB_CODE and pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+distcode+"' AND substr(P.hab_code,6,2)='"+mancode+"' and P.programme_code='"+rProg+"' order by P.HAB_CODE ";
				}
				else if(dcode==null && rProg!=null && distcode!=null && mancode!=null && panchcode!=null)
				{
		  
                 query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_panchayat_tbl pp,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=pp.dcode AND substr(P.hab_code,6,2)=pp.mcode and substr(P.hab_code,13,2)=pp.pcode and HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+distcode+"' AND substr(P.hab_code,6,2)='"+mancode+"' AND substr(P.hab_code,13,2)='"+panchcode+"' and P.programme_code='"+rProg+"' order by P.HAB_CODE ";
				}
			}
	else if(rDistrict!=null && rDistrict.equals("0") && rProgramme!=null && !rProgramme.equals("0") && distcode!=null && mancode==null && panchcode==null)
			{
	              //out.println("in 5");
                 query3="SELECT distinct P.HAB_CODE,pr.panch_name  FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_district_tbl d,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=d.dcode AND HD.HAB_CODE=P.HAB_CODE and pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+distcode+"' and P.programme_code='"+rProgramme+"' order by P.HAB_CODE ";
			}
			else if(rDistrict!=null && !rDistrict.equals("0") && rProgramme!=null && rProgramme.equals("0") && mancode==null && panchcode==null && rProg!=null)
	{
	  //out.println("in 6");
                 query3="SELECT distinct P.HAB_CODE,pr.panch_name  FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_district_tbl d,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=d.dcode AND HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+rDistrict+"' and  P.programme_code='"+rProg+"' order by P.HAB_CODE ";
    }
	 else if(rDistrict!=null && !rDistrict.equals("0") && rProgramme!=null && !rProgramme.equals("0") && mancode==null)
	{
 //out.println("in 7");
	 query3="SELECT distinct P.HAB_CODE,pr.panch_name  FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_district_tbl d,rws_panchayat_raj_tbl pr  WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=d.dcode AND HD.HAB_CODE=P.HAB_CODE and   pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+rDistrict+"' and P.programme_code='"+rProgramme+"' order by P.HAB_CODE ";
	}
	 else if(rDistrict!=null && !rDistrict.equals("0") && rProgramme!=null && !rProgramme.equals("0") && mancode!=null)
	{
      //out.println("in 8");
	 query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_mandal_tbl m,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=m.dcode AND substr(P.hab_code,6,2)=m.mcode and HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+rDistrict+"' and substr(P.hab_code,6,2)='"+mancode+"' and P.programme_code='"+rProgramme+"' order by P.HAB_CODE";
    }
	else if(rDistrict!=null && !rDistrict.equals("0") && rProgramme!=null && rProgramme.equals("0") && mancode!=null && panchcode==null && rProg!=null)
	{
	             //out.println("in 9");
				
				// out.println("in mandal all prog n dist sel");
                 query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_mandal_tbl m,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=m.dcode AND  substr(P.hab_code,6,2)=m.mcode and HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+rDistrict+"' and substr(P.hab_code,6,2)='"+mancode+"' and P.programme_code='"+rProg+"' order by P.HAB_CODE ";
	}
    else if(rDistrict!=null && rDistrict.equals("0") && rProgramme!=null && !rProgramme.equals("0") && mancode!=null && panchcode==null)
			{
	            //out.println("in 10");

                 query3="SELECT distinct P.HAB_CODE,pr.panch_name  FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_mandal_tbl m,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=m.dcode AND  substr(P.hab_code,6,2)=m.mcode and HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+distcode+"' and substr(P.hab_code,6,2)='"+mancode+"' and  P.programme_code='"+rProgramme+"' order by P.HAB_CODE ";
			}
			else if(rDistrict!=null && !rDistrict.equals("0") && rProgramme!=null && !rProgramme.equals("0") && mancode!=null && panchcode!=null)
	{
      // out.println("in 12");
	 query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_panchayat_tbl pp,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=pp.dcode AND substr(P.hab_code,6,2)=pp.mcode AND substr(P.hab_code,13,2)=pp.pcode and HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+rDistrict+"' and substr(P.hab_code,6,2)='"+mancode+"' and substr(P.hab_code,13,2)='"+panchcode+"' and  P.programme_code='"+rProgramme+"' order by P.HAB_CODE";
    }
	else if(rDistrict!=null && !rDistrict.equals("0") && rProgramme!=null && rProgramme.equals("0") && mancode!=null && panchcode!=null && rProg!=null)
	{
	              //out.println("in 13");
                 query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_panchayat_tbl pp,rws_panchayat_raj_tbl pr WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=pp.dcode AND substr(P.hab_code,6,2)=pp.mcode AND substr(P.hab_code,13,2)=pp.pcode and HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+rDistrict+"' and substr(P.hab_code,6,2)='"+mancode+"' and substr(P.hab_code,13,2)='"+panchcode+"' and P.programme_code='"+rProg+"' order by P.HAB_CODE";
	}
	else if(rDistrict!=null && rDistrict.equals("0") && rProgramme!=null && !rProgramme.equals("0") && distcode!=null && mancode!=null && panchcode!=null)
			{
	             // out.println("in 14");

                 query3="SELECT distinct P.HAB_CODE,pr.panch_name FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_panchayat_tbl pp,rws_panchayat_raj_tbl pr  WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=pp.dcode AND  substr(P.hab_code,6,2)=pp.mcode and substr(P.hab_code,13,2)=pp.pcode and HD.HAB_CODE=P.HAB_CODE and  pr.panch_code=P.hab_code and substr(P.hab_code,1,2)='"+distcode+"' and substr(P.hab_code,6,2)='"+mancode+"' and substr(P.hab_code,13,2)='"+panchcode+"' and P.programme_code='"+rProgramme+"' order by P.HAB_CODE ";
			}
	stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs3= stmt3.executeQuery(query3);
	int slno=0;
	%>

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "left">
<tr><td  align="center" colspan=3 class="rptLabel">Habitation Details</td></tr>
<tr>
<td class="rptLabel">Slno</td>
<td class="rptLabel">HabitationCode</td>
<td class="rptLabel">HabitationName</td>
</tr>
<tr>
<% 
	while(rs3.next())
	{
	slno++;
	%>
	
	<tr>
	 <td class="rptValue"><%=slno%></td>
     <td class="rptValue"><a   href="./rws_prajapath_rpt2.jsp?habcode=<%=rs3.getString(1)%>"><%=rs3.getString(1)%></a></td>
      <td class="rptValue"><%=rs3.getString(2)%></td>
     </tr>
	<%
	}
	 
	}
			

catch(Exception e)
{
//System.out.println("Exception is "+e);
	//e.printStackTrace();
}
finally
{
	conn.close();
	
	
}
%>

</table>
</div>
</form>
</body>
</html>
<%@ include file="footer.jsp" %>
