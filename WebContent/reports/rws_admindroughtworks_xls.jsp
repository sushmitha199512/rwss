<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>

<%@ include file="conn.jsp" %>
<form>
<%
int sno=1;
	  Statement st1=null,st2=null;
	  ResultSet rs1=null,rs2=null;
	  String qry="";
	  //Connection conn=null;
      String district=(String)session.getAttribute("district");
      
      //System.out.println("district***********"+district);
      String dname=(String)session.getAttribute("dname");
      
     //  System.out.println("district***********"+dname);
     
     int counter=0;
     String asset="";
     String shp="";
     String openwell="";
     String source="";
     String pond=""; 
ResultSet rs3=null,rs4=null,rs5=null;
Statement stmt1=null, stmt2=null,stmt3=null,stmt4=null,stmt5=null;
int total=0,gtotal=0,ftotal=0,f1=0,fc=0;
String categorycode="";
String year=(String)session.getAttribute("year");



String fromdate=request.getParameter("x");
String todate=request.getParameter("y");
session.setAttribute("fromdate",fromdate);
session.setAttribute("todate",todate);
String adminyear=(String)session.getAttribute("adminyear");

//System.out.println("year************"+adminyear);


String gtxidValueOld = "",gtxidValue="";%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=26 > Drought Works Report ( Detailed )</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
	<td class=btext colspan=26>District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;Year:<font color=red><%=adminyear%> </font></td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class="btext" nowrap>Sl No</td> 
	 <td class="btext" nowrap>Circle/<br>Division/<br>SubDivision </td> 
<td class="btext" nowrap>Programme/<br>SubProgramme </td>

<td class="btext" nowrap>Prepared By/<br>Prepared On  </td>

<td class="btext" nowrap>Updare Date   </td>
<td class="btext" nowrap>Habitation </td>
<td class="btext" nowrap>Work Id /<Br>Work Name  </td>

<td class="btext" nowrap>Work Type </td>
<td class="btext" nowrap>Aug WorkId </td>
<td class="btext" nowrap>Type Of Asset </td>
<td class="btext" nowrap>Work Category </td>
<td class="btext" nowrap>NonPlan  </td>
<td class="btext" nowrap>Aug New Code </td>
<td class="btext" nowrap>Category Code </td>
<td class="btext" nowrap>Admin No/<Br>Admin Date/<br>Admin Amount  </td>


<td class="btext" nowrap>Technical No/<br>Technical Date/<br>Technical Amount/<br>SSR Year</td>
<td class="btext" nowrap>Source Habitation/<br>Source Type Code/<br>SubSource Type Code/<br>Source Code/<br>Source Name/<br>Source Location/<br> </td>
<td class="btext" nowrap>Asset Code     </td>
<td class="btext" nowrap>New Existing </td>
<td class="btext" nowrap>Site Hand Over Date</td>  
<td class="btext" nowrap>Grounding Date     </td>
<td class="btext" nowrap>Expenditure Upto   </td>
<td class="btext" nowrap>Expenditure Upto Date  </td>
<td class="btext" nowrap>Value of Work Done but not paid  </td>
<td class="btext" nowrap>Date of Completion     </td>
<td class="btext" nowrap>Date of Financial Completion     </td>
<td class="btext" nowrap>Date of Commencement       </td>
<td class="btext" nowrap>Approved Under  </td>
<td class="btext" nowrap>Remarks     </td>
</tr>


 

 
  
 
 
  
  
 


