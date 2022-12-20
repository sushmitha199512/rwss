<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null,stmt131=null;
    ResultSet rs1=null,rs8=null;
    String qry="";
    double billamtcentral=0.0,billamtstate=0.0,billtotal=0.0;
    double billcentral=0,billstate=0,tot=0;
    double tot1=0,bamount=0;
	String status="";
    String div="";
    int count=0;
    int sno=1;
    String dcode=request.getParameter("district");
    //System.out.println("district***"+dcode);
    String dname=request.getParameter("dname");
	//System.out.println("dname"+dname);
    String divname=request.getParameter("divpname"); 
    String sname="";
   	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back &nbsp; </td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Blocked Works - Report</td>
	</tr>
    <%
   if(dcode.equals("all"))
     {%>
   <tr>
	<td class=btext  nowrap align=center rowspan=2>Districts:<font color=red><%=dcode%></font></td>
    </tr> 
   <%}else
{%>
<%}%> 
	</table>
   
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	<td class=btext  nowrap align=center rowspan=2>Sl.No</td>
    <td class=btext  nowrap align=center rowspan=2>Circle</td>
    <td class=btext  nowrap align=center rowspan=2>Division</td>
    <td class=btext  nowrap align=center rowspan=2>Work Id</td>
	<td class=btext  nowrap align=center rowspan=2>Work Name</td>
    	<td class=btext  nowrap align=center rowspan=2>Admin Number</td>
    	<td class=btext  nowrap align=center rowspan=2>Admin Date</td>
	<td class=btext  nowrap align=center rowspan=2>Sanction Amount<br> ( Amount in Rs. Lakhs )</td>
    <td class=btext  nowrap align=center rowspan=2>Status</td>
    	
    <td class=btext  nowrap align=center rowspan=2>Blocked Payment</td>
	<td class=btext  nowrap align=center rowspan=2>Blocked Date</td>
    <td class=btext nowrap align=center colspan=3>Releases<br>
( Amount in Rs. )
    <td class=btext nowrap align=center rowspan=2>Balanace <br>(Amount in Rs. Lakhs)</td>
	
	</tr>
    <tr>
      <td class=btext nowrap align=center>Central</td>
       <td class=btext nowrap align=center>State</td>
       <td class=btext nowrap align=center>Total</td>
