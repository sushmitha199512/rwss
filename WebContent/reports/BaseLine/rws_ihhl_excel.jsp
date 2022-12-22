<%@ include file="/reports/conn.jsp" %>


<form>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rwsihhldetails.xls");
String dcode=(String)session.getAttribute("dcode");
String mcode=(String)session.getAttribute("mcode");
String pcode=(String)session.getAttribute("pcode");
String vcode=(String)session.getAttribute("vcode");
String hab=(String)session.getAttribute("hab");

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
    String qry="";
    int styleCount=0;
    String style="";
   
   	%>
	
   
   <table width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>Habitation Details</td>
    <td class=gridhdbg rowspan=2>Beneficiary Details</td>
    <td class=gridhdbg rowspan=2>Construction Details</td> 
	<td class=gridhdbg rowspan=2>Entry Details</td>
	<td class=gridhdbg rowspan=2>Update Details</td>
    <td class=gridhdbg rowspan=2>TCS Habitation Code</td>
    
	</tr>
	<tr>
       </tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   
qry="select dname,mname,pname,vname,panch_name,panch_code,nvl(BENIF_ID,0),nvl(CONSTRUCTED_YEAR,'-'),nvl(CONSTRUCTED_MONTH,'-'),nvl(FIN_YEAR,'-'),nvl(RATION_CARDNO,'-'),nvl(BENEFICIARYNAME,'-'),nvl(CATEGORYCODE,'-'),nvl(ADHARCARDNUMBER,'-'),nvl(ISMGNREGA,'-'),nvl(MGNREGAJOBCARDNUMBER,'-'),nvl(TOTALTOILETCOST,0),nvl(ENTRYDATE,'-'),nvl(ENTRYUSER,'-'),nvl(UPDATEDATE,'-'),nvl(UPDATEUSER,'-'),nvl(CASTE,'-'),nvl(GENDER,'-'),nvl(IS_DISABLED,'-'),nvl(WOMAN_HEADED,'-'),nvl(AP_HAB_CODE,'-'),nvl(TCS_HAB_CODE,'-') from rws_complete_hab_view a,rws_ihhl_tbl  b where a.panch_code=b.AP_HAB_CODE ";

if(dcode !=null && !dcode.equals(""))
{
	qry+="and substr(a.panch_code,1,2)='"+dcode+"'";
}
if(mcode !=null && !mcode.equals(""))
{
	qry+="and substr(a.panch_code,6,2)='"+mcode+"'";
}
if(pcode !=null && !pcode.equals(""))
{
	qry+="and substr(a.panch_code,13,2)='"+pcode+"'";
}
if(vcode !=null && !vcode.equals(""))
{
	qry+="and substr(a.panch_code,8,3)='"+vcode+"'";
}
if(hab !=null && !hab.equals(""))
{
	qry+="and a.panch_code='"+hab+"'";
}
qry+="order by dcode,mcode,pcode,vcode,panch_code";
   
  // System.out.println("qry is="+qry);
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
   	
		
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: left;">District:<%=rs8.getString(1)%><br>
   Mandal:<%=rs8.getString(2)%><br>Panchayath:<%=rs8.getString(3)%><br>village:<%=rs8.getString(4)%><br>Hab Code:<%=rs8.getString(6)%><br>Hab Name:<%=rs8.getString(5)%></td>
<td  class="<%=style%> "style="text-align: left;">Name:<%=rs8.getString(12)%><br>Id:<%=rs8.getString(7)%><br>Caste:<%=rs8.getString(22)%><br>Gender:<%=rs8.getString(23)%><br>Ration Card No:<%=rs8.getString(11)%><br>Category Code:<%=rs8.getString(13)%><br>Adhar No:<%=rs8.getString(14)%>
<br>ISMGNREGA?<%=rs8.getString(15)%><br>MGNREGA No:<%=rs8.getString(16)%><br>Is Disabled?<%=rs8.getString(24)%><br>Women Headed?<%=rs8.getString(25)%></td>
<td  class="<%=style%> "style="text-align: left;">Cost:<%=rs8.getString(17)%><br>Year:<%=rs8.getString(8)%><br>Month:<%=rs8.getString(9)%><br>Fin. Year:<%=rs8.getString(10)%></td>
<td  class="<%=style%> "style="text-align: left;">Date: <%=rs8.getString(18)%><br>user:<%=rs8.getString(19)%></td>
<td  class="<%=style%> "style="text-align: left;">Date: <%=rs8.getString(20)%><br>user:<%=rs8.getString(21)%></td>

<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(27)%></td>

   
   
        
 
   	</tr>
   	
   	
<%
}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>
