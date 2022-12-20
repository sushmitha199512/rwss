<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<html>


<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
</script>


<form>
<%
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
DecimalFormat ndf = new DecimalFormat("######.##");
     nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dcode = request.getParameter("district");
	session.setAttribute("dcode",dcode);
	System.out.println("dcode@@@@@"+dcode);
	
	
	String division = request.getParameter("division");
	session.setAttribute("division",division);
	
	
	
	
	System.out.println("division@@@@@"+division);
	if(dcode!=null)
	{
		session.setAttribute("dcode",dcode);
	}
	String dname = request.getParameter("dname");
	if(dname!=null)
	{
		session.setAttribute("dname",dname);
	}
		String subprogram = request.getParameter("subprogram");
		if(subprogram!=null)
		{
			session.setAttribute("subprogram",subprogram);
		}
		String finyear = request.getParameter("finyear");
		if(finyear!=null)
	{
		session.setAttribute("finyear",finyear);
	}
		System.out.println("finyear"+finyear);
		String mode = request.getParameter("mode");	
		int sno=1, gc1=0,ga1=0,gb1=0;
		String programe="",nextyr="";
		
		String[] program=request.getParameterValues("program");
		ArrayList aa = new ArrayList();
		//System.out.println("ppppppppppp"+request.getParameterValues("program"));
if(request.getParameterValues("program")!=null)
{
  for(int i=0;i<program.length;i++)
{
programe += program[i]+",";
aa.add(program[i]);
}
System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
if(programe!=null)
{
session.setAttribute("programe",programe);
}

System.out.println("programe::::::::::::"+programe);

}



double rtotal=0,etotal=0;



%>
<body >

<table  cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a>
			
			<a href="./rws_direct_voucher_bill_rpt_excel.jsp" target=_new>Excel</a>
			
			</td>
				
			
			</tr>  
		</table>
	</caption>
	



	
<tr>
		<td align="center" class="gridhdbg " colspan="14">Direct Voucher Bill Report </td>
</tr>
</table>
<table     width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=gridhdbg  >Sl.No</td>
               <td class=gridhdbg  >District</td>
               <td class=gridhdbg  >Division</td>
           	    <td class=gridhdbg  >Total Works(New+Spill)</td>
			    <td class=gridhdbg  >Bill AMT</td>
			     <td class=gridhdbg  >Voucher AMT</td>
			   
			   
	</tr> 
    
