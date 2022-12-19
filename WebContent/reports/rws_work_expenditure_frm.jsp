<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//.out.println("*****FROM BEGINING*****");
	String query, query1, query2, query3, query4 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;	
	String rDist= null,rWork=null,rDiv=null,rSubDiv=null,rScheme=null,rYear=null;
	String rPlan=null,rAug=null,rProg=null,rsProg=null,rWorks=null,rWorkcat=null;
	String wcatsel="",progsel="",plansel="",distsel="";
	
	rDist = request.getParameter("district");
	rDiv = request.getParameter("division");
	rSubDiv = request.getParameter("subdivision");
	rScheme = request.getParameter("scheme");		
	rPlan = request.getParameter("plan");
	rWork= request.getParameter("work");			
	rAug=request.getParameter("augmentation");
	rProg=request.getParameter("programme");
	rsProg=request.getParameter("subprogramme");
	rWorks=request.getParameter("workName");
	rYear=request.getParameter("year");
	
	if(rDist==null)
 {	
 		session.removeAttribute("divName");
		session.removeAttribute("subdivName");
		session.removeAttribute("schName");
		session.removeAttribute("augName");	
		session.removeAttribute("progName"); 
		session.removeAttribute("sprogName"); 
		session.removeAttribute("PlanName");
		session.removeAttribute("workcName");		
		session.removeAttribute("yrName");		
		
 }
	
		
%>

<html>
<head>

<script language="JavaScript">

	function fnSubmit()
	{
		
		if(document.f1.district.selectedIndex == "")
		{
			alert("Circle Mandatory...");
			return false;
		}
		if(document.f1.year.selectedIndex == "")
		{
			alert("year(Admin_Sanc_Year) Mandatory...");
			return false;
		}
		
		document.f1.action="./expenditure.jsp";
		document.f1.submit();		
	}

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Work Expenditure Report</td>	
	</tr>

