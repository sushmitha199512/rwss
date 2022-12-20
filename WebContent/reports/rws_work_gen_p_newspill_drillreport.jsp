
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 


<%

/* String dcode=request.getParameter("dcode");

String divcode=request.getParameter("divcode");
System.out.println("divcode***####"+divcode);
 */
 
 
 StringBuffer subdi=new StringBuffer();


//String planNonplan="";
StringBuffer planNonplan=new StringBuffer();

//String program="";
StringBuffer program=new StringBuffer();

//session.setAttribute("planNonplan",planNonplan);
planNonplan.delete(0,planNonplan.length());
planNonplan.append(session.getAttribute("plan"));
System.out.println("planNonplan::"+planNonplan);


//String planName = "PLAN & NON PLAN";
StringBuffer planName=new StringBuffer();
planName.delete(0,planName.length());
planName.append("PLAN & NON PLAN");
//String planQry="";
StringBuffer planQry=new StringBuffer();

if(planNonplan.toString().equals("1"))
{
	planQry.delete(0,planQry.length());	
planQry.append("and plan_code = '1'");

planName.delete(0,planName.length());
planName.append(" PLAN ");
}
else if(planNonplan.equals("2"))
{
	planQry.delete(0,planQry.length());
planQry.append("and plan_code = '2'");


planName.delete(0,planName.length());
planName.append(" NON PLAN ");
}

program.delete(0,program.length());
program.append(session.getAttribute("programe"));
	//System.out.println("programe*******"+program);
	
	
	//String scheme=(String)session.getAttribute("scheme");
	StringBuffer scheme=new StringBuffer();
	scheme.append(session.getAttribute("scheme"));
	//System.out.println("scheme*******"+scheme);


 //String circleOfficeCode=request.getParameter("ccode");
 /* StringBuffer circleOfficeCode=new StringBuffer(request.getParameter("ccode"));
  if(circleOfficeCode.toString()!=null)
  {
   session.setAttribute("circleOfficeCode",circleOfficeCode);
 } */
 
// String type=request.getParameter("type");
 /* StringBuffer type=new StringBuffer(request.getParameter("type"));
  if(type.toString()!=null)
 {
		session.setAttribute("type",type);
} */

//String catageory=request.getParameter("cat");
StringBuffer catageory=new StringBuffer(request.getParameter("cat"));
  if(catageory.toString()!=null)
  {
		session.setAttribute("catageory",catageory);
}

 
  StringBuffer yr=new StringBuffer();
  yr.append(session.getAttribute("yr"));
  
  int yr1=Integer.parseInt(yr.toString())+1;
  
 DecimalFormat ndf = new DecimalFormat("##.##");





 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
   <td class="bwborder">
<a href="javascript:onclick=history.go(-1)">Back|</td></tr>
            <a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr align="center">
		<td align="center" class="gridhdbg" ></td><td align="right" class="gridhdbg" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>Work ID   </b></td>
<td class=gridhdbg ><b>Work Name </b></td>
<td class=gridhdbg ><b>Admin No   </b></td>
<td class=gridhdbg ><b>Sanction Amount   </b></td>

<td class=gridhdbg ><b>SPILL OVER   </b></td>
<td class=gridhdbg ><b>Category Code  </b></td>
<td class=gridhdbg ><b>Remarks  </b></td>
 
  </tr>




	<%try
      { 
		
		
		int count=1;
       Statement stmt1=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs1=null,rs3=null;
      
       stmt1=conn.createStatement();
stmt3=conn.createStatement();
stmt4=conn.createStatement();     

boolean notGrounded=false;

       
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

StringBuffer qry=new StringBuffer(); 
StringBuffer distname1=new StringBuffer();
StringBuffer distname2=new StringBuffer();

/*
query1="SELECT WORK_ID,WORK_NAME ,nvl(SANCTION_AMOUNT,0) ,nvl(ADMIN_NO,'-') ,SPILL_OVER ,category_code  FROM RWS_WORK_ADMN_TBL W where to_date(w.ADMIN_DATE) <'01-Apr-2012'  and work_cancel_dt is null and WORK_CATEGORY ='PROJECTS' and plan_code = '1' and w.programme_code in("+program+") and type_of_asset in("+scheme+")   ";
if(catageory!=null && !catageory.equals("")){
    query1+="and w.category_code='"+catageory+"' ";
}
query1+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2012'))  group by WORK_ID,WORK_NAME ,SANCTION_AMOUNT ,ADMIN_NO ,SPILL_OVER ,category_code order by 2 ";

*/


//query1="SELECT w.work_id,w.work_name,nvl(ADMIN_NO,'-'),nvl(SANCTION_AMOUNT,0)  ,nvl(SPILL_OVER,'-') ,category_code,nvl(REMARKS,'-')  FROM RWS_WORK_ADMN_TBL W where to_date(w.ADMIN_DATE) <'01-Apr-2012'  and work_cancel_dt is null and plan_code = '1' and category_code='1' and w.programme_code in("+program+") and type_of_asset in("+scheme+")   and w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2012')) group by w.work_id,w.work_name,nvl(SANCTION_AMOUNT,0) ,nvl(ADMIN_NO,'-') ,nvl(SPILL_OVER,'-') ,category_code,nvl(REMARKS,'-')"; 
qry.append("select w.work_id,w.work_name,nvl(ADMIN_NO,'-'),nvl(SANCTION_AMOUNT,0)  ,nvl(SPILL_OVER,'-') ,category_code,nvl(REMARKS,'-')  FROM RWS_WORK_ADMN_TBL W where (w.ADMIN_DATE >= '1-APR-"+yr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+yr1+"') and work_cancel_dt is null  "+planQry.toString()+" and category_code='"+catageory.toString()+"' and w.programme_code in("+program.toString()+") and type_of_asset in("+scheme.toString()+")  group by w.work_id,w.work_name,nvl(ADMIN_NO,'-'),nvl(SANCTION_AMOUNT,0)  ,nvl(SPILL_OVER,'-') ,category_code,nvl(REMARKS,'-')") ;



     System.out.println("qry******ssss*****"+qry.toString());
       rs1=stmt1.executeQuery(qry.toString());
       int styleCount=0;
    	StringBuffer style=new StringBuffer();
      
       while(rs1.next())
       {
    	   if(styleCount%2==0){
				 style.delete(0,style.length());
				 style.append("gridbg1");
			 }else{
				 style.delete(0,style.length());
				 style.append("gridbg2");
			 }
			 styleCount++;
        %>

                <tr>
	           
                <td class=<%=style.toString() %> style="text-align: left;">&nbsp;<%=count++%> </td>
             <td  class=<%=style.toString() %> style="text-align: left;">&nbsp;<%=rs1.getString(1)%> </td>
         
				<td class=<%=style.toString() %> style="text-align: left;">&nbsp;<%=rs1.getString(2)%> </td>    
					<td class=<%=style.toString() %> style="text-align: left;"><%=rs1.getString(3)%>   </td>  
				<td class=<%=style.toString() %> style="text-align: left;"><%=rs1.getString(4)%>   </td>  
				<td class=<%=style.toString() %> style="text-align: left;"><%=rs1.getString(5)%>  </td>  

		 <td class=<%=style.toString() %> style="text-align: left;"><%=rs1.getString(6)%>   </td>  
				  
		  <td class=<%=style.toString() %> style="text-align: left;"><%=rs1.getString(7)%>   </td>
              
			
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
		StringBuffer style=null;
		StringBuffer qry=null; 
		StringBuffer distname1=null;
		StringBuffer distname2=null;

	}
	%>
	
</table>
</form>