<% 
try
{
String yr="",a1="",a2="",a3="",a4="",a5="",a6="",b1="",b2="",b3="",b4="",c1="";

double sanamt=0.0;
		if(finyear!=null)
			yr=finyear.substring(0,4);
		nextyr=finyear.substring(5,9);
		
		//System.out.println("finyear:"+finyear);
		//System.out.println("yyyyyyyy:"+yr);
			//System.out.println("nextyr:"+nextyr);
		if(yr!=null)
			{
			session.setAttribute("yr",yr);
			}
			if(nextyr!=null)
			{
			session.setAttribute("nextyr",nextyr);
			}
			
			//Statement stmt5=null,stmt6=null,stmt7=null;
			//ResultSet rs5=null,rs=null;

			
		    stmt4=conn.createStatement();
		    stmt2=conn.createStatement();
		    String voucher="",bill="",workcount="";
		    
		
			  if(dcode!=null && dcode.equals("All")&& division.equals(""))
			  {

				  
			//	  agree="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(PERCENT_COMPLETED_VAL/100000) FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl  m   where  w.work_id=m.work_id and work_cancel_dt is null and substr(work_id,5,2)='"+dcode+"' and w.programme_code in ("+programe+") and PERCENT_COMPLETED_VAL is not null and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
			//	   if(scheme!=null && !scheme.equals("")){
			//		   agree+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 1";

				  
				  
				  
				  
				  
				  
				 voucher="SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),sum(voucher_amt) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_voucher_tbl  m   where  w.work_id=m.work_id  and work_cancel_dt is null and   w.programme_code='"+programe+"'   group by substr(w.office_code,2,2),substr(w.office_code,4,1) ";

			  }
			   
			  
			  else 
			  
			  {
				  //voucher="SELECT w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(voucher_amt) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_voucher_tbl m   where  substr(office_code,5,2) is not null and w.work_id=m.work_id and work_cancel_dt is null and  substr(w.work_id,5,2)="+dcode+" and w.programme_code in ("+programe+")  and  substr(office_code,5,2) is not null group by w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 4";
			  voucher="SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),sum(voucher_amt) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_voucher_tbl  m   where  w.work_id=m.work_id  and work_cancel_dt is null and substr(w.work_id,5,2)="+dcode+" and substr(w.office_code,4,1)='"+division+"' and w.programme_code='"+programe+"'  group by substr(w.office_code,2,2),substr(w.office_code,4,1) ";
			  }
			  	  
			        System.out.println("voucher query:"+voucher);
			   		stmt3=conn.createStatement();
			   	    rs3=stmt3.executeQuery(voucher);
			   		Hashtable vcher=new Hashtable();
			   	while(rs3.next())
			   	{
			   		vcher.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
			   		
			   		///vcher.put(rs3.getString(1),rs11.getString(2)+"#"+rs11.getString(2)+"#"+rs11.getString(3)+"#"+rs11.getString(5)+"#"+rs11.getString(6)+"#"+rs11.getString(8));
			   		
			   	}
			   	
			   	
			   	
			   	
		//bill amt 
		
		 if(dcode!=null && dcode.equals("All")&& division.equals(""))
			  {

				// bill="SELECT w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(BILL_AMT_ADMISSIBLE ) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_bill_tbl  m   where  w.work_id=m.work_id and substr(office_code,5,2) is not null and   w.programme_code in ("+programe+") and  substr(office_code,5,2) is not null group by w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 4";

			 bill="SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),sum(BILL_AMT_ADMISSIBLE) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_bill_tbl  m   where  w.work_id=m.work_id  and work_cancel_dt is null and   w.programme_code='"+programe+"'  group by substr(w.office_code,2,2),substr(w.office_code,4,1) ";
				
				
				
			  }
			   
			  
			  else 
			  
			  {
				  //bill="SELECT w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(BILL_AMT_ADMISSIBLE) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_bill_tbl m   where  substr(office_code,5,2) is not null and w.work_id=m.work_id and work_cancel_dt is null and  substr(w.work_id,5,2)="+dcode+" and w.programme_code in ("+programe+")  and  substr(office_code,5,2) is not null group by w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 4";
			  bill="SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),sum(BILL_AMT_ADMISSIBLE) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_bill_tbl  m   where  w.work_id=m.work_id  and work_cancel_dt is null and substr(w.work_id,5,2)="+dcode+" and substr(w.office_code,4,1)='"+division+"' and  w.programme_code ='"+programe+"'   group by substr(w.office_code,2,2),substr(w.office_code,4,1) ";
				  
				  
			  }
			  	  
			        System.out.println("bill query:"+bill);
			   		stmt6=conn.createStatement();
			   	    rs6=stmt6.executeQuery(bill);
			   		Hashtable billhash=new Hashtable();
			   	while(rs6.next())
			   	{
			   		billhash.put(rs6.getString(1)+rs6.getString(2),rs6.getString(3));
			   		
			   		///vcher.put(rs3.getString(1),rs11.getString(2)+"#"+rs11.getString(2)+"#"+rs11.getString(3)+"#"+rs11.getString(5)+"#"+rs11.getString(6)+"#"+rs11.getString(8));
			   		
			   	}

			   	
			   	
			   	
			   	
			   	
			   	
			   	
			   	
			   	
			   	
			 //work count total
			 
			 
			 //and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
			  if(dcode!=null && dcode.equals("All")&& division.equals(""))
			  {
			    workcount="SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),count(*) FROM RWS_WORK_ADMN_TBL W   where   work_cancel_dt is null and   w.programme_code='"+programe+"' group by substr(w.office_code,2,2),substr(w.office_code,4,1) ";

			  }
			   
			  
			  else 
			  
			  {
				  //voucher="SELECT w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(voucher_amt) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_voucher_tbl m   where  substr(office_code,5,2) is not null and w.work_id=m.work_id and work_cancel_dt is null and  substr(w.work_id,5,2)="+dcode+" and w.programme_code in ("+programe+")  and  substr(office_code,5,2) is not null group by w.work_name,w.work_id,w.sanction_amount,substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 4";
			  workcount="SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),count(*) FROM RWS_WORK_ADMN_TBL W   where   work_cancel_dt is null and substr(w.work_id,5,2)="+dcode+" and substr(w.office_code,4,1)='"+division+"' and w.programme_code= '"+programe+"'  group by substr(w.office_code,2,2),substr(w.office_code,4,1) ";
			  }
			  	  
			        System.out.println("workcount query:"+workcount);
			   		stmt7=conn.createStatement();
			   	    rs7=stmt7.executeQuery(workcount);
			   		Hashtable workc=new Hashtable();
			   	while(rs7.next())
			   	{
			   		workc.put(rs7.getString(1)+rs7.getString(2),rs7.getString(3));
	   		
			   	}
  	
			   				  	   	
			   	
			   	
			
    String query = "";
	if(dcode!=null && dcode.equals("All")&& division.equals("")) {
	
	  
	
		 //query=" select a.circle_office_name,c.subdivision_office_code,c.subdivision_office_name,a.circle_office_code,b.division_office_code,b.division_office_name from rws_subdivision_office_tbl c,rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and b.division_office_code=c.division_office_code and c.circle_office_code=a.circle_office_code order by circle_office_code,division_office_code,subdivision_office_code";
		query=" select a.circle_office_name,b.division_office_name,a.circle_office_code,b.division_office_code from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and b.STATUS<>'UI'    order by circle_office_code,division_office_code";
	}else
	  {
	    //query="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'";
	    query="select a.circle_office_name,b.division_office_name,a.circle_office_code,b.division_office_code from rws_circle_office_tbl a,rws_division_office_tbl b where  a.circle_office_code='"+dcode+"' and a.circle_office_code=b.circle_office_code and b.STATUS<>'UI'     order by circle_office_code,division_office_code";
	  }
	String p1="";
 //System.out.println("#####query"+query);
   stmt1=conn.createStatement();
   stmt2=conn.createStatement();
stmt3=conn.createStatement();
stmt4=conn.createStatement();
String dateOfCompletion=null;
   
  rs1=stmt1.executeQuery(query);
  int styleCount=0;
  String style="";
  String p2="";
  while (rs1.next())
	{
	  String d1=rs1.getString(3);
	  String d2=rs1.getString(4);
	
	// 	System.out.println("d2ffffff"+d2);
	 
	//  System.out.println("WE:"+d1+d2);
	  String aw=(String)vcher.get(d1+d2);
	  String as=(String)billhash.get(d1+d2);
	  String wc=(String)workc.get(d1+d2);
	//  System.out.println("aw"+aw);
	if(aw!=null && !aw.equals("") && !aw.equals("null"))
	{
		String []awh=aw.split("@");
    a1=awh[0];
   
     
	}
	else{
	a1="-";
	
    }
	
	
	//bill  hash table
	
	
	if(as!=null && !as.equals("") && !as.equals("null"))
	{
		String []awh1=as.split("@");
       b1=awh1[0];
  
	
     
	}
	else{
	b1="-";
	
	
    }
	
	
	
	
	
	
	
	if(wc!=null && !wc.equals("") && !wc.equals("null"))
	{
		String []awh2=wc.split("@");
        c1=awh2[0];
  
	
     
	}
	else{
	c1="-";
	
	
    }
	
	
	
	
	
	
	
	
	

	  
	  
	  
	  
	  
	  
		

	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
  
 %>

				<tr >
				<td class=<%=style %> style="text-align: left;"><%=sno++%></td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%></td>
				<td class=<%=style %> style="text-align: right;" ><a href="#" onclick="viewWorks('rws_direct_voucher_bill_drill_rpt.jsp?circleofficecode=<%=rs1.getString(3)%>&dname=<%=rs1.getString(2)%>&divisionofficecode=<%=d2%>&divname=<%=rs1.getString(2)%>')"><%=c1 %></td>
				<td class=<%=style %> style="text-align: right;"><a href="#" onclick="viewWorks('rws_direct_bill_drill_rpt.jsp?circleofficecode=<%=rs1.getString(3)%>&dname=<%=rs1.getString(2)%>&divisionofficecode=<%=d2%>&divname=<%=rs1.getString(2)%>')"><%=b1 %></td>
				<td class=<%=style %> style="text-align: right;" ><a href="#" onclick="viewWorks('rws_direct_voucher_drill_rpt.jsp?circleofficecode=<%=rs1.getString(3)%>&dname=<%=rs1.getString(2)%>&divisionofficecode=<%=d2%>&divname=<%=rs1.getString(2)%>')"><%=a1%></td>
								
				</tr>
<%			

if(c1!=null && !c1.equals("null") && !c1.equals("-")){
gc1=Integer.parseInt(c1)+gc1;
}
//END loop for districts








  if(a1!=null && !a1.equals("null") && !a1.equals("-")){
	  ga1=Integer.parseInt(a1)+ga1;
	  }


  if(b1!=null && !b1.equals("null") && !b1.equals("-")){
	  gb1=Integer.parseInt(b1)+gb1;
	  }


	  }//END loop for districts

//System.out.println("c1"+c1);







%>
	<tr>
	 <td class="gridhdbg" colspan="3" align="center">Total:</td>
	 
     <td class="gridhdbg" style="text-align: right;" ><%=gc1%></td>
     
       <td class="gridhdbg" style="text-align: right;" ><%=gb1%></td>

 <td class="gridhdbg" style="text-align: right;" ><%=ga1%></td>
 </tr>
	
	<%
	
}
catch(Exception e)
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
		if(stmt1 != null )
		{
			stmt1.close();
		}
		if(rs3 != null )
		{
			rs3.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>

</td></tr>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</span>
</body>
</html>