<%				
try
{		
	if(rDist == null || rDist.equals(""))
	{
%>
	<tr>
		<td class=rptLabel>Circle&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("dCode", null);
			session.setAttribute("dName", null);
	}
	if(rDist != null && !rDist.equals(""))  
	{	
%>
		<td class=rptLabel>Circle&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("dCode", rDist);
	}	
	try{
	stmt = conn.createStatement();
	query = "SELECT distinct d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d,rws_work_admn_tbl w,RWS_work_expenditure_tbl work where w.work_id=work.work_id and d.circle_office_code=substr(w.office_code,2,2) order by d.circle_office_name";
	rs = stmt.executeQuery(query);	
	while(rs.next())
	{
		if(rDist != null && rDist.equals(rs.getString(1)))
		{	
		distsel="yes";	
					
%>
		<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
		request.setAttribute("dCode", rDist);
		session.setAttribute("dName", rs.getString(2));
		}
		else
		{					
%>
		<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
		request.setAttribute("dCode", rDist);
		}
	}
	}catch(Exception e)
	{	
	}
	finally
	{
		rs.close();			
		stmt.close();
	}
%>
	</select>
	</td>
	</tr>
<%	if(rDist == null || rDist.equals(""))
	{
%>
	<tr>
		<td class=rptLabel>Division&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="division" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("divCode", null);
		session.setAttribute("divName", null);
	}
	else if(!rDist.equals(""))  
	{
%>
		<td class=rptLabel>Division&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="division"  class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
	request.setAttribute("divCode", rDiv);
	try{		
	stmt = conn.createStatement();
		/*query = "SELECT distinct d.circle_office_code,d.circle_office_name  from rws_circle_office_tbl d,rws_work_admn_tbl w where d.circle_office_code=substr(w.office_code,2,2) order by  d.circle_office_code";*/
		query = "select distinct d.division_office_code,d.division_office_name from rws_division_office_tbl d,rws_work_admn_tbl w,RWS_work_expenditure_tbl work where w.work_id=work.work_id and d.circle_office_code=substr(w.office_code,2,2) and d.division_office_code=substr(w.office_code,4,1) and substr(w.office_code,2,2)='"+rDist+"'";
		if(rDist!=null && !rDist.equals(""))
		{
		rs = stmt.executeQuery(query);
		while(rs.next())
		{
			if(rDiv != null && rDiv.equals(rs.getString(1)))
			{					
%>
		<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
				request.setAttribute("divCode", rDiv);
				session.setAttribute("divName", rs.getString(2));
			}
			else
				{					
%>
		<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
				request.setAttribute("divCode", rDiv);
				}
		}
		}
		}catch(Exception e)
	{	
	}
	finally
	{
		rs.close();			
		stmt.close();
	}
	}
%>
			</select>
		</td>
	</tr>
	


	<%//	*******************************************************************************
	
	if(rDist == null || rDist.equals(""))
	{
%>
	<tr>
		<td class=rptLabel>SubDivision&nbsp;&nbsp;</td>
		<td class=btext>
			<select name="subdivision" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="">SELECT...</option>
<%
				request.setAttribute("subdivCode", null);
				session.setAttribute("subdivName", null);
	}		
	else if(!rDist.equals(""))  
	{
%>
		<td class=rptLabel>SubDivision&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="subdivision"  class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("subdivCode", rSubDiv);
	try
	{
		stmt = conn.createStatement();
		/*query = "SELECT distinct d.circle_office_code,d.circle_office_name  from rws_circle_office_tbl d,rws_work_admn_tbl w where d.circle_office_code=substr(w.office_code,2,2) order by  d.circle_office_code";*/
		query = "select distinct sd.subdivision_office_code,sd.subdivision_office_name from rws_subdivision_office_tbl sd,rws_work_admn_tbl w,rws_work_expenditure_tbl work where w.work_id=work.work_id and sd.circle_office_code=substr(w.office_code,2,2) and sd.division_office_code=substr(w.office_code,4,1) and sd.subdivision_office_code=substr(w.office_code,5,2) and substr(w.office_code,2,2)='"+rDist+"' and substr(w.office_code,4,1)='"+rDiv+"'";
		if(rDist!=null && !rDist.equals(""))
		{
		rs = stmt.executeQuery(query);
		while(rs.next())
		{
			if(rSubDiv != null && rSubDiv.equals(rs.getString(1)))
			{					
%>
		<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
				request.setAttribute("subdivCode", rSubDiv);
				session.setAttribute("subdivName", rs.getString(2));
			}
			else
				{					
%>
		<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
				request.setAttribute("subdivCode", rSubDiv);
				}
		}	
		}
		}catch(Exception e)
		{	
		}
		finally
		{
			rs.close();			
			stmt.close();
		}		
	}
%>
			</select>
		</td>
	</tr>
	
<% try
{	
if(rDist == null || rDist.equals(""))
{
%>
	<tr>
		<td class=rptLabel nowrap>Plan/Non Plan&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="plan" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("PlanCode", null);
			session.setAttribute("PlanName", null);
}
	String queryplan ="";
	
	stmt = conn.createStatement();
	queryplan = "select distinct w.PLAN_CODE,decode(w.PLAN_CODE,'1','Plan',2,'Non Plan','-') as planName from RWS_WORK_ADMN_TBL w,rws_work_expenditure_tbl work where work.work_id=w.work_id "; 
	if(rDist!=null && !rDist.equals(""))
	{	 
	 queryplan+=" and substr(w.office_code,2,2)='"+rDist+"' ";
%>
		<td class=rptLabel nowrap>Plan/Non Plan&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="plan" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("PlanCode", rPlan);
	}
	if(rDiv!=null && !rDiv.equals(""))
	{
		queryplan+=" and substr(w.office_code,4,1)='"+rDiv+"' ";
	}
	if(rSubDiv!=null && !rSubDiv.equals(""))
	{
		queryplan+=" and substr(w.office_code,5,2)='"+rSubDiv+"' ";	
	}
	////////System.out.println("query plan "+queryplan);
	
	if(rDist!=null && !rDist.equals(""))
	{
	rs = stmt.executeQuery(queryplan);	
	while(rs.next())
	{
		if(rPlan!= null && rPlan.equals(rs.getString(1)))
		{		
		plansel="yes";			
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			request.setAttribute("PlanCode", rPlan);
			session.setAttribute("PlanName", rs.getString(2));
		}
		else
		{					
%>
			<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
				request.setAttribute("PlanCode", rPlan);
		}
	  }//end of while	
	 }//end of if		
	}catch(Exception e)
	{
		//////System.out.println("Exception in Plan"+e.getMessage());
	}
	finally
	{
		rs.close();			
		stmt.close();
	}
%>
			</select>
		</td>
	</tr>
					
<% 
try
{	
stmt = conn.createStatement();
String querywork = "select distinct w.CATEGORY_CODE,c.CATEGORY_NAME from RWS_WORK_ADMN_TBL w,rws_work_category_tbl c,rws_work_expenditure_tbl work where work.work_id=w.work_id and c.CATEGORY_CODE=w.CATEGORY_CODE "; 
if(rDist == null || rDist.equals(""))
{
%>
	<tr>
		<td class=rptLabel nowrap>Work Category&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="work" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("workcCode", null);
			session.setAttribute("workcName", null);
}
	if(rDist!=null && !rDist.equals(""))
	{
		querywork+=" and substr(w.office_code,2,2)='"+rDist+"' ";
%>
		<td class=rptLabel>Work Category</td>
		<td class=btext>
		<SELECT name="work" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("workcCode", rWork);
	}
	if(rDiv!=null && !rDiv.equals(""))
	{
	querywork+=" and substr(w.office_code,4,1)='"+rDiv+"' ";
	}
	if(rSubDiv!=null && !rSubDiv.equals(""))
	{
	querywork+=" and substr(w.office_code,5,2)='"+rSubDiv+"' ";	
	}
	if(rPlan!=null && !rPlan.equals(""))
	{
	querywork+=" and w.PLAN_CODE='"+rPlan+"' ";	
	}
	//querywork+=" group by w.WORK_CATEGORY,c.CATEGORY_NAME";
	//////System.out.println("query work "+querywork);
	if(rDist!=null && !rDist.equals(""))
	{
	rs = stmt.executeQuery(querywork);	
	while(rs.next())
	{
		if(rWork!= null && rWork.equals(rs.getString(1)))
		{	
		wcatsel="yes";				
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			request.setAttribute("workcCode", rWork);
			session.setAttribute("workcName", rs.getString(2));
			}
			else
			{					
%>
				<option value=<%=rs.getString(1)%>><%=rs.getString(2)%></option>
<%
				request.setAttribute("workcCode", rWork);
			}
		}	
		}		
			
		}catch(Exception e)
		{
			//////System.out.println("Exception in work"+e.getMessage());
		}
		finally
		{
			rs.close();			
			stmt.close();
		}
%>
			</select>
		</td>
	</tr>
	
				
<%
try
{	
stmt = conn.createStatement();
String queryscheme = "select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a,rws_work_expenditure_tbl work where work.work_id=w.work_id and substr(w.work_id,7,2)=a.type_of_asset_code"; 

if(rDist == null || rDist.equals(""))
{
%>
	<tr>
		<td class=rptLabel>Scheme&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="scheme" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("schCode", null);
			session.setAttribute("schName", null);
}
	if(rDist!=null )//&& !rDist.equals("")
	{
	queryscheme+=" and substr(w.office_code,2,2)='"+rDist+"' ";
%>
		<td class=rptLabel>Scheme&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="scheme" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("workCode", rWork);
	}
	if(rDiv!=null && !rDiv.equals(""))
	{
	queryscheme+=" and substr(w.office_code,4,1)='"+rDiv+"' ";
	}
	if(rSubDiv!=null && !rSubDiv.equals(""))
	{
	queryscheme+=" and substr(w.office_code,5,2)='"+rSubDiv+"' ";	
	}
	if(rPlan!=null && !rPlan.equals(""))
	{
	queryscheme+=" and w.PLAN_CODE='"+rPlan+"' ";	
	}
	if(rWork!=null && !rWork.equals(""))
	{
	queryscheme+=" and w.category_code='"+rWork+"' ";	
	}
	//querywork+=" group by w.WORK_CATEGORY,c.CATEGORY_NAME";
	//////System.out.println("queryscheme "+queryscheme);
	rs = stmt.executeQuery(queryscheme);	
	if(rWork!=null && !wcatsel.equals(""))
	{	
	while(rs.next())
	{
		if(rScheme!= null && rScheme.equals(rs.getString(1)))
		{					
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			request.setAttribute("schCode", rScheme);
			session.setAttribute("schName", rs.getString(2));
			}
			else
			{					
%>
				<option value=<%=rs.getString(1)%>><%=rs.getString(2)%></option>
<%
				request.setAttribute("schCode", rScheme);
			}
		}
		}			
			
		}catch(Exception e)
		{
			//////System.out.println("Exception in work"+e.getMessage());
		}
		finally
		{
			rs.close();			
			stmt.close();
		}
%>
			</select>
		</td>
	</tr>
	
					
<% 
try
{	
if(rDist == null || rDist.equals(""))
{
%>
	<tr>
		<td class=rptLabel>Augmentation&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="augmentation" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("augCode", null);
			session.setAttribute("augName", null);
}
String queryaug="";
stmt = conn.createStatement();
	if(rDist!=null && !rDist.equals(""))
	{

 queryaug = "select distinct w.AUG_NEW_CODE,decode(w.AUG_NEW_CODE,'1','MainScheme','2','Augmentation','3','Maintenance','-') as Aug  from RWS_WORK_ADMN_TBL w,rws_work_expenditure_tbl work where work.work_id=w.work_id  "; 
//select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where  substr(w.office_code,2,2)='"+rDist+"' and substr(w.office_code,4,1)='"+rDiv+"' and substr(w.office_code,5,2)='"+rSubDiv+"' and substr(w.work_id,7,2)=a.type_of_asset_code"; 
	
	queryaug +=" and substr(w.office_code,2,2)='"+rDist+"' ";
%>
		<td class=rptLabel>Augmentation&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="augmentation" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("augCode", rAug);
	}
	if(rDiv!=null && !rDiv.equals(""))
	{
	queryaug +=" and substr(w.office_code,4,1)='"+rDiv+"' ";
	}
	if(rSubDiv!=null && !rSubDiv.equals(""))
	{
	queryaug +=" and substr(w.office_code,5,2)='"+rSubDiv+"' ";	
	}
	if(rPlan!=null && !rPlan.equals(""))
	{
	queryaug +=" and w.PLAN_CODE='"+rPlan+"' ";	
	}
	if(rWork!=null && !rWork.equals(""))
	{
	queryaug +=" and w.category_code='"+rWork+"' ";	
	}
	if(rScheme!=null && !rScheme.equals(""))
	{
	queryaug +=" and substr(w.work_id,7,2)='"+rScheme+"' ";	
	}
	//querywork+=" group by w.WORK_CATEGORY,c.CATEGORY_NAME";
	//////System.out.println("queryAug "+queryaug);
	if(rDist!=null && !rDist.equals(""))
	{
	rs = stmt.executeQuery(queryaug);		
	while(rs.next())
	{
		if(rAug!= null && rAug.equals(rs.getString(1)))
		{					
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			request.setAttribute("augCode", rAug);
			session.setAttribute("augName", rs.getString(2));
			}
			else
			{					
%>
				<option value=<%=rs.getString(1)%>><%=rs.getString(2)%></option>
<%
				request.setAttribute("augCode", rAug);
			}
		}		
		}	
			
		}catch(Exception e)
		{
			//////System.out.println("Exception in Aug"+e.getMessage());
		}
		finally
		{
			rs.close();			
			stmt.close();
		}
%>
			</select>
		</td>
	</tr>
	
		
					
<%
try
{	
stmt = conn.createStatement();
String queryprog = "select distinct p.PROGRAMME_CODE ,p.PROGRAMME_NAME from RWS_WORK_ADMN_TBL w,rws_programme_tbl p,rws_work_expenditure_tbl work where work.work_id=w.work_id and substr(w.work_id,1,2)=p.PROGRAMME_CODE  "; 
//select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where  substr(w.office_code,2,2)='"+rDist+"' and substr(w.office_code,4,1)='"+rDiv+"' and substr(w.office_code,5,2)='"+rSubDiv+"' and substr(w.work_id,7,2)=a.type_of_asset_code"; 
if(rDist == null || rDist.equals(""))
{
%>
	<tr>
		<td class=rptLabel>Programme&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="programme" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("progCode", null);
			session.setAttribute("progName", null);
}
	if(rDist!=null && !rDist.equals(""))
	{
	queryprog +=" and substr(w.office_code,2,2)='"+rDist+"' ";
%>
		<td class=rptLabel>Programme&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="programme" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("progCode", rProg);
	}
	if(rDiv!=null && !rDiv.equals(""))
	{
	queryprog +=" and substr(w.office_code,4,1)='"+rDiv+"' ";
	}
	if(rSubDiv!=null && !rSubDiv.equals(""))
	{
	queryprog +=" and substr(w.office_code,5,2)='"+rSubDiv+"' ";	
	}
	if(rPlan!=null && !rPlan.equals(""))
	{
	queryprog +=" and w.PLAN_CODE='"+rPlan+"' ";	
	}
	if(rWork!=null && !rWork.equals(""))
	{
	queryprog +=" and w.category_code='"+rWork+"' ";	
	}
	if(rScheme!=null && !rScheme.equals(""))
	{
	queryprog +=" and substr(w.work_id,7,2)='"+rScheme+"' ";	
	}
	if(rAug!=null && !rAug.equals(""))
	{
	queryprog +=" and w.AUG_NEW_CODE ='"+rAug+"' ";	
	}
	
	//querywork+=" group by w.WORK_CATEGORY,c.CATEGORY_NAME";
	//////System.out.println("queryprog "+queryprog);
	if(rDist!=null && !rDist.equals(""))
	{
	rs = stmt.executeQuery(queryprog);	
	while(rs.next())
	{
		if(rProg!= null && rProg.equals(rs.getString(1)))
		{
		progsel="yes";					
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			request.setAttribute("progCode", rProg);
			session.setAttribute("progName", rs.getString(2));
			}
			else
			{					
%>
				<option value=<%=rs.getString(1)%>><%=rs.getString(2)%></option>
<%
				request.setAttribute("progCode", rProg);
			}
		}	
		}		
			
		}catch(Exception e)
		{
			//////System.out.println("Exception in Aug"+e.getMessage());
		}
		finally
		{
			rs.close();			
			stmt.close();
		}
%>
			</select>
		</td>
	</tr>
					
<% 
try
{	
stmt = conn.createStatement();
String querysprog = "select distinct sp.SUBPROGRAMME_CODE as subcode,sp.SUBPROGRAMME_NAME from RWS_WORK_ADMN_TBL w,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_work_expenditure_tbl work where work.work_id=w.work_id and substr(w.work_id,1,2)=p.PROGRAMME_CODE and substr(w.work_id,3,2)=sp.subPROGRAMME_CODE and p.PROGRAMME_CODE=sp.PROGRAMME_CODE  "; 
//select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where  substr(w.office_code,2,2)='"+rDist+"' and substr(w.office_code,4,1)='"+rDiv+"' and substr(w.office_code,5,2)='"+rSubDiv+"' and substr(w.work_id,7,2)=a.type_of_asset_code"; 
if(rDist == null || rDist.equals(""))
{
%>
	<tr>
		<td class=rptLabel nowrap>Sub Programme&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="subprogramme" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("sprogCode", null);
			session.setAttribute("sprogName", null);
}
	if(rDist!=null && !rDist.equals(""))
	{
	querysprog +=" and substr(w.office_code,2,2)='"+rDist+"' ";
%>
		<td class=rptLabel nowrap>Sub Programme&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="subprogramme" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("sprogCode", rsProg);
	}
	if(rDiv!=null && !rDiv.equals(""))
	{
	querysprog +=" and substr(w.office_code,4,1)='"+rDiv+"' ";
	}
	if(rSubDiv!=null && !rSubDiv.equals(""))
	{
	querysprog +=" and substr(w.office_code,5,2)='"+rSubDiv+"' ";	
	}
	if(rPlan!=null && !rPlan.equals(""))
	{
	querysprog +=" and w.PLAN_CODE='"+rPlan+"' ";	
	}
	if(rWork!=null && !rWork.equals(""))
	{
	querysprog +=" and w.category_code='"+rWork+"' ";	
	}
	if(rScheme!=null && !rScheme.equals(""))
	{
	querysprog +=" and substr(w.work_id,7,2)='"+rScheme+"' ";	
	}
	if(rAug!=null && !rAug.equals(""))
	{
	querysprog +=" and w.AUG_NEW_CODE ='"+rAug+"' ";	
	}
	if(rProg!=null && !rProg.equals(""))
	{
	querysprog +=" and substr(w.work_id,1,2) ='"+rProg+"' ";	
	}
	
	//querywork+=" group by w.WORK_CATEGORY,c.CATEGORY_NAME";
	////System.out.println("querysuprog "+querysprog);
	if(rDist!=null && !rDist.equals("") && !progsel.equals(""))
	{
	rs = stmt.executeQuery(querysprog);
	while(rs.next())
	{
		if(rsProg!= null && rsProg.equals(rs.getString(1)))
		{					
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			request.setAttribute("sprogCode", rsProg);
			session.setAttribute("sprogName", rs.getString(2));
			}
			else
			{					
%>
				<option value=<%=rs.getString(1)%>><%=rs.getString(2)%></option>
<%
				request.setAttribute("sprogCode", rsProg);
			}
		}
		}			
			
		}catch(Exception e)
		{
			//////System.out.println("Exception in Aug"+e.getMessage());
		}
		finally
		{
			rs.close();			
			stmt.close();
		}
%>
			</select>
		</td>
	</tr>
	
						
<% 
try
{	
stmt = conn.createStatement();
//String querysprog = "select distinct sp.SUBPROGRAMME_CODE as subcode,sp.SUBPROGRAMME_NAME from RWS_WORK_ADMN_TBL w,rws_programme_tbl p,rws_subprogramme_tbl sp where substr(w.work_id,1,2)=p.PROGRAMME_CODE and substr(w.work_id,3,2)=sp.subPROGRAMME_CODE and p.PROGRAMME_CODE=sp.PROGRAMME_CODE  "; 
String queryyear=" select distinct to_char(admin_date,'yyyy') from RWS_WORK_ADMN_TBL w,rws_work_expenditure_tbl work where work.work_id=w.work_id and to_char(admin_date,'yyyy') is not null ";
//select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where  substr(w.office_code,2,2)='"+rDist+"' and substr(w.office_code,4,1)='"+rDiv+"' and substr(w.office_code,5,2)='"+rSubDiv+"' and substr(w.work_id,7,2)=a.type_of_asset_code"; 
if(rDist == null || rDist.equals(""))
{
%>
	<tr>
		<td class=rptLabel nowrap>year(Admin_Sanc_Year)<font color="red">*</font></td>
		<td class=btext>
		<select name="year" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
			request.setAttribute("yearCode", null);
			session.setAttribute("yrName", null);
	}
	if(rDist!=null && !rDist.equals(""))
	{
	queryyear +=" and substr(w.office_code,2,2)='"+rDist+"' ";
%>
		<td class=rptLabel nowrap>year(Admin_Sanc_Year)<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="year" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="">SELECT...</option>
<%
		request.setAttribute("yearCode", rYear);
	}
	if(rDiv!=null && !rDiv.equals(""))
	{
	queryyear +=" and substr(w.office_code,4,1)='"+rDiv+"' ";
	}
	if(rSubDiv!=null && !rSubDiv.equals(""))
	{
	queryyear +=" and substr(w.office_code,5,2)='"+rSubDiv+"' ";	
	}
	if(rPlan!=null && !rPlan.equals(""))
	{
	queryyear +=" and w.PLAN_CODE='"+rPlan+"' ";	
	}
	if(rWork!=null && !rWork.equals(""))
	{
	queryyear +=" and w.category_code='"+rWork+"' ";	
	}
	if(rScheme!=null && !rScheme.equals(""))
	{
	queryyear +=" and substr(w.work_id,7,2)='"+rScheme+"' ";	
	}
	if(rAug!=null && !rAug.equals(""))
	{
	queryyear +=" and w.AUG_NEW_CODE ='"+rAug+"' ";	
	}
	if(rProg!=null && !rProg.equals(""))
	{
	queryyear +=" and substr(w.work_id,1,2) ='"+rProg+"' ";	
	}
	if(rsProg!=null && !rsProg.equals(""))
	{
	queryyear +=" and substr(w.work_id,3,2) ='"+rsProg+"' ";	
	}
		queryyear +="  order by 1 desc ";
	//querywork+=" group by w.WORK_CATEGORY,c.CATEGORY_NAME";
	////System.out.println("queryyear "+queryyear);
	if(rDist!=null && !rDist.equals(""))
	{
	rs = stmt.executeQuery(queryyear);
	while(rs.next())
	{
		if(rYear!= null && rYear.equals(rs.getString(1)))
		{					
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(1)%></option>
<%
			request.setAttribute("yearCode", rYear);
			session.setAttribute("yrName", rs.getString(1));
			}
			else
			{					
%>
				<option value=<%=rs.getString(1)%>><%=rs.getString(1)%></option>
<%
				request.setAttribute("yearCode", rYear);
			}
		}		
		}	
		}catch(Exception e)
		{
			//////System.out.println("Exception in Aug"+e.getMessage());
		}
		finally
		{
			rs.close();			
			stmt.close();
		}
%>
			</select>
		</td>
	</tr>
			
					
<%
	if(rDist != null)
	{		
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}

%>
</table>

</form>
</body>
</html>
<%@ include file = "footer.jsp" %>