<%
try
{
	//
	String panch="select circle_office_code,circle_office_name from rws_circle_office_tbl";
	Statement stmt99=conn.createStatement();

	ResultSet rs99=stmt99.executeQuery(panch);
	Hashtable panchh=new Hashtable();
		while(rs99.next())
	{
		panchh.put(rs99.getString(1),rs99.getString(2));
	}

	//
	String household="select division_office_code,division_office_name,b.circle_office_code from rws_division_office_tbl a,rws_circle_office_tbl b where a.circle_office_code=b.circle_office_code ";
	Statement	stmt88=conn.createStatement();
	//System.out.println("household:"+household);
	ResultSet rs88=stmt88.executeQuery(household);
	Hashtable householdh=new Hashtable();
		while(rs88.next())
	{
		householdh.put(rs88.getString(3)+rs88.getString(1),rs88.getString(2));
	}
	//
	String household1="select subdivision_office_code,subdivision_office_name,a.circle_office_code,b.division_office_code from rws_subdivision_office_tbl a,rws_division_office_tbl b where a.division_office_code=b.division_office_code";
	Statement	stmt888=conn.createStatement();
	//System.out.println("household:"+household);
	ResultSet rs888=stmt888.executeQuery(household1);
	Hashtable householdhh=new Hashtable();
		while(rs888.next())
	{
		householdhh.put(rs888.getString(3)+rs888.getString(4)+rs888.getString(1),rs888.getString(2));
	}
	//
	String pp="select  programme_code,programme_name from rws_programme_tbl";
	
	Statement	stsh=conn.createStatement();
	
	ResultSet rssh=stsh.executeQuery(pp);
	Hashtable shh=new Hashtable();
	while(rssh.next())
	{
	   shh.put(rssh.getString(1),rssh.getString(2));
     }
	 
	String pp1="select subprogramme_code,subprogramme_name from rws_subprogramme_tbl";
	Statement	stsh1=conn.createStatement();
	
	ResultSet rssh1=stsh1.executeQuery(pp1);
	Hashtable shhh=new Hashtable();
	while(rssh1.next())
	{
	   shhh.put(rssh1.getString(1),rssh1.getString(2));
     }
	 String pp11="select panch_code,panch_name from rws_complete_hab_view";
	 Statement	stsh11=conn.createStatement();
	
	ResultSet rssh11=stsh11.executeQuery(pp11);
	Hashtable shhhh=new Hashtable();
	while(rssh11.next())
	{
	   shhhh.put(rssh11.getString(1),rssh11.getString(2));
     }
	 //
	 String hh="select type_of_asset_code,type_of_asset_name from rws_asset_type_tbl"; 
	Statement	p1=conn.createStatement();
	//System.out.println("hh:"+hh);
	ResultSet p2=p1.executeQuery(hh);
	Hashtable hp5=new Hashtable();
	while(p2.next())
	{
	hp5.put(p2.getString(1),p2.getString(2));
	}
	String hh1="select category_code,category_name from rws_work_category_tbl"; 
	Statement	p11=conn.createStatement();
	//System.out.println("hh:"+hh);
	ResultSet p22=p11.executeQuery(hh1);
	Hashtable hp55=new Hashtable();
	while(p22.next())
	{
	hp55.put(p22.getString(1),p22.getString(2));
	}
	
	 //
	 String hh11="select panch_code,panch_name from rws_complete_hab_view"; 
	Statement	p111=conn.createStatement();
	//System.out.println("hh:"+hh);
	ResultSet p222=p111.executeQuery(hh11);
	Hashtable hp555=new Hashtable();
	while(p222.next())
	{
	hp555.put(p222.getString(1),p222.getString(2));
	}
	
	 //
	
	String planname="";

    if(district.equals("ALL"))
    {
    qry="select OFFICE_CODE,PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY  ,to_char(PREPARED_ON,'dd/mm/yyyy')  ,to_char(UPDATE_DATE,'dd/mm/yyyy')    ,HABITATION_CODE ,WORK_NAME  ,WORK_ID  ,WORK_TYPE ,nvl(AUG_WORKID,'_') ,TYPE_OF_ASSET ,WORK_CATEGORY ,PLAN_CODE  ,nvl(AUG_NEW_CODE,'_') ,CATEGORY_CODE ,ADMIN_NO  ,nvl(to_char(ADMIN_DATE,'dd/mm/yyyy'),'_') ,ADMIN_AMOUNT ,nvl(TS_NO,'_')     ,nvl(to_char(TS_DATE,'dd/mm/yyyy'),'_')  ,nvl(TS_AMOUNT,0) ,SSR_YEAR     ,nvl(SOURCE_HAB_CODE,'-') ,nvl(SOURCE_TYPE_CODE,0) ,nvl(SUBSOURCE_TYPE_CODE,0) ,nvl(SOURCE_CODE,'_')     ,nvl(SOURCE_NAME,'_')     ,nvl(SOURCE_LOCATION,'_') ,nvl(ASSET_CODE,'_')     ,nvl(NEW_EXISTING,'_')  ,nvl(to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy'),'_')  ,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'_')     ,EXPENDITURE_UPTO   ,nvl(to_char(EXPENDITURE_UPTO_DT,'dd/mm/yyyy'),'_')   ,VALUE_OF_WORK_NOT_PAID  ,nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'_')     ,nvl(to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),'_')     ,nvl(to_char(DATE_OF_COMM,'dd/mm/yyyy'),'_')     ,APPROVED_UNDER  ,nvl(REMARKS,'-'),substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)     from rws_drought_works_tbl where to_char(admin_date,'yyyy')='"+year+"'";


 

 
  
 
 
  
  
 
	}

   else
    {
      qry="select OFFICE_CODE,PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY  ,to_char(PREPARED_ON,'dd/mm/yyyy')  ,to_char(UPDATE_DATE,'dd/mm/yyyy')    ,HABITATION_CODE ,WORK_NAME  ,WORK_ID  ,WORK_TYPE ,nvl(AUG_WORKID,'_') ,TYPE_OF_ASSET ,WORK_CATEGORY ,PLAN_CODE  ,nvl(AUG_NEW_CODE,'_') ,CATEGORY_CODE ,ADMIN_NO  ,nvl(to_char(ADMIN_DATE,'dd/mm/yyyy'),'_') ,ADMIN_AMOUNT ,nvl(TS_NO,'_')     ,nvl(to_char(TS_DATE,'dd/mm/yyyy'),'_')  ,nvl(TS_AMOUNT,0) ,SSR_YEAR     ,SOURCE_HAB_CODE ,nvl(SOURCE_TYPE_CODE,0) ,nvl(SUBSOURCE_TYPE_CODE,0) ,nvl(SOURCE_CODE,'_')     ,nvl(SOURCE_NAME,'_')     ,nvl(SOURCE_LOCATION,'_') ,nvl(ASSET_CODE,'_')     ,nvl(NEW_EXISTING,'_')  ,nvl(to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy'),'_')  ,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'_')     ,EXPENDITURE_UPTO   ,nvl(to_char(EXPENDITURE_UPTO_DT,'dd/mm/yyyy'),'_')   ,VALUE_OF_WORK_NOT_PAID  ,nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'_')     ,nvl(to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),'_')     ,nvl(to_char(DATE_OF_COMM,'dd/mm/yyyy'),'_')     ,APPROVED_UNDER  ,nvl(REMARKS,'-'),substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)     from rws_drought_works_tbl where substr(habitation_code,1,2)='"+district+"'and to_char(admin_date,'yyyy')='"+year+"'";

    }
  
	//System.out.println("qry************"+qry);
    st1=conn.createStatement();
	rs1=st1.executeQuery(qry);
	while(rs1.next())
	{
        counter=counter+1;
		String programme=(String)shh.get(rs1.getString(2));
        if(programme!=null && !programme.equals("") && !programme.equals("null"))
		{
		}
		else
		{
			programme="-";
		}
		String subprogramme=(String)shhh.get(rs1.getString(3));
		if(subprogramme!=null && !subprogramme.equals("") && !subprogramme.equals("null"))
		{
		}
		else
		{
         subprogramme="-";
		}
		String habname=(String)shhhh.get(rs1.getString("habitation_code"));
		String typeofasset=(String)hp5.get(rs1.getString("type_of_asset"));
		String workcategory=(String)hp55.get(rs1.getString("work_category"));
		
		String hname=rs1.getString(24);
		//System.out.println("hname*********"+hname);
		String habname1="";
		if(hname.equals("-"))
		{
			habname1="_";
		}
		else if(hname != null  && !hname.equals(""))
        {
			 habname1=(String)hp555.get(rs1.getString(24));
		
		
		}
		

		if(rs1.getString("plan_code").equals("2"))
		{
			planname="NON PLAN";
		}

		String circle=(String)panchh.get(rs1.getString(42));
		String division=(String)householdh.get(rs1.getString(42)+rs1.getString(43));
		String subdivision=(String)householdhh.get(rs1.getString(42)+rs1.getString(43)+rs1.getString(44));
		categorycode="Drought";

		
		

     
%>

	<tr>
    <td class="rptValue"><%=sno++%></td>
	 <td class="rptValue"><%=circle%>/<br><%=division%>/<br><%=subdivision%></td> 
<td class="rptValue"><%=programme%>/<br><%=subprogramme%> </td>

<td class="rptValue"><%=rs1.getString(4)%> /<br><%=rs1.getString(5)%> </td>

<td class="rptValue"><%=rs1.getString(6)%>   </td>
<td class="rptValue"><%=habname%> </td>
<td class="rptValue"><%=rs1.getString(9)%>/<br><%=rs1.getString(8)%>  </td>

<td class="rptValue"><%=rs1.getString(10)%> </td>
<td class="rptValue"><%=rs1.getString(11)%> </td>
<td class="rptValue"><%=typeofasset%> </td>
<td class="rptValue"><%=workcategory%> </td>
<td class="rptValue"><%=planname%> </td>
<td class="rptValue"><%=categorycode%> </td>
<td class="rptValue"><%=workcategory%> </td>
<td class="rptValue"><%=rs1.getString(17)%>/<Br><%=rs1.getString(18)%>/<br><%=rs1.getDouble(19)%>  </td>


<td class="rptValue"><%=rs1.getString(20)%>/<br><%=rs1.getString(21)%> /<br><%=rs1.getString(22)%>/<br><%=rs1.getString(23)%>       </td>

<td class="rptValue"><%=habname1%>/<br><%=rs1.getString(25)%>/<br><%=rs1.getString(26)%>/<br><%=rs1.getString(27)%>/<br><%=rs1.getString(28)%>/<br><%=rs1.getString(29)%> </td>
<td class="rptValue"><%=rs1.getString(30)%>     </td>
<td class="rptValue"><%=rs1.getString(31)%>  </td>
<td class="rptValue"><%=rs1.getString(32)%></td>  
<td class="rptValue"><%=rs1.getString(33)%>     </td>
<td class="rptValue"><%=rs1.getDouble(34)%>   </td>
<td class="rptValue"><%=rs1.getString(35)%>   </td>
<td class="rptValue"><%=rs1.getDouble(36)%>  </td>
<td class="rptValue"><%=rs1.getString(37)%>     </td>
<td class="rptValue"><%=rs1.getString(38)%>     </td>
<td class="rptValue"><%=rs1.getString(39)%>       </td>
<td class="rptValue"><%=rs1.getString(40)%> </td>
<td class="rptValue"><%=rs1.getString(41)%>     </td>
</tr>
<%
 }
if(counter==0){
%>
<tr>
    <td class="btext" align=center colspan=26>No Records</td>
    
    </tr>
<% }
    

	
	}catch(Exception e)
		{
		e.printStackTrace();
		}
finally
{
try
{
if(rs1 != null )
{
rs1.close();
}
if(st1 != null)
{
st1.close();
}
}
catch(Exception p)
{
p.printStackTrace();
}
}

%>
     

</table>

  
