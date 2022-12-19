<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("##.##");



	%>

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=11>Coverage of Schools with Drinking Water Facilities</td>	
	</tr>
		<tr >
		<td class=btext rowspan=2 align=center>Sl.No</td>
		<td class=btext rowspan=2 align=center>District</td>
<td class=btext rowspan=2 align=center>Division</td>
<td class=btext  align=center colspan=3 nowrap >Coverage of Schools with Drinking Water Facilities.</td>
<td class=btext colspan=3 align=center >Coverage of Anganwadis with Drinking Water Facilities.</td>
</tr>
<tr>
<td class=btext align="center"  >Total No. of Schools sanctioned</td>
 <td  class=btext align="center"  >No. of schools provided with Drinking Water</td>	
		<td  class=btext align="center"  >%</td>	
		<td  class=btext align="center"  >Total No. of Anganwadies</td>
		<td  class=btext align="center"  >No. of Anganwadies provided with Drinking Water</td>	
<td  class=btext align="center"  >%</td>	



</tr>


<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td>
</tr>


<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
  try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();

//Financial Queries

String schoolsQuery="select b.circle_office_code,b.division_office_code,COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE <>'01' and c.school_code=d.school_code  group by b.circle_office_code,b.division_office_code order by 1";

		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(schoolsQuery);
	Hashtable schoolsHash=new Hashtable();
	while(rs2.next())
	{
		schoolsHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String anganiVadiQuery="select b.circle_office_code,b.division_office_code,COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE ='01' and c.school_code=d.school_code group by b.circle_office_code,b.division_office_code order by 1";

		stmt3=conn.createStatement();
//System.out.println("ExpQuery"+expQuery);
	 rs2=stmt3.executeQuery(anganiVadiQuery);
	Hashtable anganHash=new Hashtable();
	while(rs2.next())
	{
		anganHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String schoolsCompQuery="select b.circle_office_code,b.division_office_code,COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and W.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null) and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE <>'01' and c.school_code=d.school_code  group by b.circle_office_code,b.division_office_code order by 1";

		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(schoolsCompQuery);
	Hashtable schoolsCompHash=new Hashtable();
	while(rs2.next())
	{
		schoolsCompHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String anganiVadiCompQuery="select b.circle_office_code,b.division_office_code,COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and w.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null) and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE ='01' and c.school_code=d.school_code group by b.circle_office_code,b.division_office_code order by 1";

		stmt3=conn.createStatement();
//System.out.println("ExpQuery"+expQuery);
	 rs2=stmt3.executeQuery(anganiVadiCompQuery);
	Hashtable anganCompHash=new Hashtable();
	while(rs2.next())
	{
		anganCompHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




stmt3=conn.createStatement();



String query="";



if(loggedUser!=null && loggedUser.equals(nic.watersoft.commons.Constants.ADMIN) || loggedUser.equals(nic.watersoft.commons.Constants.LAKH_USER)){

 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}else if(!loggedUser.substring(3,4).equals("0")){
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+loggedUser.substring(1,3)+"' and a.division_office_code='"+loggedUser.substring(3,4)+"' order by circle_office_code ";
}else{
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+loggedUser.substring(1,3)+"'  order by circle_office_code ";
} 


//System.out.println("Main Query"+query);
rs1=stmt2.executeQuery(query);
String dname="";
long gschoolCount=0,ganganiCount=0;long sCount=0,aCount=0,gschoolCount1=0,ganganiCount1=0;long sCount1=0,aCount1=0;
double per1=0,per2=0;
while(rs1.next()){



%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
<td  class=rptLabel><%=rs1.getString(2) %></td>
 


<% 
  String sch=(String)schoolsHash.get(rs1.getString(3)+rs1.getString(4));
  String ang=(String)anganHash.get(rs1.getString(3)+rs1.getString(4));
  String sch1=(String)schoolsCompHash.get(rs1.getString(3)+rs1.getString(4));
  String ang1=(String)anganCompHash.get(rs1.getString(3)+rs1.getString(4));
  

   if(sch!=null && !sch.equals("null")){
    sCount=Integer.parseInt(sch);

    gschoolCount+=sCount;
}
 if(ang!=null && !ang.equals("null")){
    aCount=Integer.parseInt(ang);
    ganganiCount+=aCount;
}
   if(sch1!=null && !sch1.equals("null")){
    sCount1=Integer.parseInt(sch1);
    gschoolCount1+=sCount1;
}
 if(ang1!=null && !ang1.equals("null")){
    aCount1=Integer.parseInt(ang1);
    ganganiCount1+=aCount1;
}

if(sCount!=0 && sCount1!=0 && sCount>=sCount1){
//float percent = (100 * downloaded) / total;
per1=(100*sCount1)/sCount;
}else{
per1=0;
}
if(aCount!=0 && aCount1!=0 && aCount>=aCount1 ){
per2=(100*aCount1)/aCount;
}else{
per2=0;
}



%>
<td class=rptValue align=center><%=sCount %></td><td class=rptValue align=center><%=sCount1 %></td><td class=rptValue><%=per1 %></td><td class=rptValue align=center><%=aCount %></td><td class=rptValue align=center><%=aCount1 %></td><td class=rptValue><%=per2 %></td></tr>


<% 
sCount=0;aCount=0;
sCount1=0;aCount1=0;
//per1=0;per2=0;
}



%>
<tr><td class=rptlabel colspan=3>Total:</td><td class=rptlabel align=center><%=gschoolCount %></td><td class=rptLabel align=center><%=gschoolCount1 %></td><td class=rptlabel align=center><%=(gschoolCount1*100)/gschoolCount %></td><td class=rptLabel align=center><%=ganganiCount %></td><td class=rptLabel align=center><%=ganganiCount1 %></td><td class=rptLabel align=center><%=(ganganiCount1*100)/ganganiCount %></td></tr>
<% 

}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>