<%
try
{
	    String central1="";
		if(dcode.equals("all"))
		{
		central1="select sum(nvl(bill_amount_central,0)),b.work_id from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and block_payment='Y' group by b.work_id";
		}
		else
		{
		central1="select sum(nvl(bill_amount_central,0)),b.work_id from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and block_payment='Y' and substr(a.office_code,2,2)='"+dcode+"'";
		if(div != null && !div.equals(""))
		{
			central1+=" and subtsr(a.office_code,4,1)='"+div+"'";
		}
        
		central1+="group by b.work_id";
		}
		

		Statement	stmt8888=conn.createStatement();
		//System.out.println("central:"+central1);
		ResultSet rs8888=stmt8888.executeQuery(central1);
		Hashtable houseconhh=new Hashtable();
		while(rs8888.next())
	{
			houseconhh.put(rs8888.getString(2),rs8888.getString(1));
		}
		if(stmt8888!=null)
		stmt8888.close();
		if(rs8888!=null)
        rs8888.close();
	
   //Central end here

   //State start here 

   String state1=""; 	
	if(dcode.equals("all"))
		{
		state1="select sum(nvl(BILL_AMOUT_STATE,0)),b.work_id from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and block_payment='Y' group by b.work_id ";
		}
		else
		{
		state1="select sum(nvl(BILL_AMOUT_STATE,0)),b.work_id from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and block_payment='Y' and substr(a.office_code,2,2)='"+dcode+"'";
		
			if(div != null && !div.equals(""))
			{
			state1+="and subtsr(a.office_code,4,1)='"+div+"'";
			}
        
			state1+="group by b.work_id";
		}

		Statement	stmt881=conn.createStatement();
		//System.out.println("state1:"+state1);
		ResultSet rs881=stmt881.executeQuery(state1);
		Hashtable householdhh=new Hashtable();
			while(rs881.next())
		{
			householdhh.put(rs881.getString(2),rs881.getString(1));
		}
		if(stmt881!=null)
		stmt881.close();
		if(rs881!=null)
        rs881.close();
		//State end here
//circle starts here
	String hp="";
if(dcode.equals("all"))
	{
 hp="select  a.circle_office_name,a.circle_office_code from rws_circle_office_tbl a,rws_work_admn_tbl b where substr(b.work_id,5,2)=a.circle_office_code and block_payment='Y' ";
	}
	else
	{
     hp="select  a.circle_office_name,a.circle_office_code from rws_circle_office_tbl a,rws_work_admn_tbl b where substr(b.work_id,5,2)=a.circle_office_code and block_payment='Y' and substr(b.office_code,2,2)='"+dcode+"' ";
	 if(div != null && !div.equals(""))
			{
			hp+="and subtsr(b.office_code,4,1)='"+div+"'";
			}
        
			
		}
    
	
	Statement	stmt6=conn.createStatement();
	//System.out.println("ohsr:"+hp);
	ResultSet rs6=stmt6.executeQuery(hp);
	Hashtable hph=new Hashtable();
		while(rs6.next())
	{
		hph.put(rs6.getString(2),rs6.getString(1));
	}
	if(stmt6!=null)
		stmt6.close();
		if(rs6!=null)
        rs6.close();
	// circle ends here
 // division starts here
	String panch="";
	 if(dcode.equals("all"))
		{
		 panch="select  a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_work_admn_tbl b where substr(office_code,2,2)=a.circle_office_code and substr(office_code,4,1)=a.division_office_code and block_payment='Y' ";
		}
		else
		{
			panch="select  a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_work_admn_tbl b where substr(office_code,2,2)=a.circle_office_code and substr(office_code,4,1)=a.division_office_code and block_payment='Y' and substr(b.office_code,2,2)='"+dcode+"' ";
			if(div != null && !div.equals(""))
			{
			panch+="and subtsr(b.office_code,4,1)='"+div+"'";
			}
        
			
			}
    


		Statement stmt99=conn.createStatement();
//		//System.out.println("panchlatitude:"+panch);
		ResultSet rs99=stmt99.executeQuery(panch);
		Hashtable panchh=new Hashtable();
		while(rs99.next())
		{
		panchh.put(rs99.getString(2)+rs99.getString(3),rs99.getString(1));
		}

//
       if(stmt99!=null)
		stmt99.close();
		if(rs99!=null)
        rs99.close();
	String owq="";
	if(dcode.equals("all"))
		{
		owq="select  nvl(to_char(a.date_of_completion,'dd/mm/yyyy'),'-'),a.work_id from rws_work_completion_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and block_payment='Y'";
		}
		else
		{
		owq="select  nvl(to_char(a.date_of_completion,'dd/mm/yyyy'),'-'),a.work_id from rws_work_completion_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and block_payment='Y' and substr(b.office_code,2,2)='"+dcode+"'";
			if(div != null && !div.equals(""))
				{
				owq+="and subtsr(b.office_code,4,1)='"+div+"'";
				}
        
				
				}

		Statement	stmt11=conn.createStatement();
//		System.out.println("owq:"+owq);
		ResultSet rs11=stmt11.executeQuery(owq);
		Hashtable owh=new Hashtable();
		while(rs11.next())
		{
			owh.put(rs11.getString(2),rs11.getString(1));
		}
		if(stmt11!=null)
		stmt11.close();
		if(rs11!=null)
        rs11.close();
	

//
	String owq1="";
	 if(dcode.equals("all"))
		{
		 owq1="select  nvl(to_char(a.grounding_date,'dd/mm/yyyy'),'-'),a.work_id from rws_work_commencement_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and block_payment='Y' ";
		}
		else
		{
		owq1="select  nvl(to_char(a.grounding_date,'dd/mm/yyyy'),'-'),a.work_id from rws_work_commencement_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and block_payment='Y' and substr(b.office_code,2,2)='"+dcode+"'";
				if(div != null && !div.equals(""))
				{
				owq1+="and subtsr(b.office_code,4,1)='"+div+"'";
				}
        
				
				}


		Statement	stmt111=conn.createStatement();
//		System.out.println("owq:"+owq);
		ResultSet rs111=stmt111.executeQuery(owq1);
		Hashtable owhh=new Hashtable();
			while(rs111.next())
		{
		owhh.put(rs111.getString(2),rs111.getString(1));
		}
		
	if(stmt111!=null)
		stmt111.close();
		if(rs111!=null)
        rs111.close();
	



   
   stmt8=conn.createStatement();
   div=request.getParameter("division");
   //System.out.println("division*********"+div); 
   if(dcode.equals("all"))
   {    	
   qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,decode(block_payment,'Y','Yes','N','No'),to_char(block_date,'dd/mm/yyyy'),office_code,substr(office_code,2,2),substr(office_code,4,1) from rws_work_admn_tbl where block_payment='Y' order by substr(work_id,5,2)";
   }
   else 
{
  qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,decode(block_payment,'Y','Yes','N','No'),to_char(block_date,'dd/mm/yyyy'),office_code,substr(office_code,2,2),substr(office_code,4,1) from rws_work_admn_tbl where block_payment='Y' and substr(office_code,2,2)='"+dcode+"'";
 		if(div != null && !div.equals(""))
 		{
  		qry+=" and substr(office_code,4,1)='"+div+"'";
		}
}
  // System.out.println("qry1???????????***************"+qry); 
	rs8=stmt8.executeQuery(qry);
   
	while (rs8.next())
	{
		count++;
     	
    String hiss2=(String)houseconhh.get(rs8.getString(1));
	if(hiss2!=null && !hiss2.equals("") && !hiss2.equals("null"))
		{
		
		}
		else
		{
			hiss2="0";
		}
 String hiss3=(String)householdhh.get(rs8.getString(1));
	if(hiss3!=null && !hiss3.equals("") && !hiss3.equals("null"))
		{
		
		}
		else
		{
			hiss3="0";
		}
String cir=(String)hph.get(rs8.getString(9));
	if(cir!=null && !cir.equals("") && !cir.equals("null"))	
    {

     }
else
{
cir="-";
}
String name=(String)panchh.get(rs8.getString(9)+rs8.getString(10));
	if(name!=null && !name.equals("") && !name.equals("null"))	
    {

     }
else
{
name="-";
}
String status1="";
String name1=(String)owh.get(rs8.getString(1));
	if(name1!=null && !name1.equals("") && !name1.equals("null"))	
    {
     status="Physically Completed";
     }
else
{
status="Not Completed";
name1="-";
}
///
String name11=(String)owhh.get(rs8.getString(1));
	if(name11!=null && !name11.equals("") && !name11.equals("null"))	
    {
     status1="Grounded";
     }
else
{
status1="Not Grounded";
name11="-";
}



//for Rs
billcentral=Double.parseDouble(hiss2);
java.text.DecimalFormat ndf = new java.text.DecimalFormat("####.00");

billstate=Double.parseDouble(hiss3);

tot=billcentral+billstate;
 tot1=tot/100000;
 bamount=rs8.getDouble(5)-tot1;

%>
	<tr>
    <td class="rptValue"><%=sno++%></td>
    <td class="rptValue"><%=cir%></td>
        <td class="rptValue"><%=name%></td>
    <td class="rptValue" align=left><%=rs8.getString(1)%></td>
    <td class="rptValue" align=left><%=rs8.getString(2)%></td>  
    <td class="rptValue" align=left><%=rs8.getString(3)%></td>
        <td class="rptValue" align=center><%=rs8.getString(4)%></td>
        <td class="rptValue" align=center><%=rs8.getDouble(5)%></td>
        <td class="rptValue" align=left><%=status1%>/<br><%=status%></td>
                <td class="rptValue" align=left><%=rs8.getString(6)%></td>
        <td class="rptValue" align=center><%=rs8.getString(7)%></td>
        <td class="rptValue" align=center><%=ndf.format(billcentral)%></td>
         <td class="rptValue" align=center><%=ndf.format(billstate)%></td>
           <td class="rptValue" align=center><%=ndf.format(tot)%></td>
           <td class="rptValue" align=center><%=ndf.format(bamount)%></td>
            
        
        
    
   	</tr>
<%
}
if(count==0)
{
%>
<tr align="center">
    <td class="rptValue" colspan=12>No Records</td>
</tr>
<%
  }
	}catch(Exception e)
		{
		e.printStackTrace();
		}
finally
{
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

  
