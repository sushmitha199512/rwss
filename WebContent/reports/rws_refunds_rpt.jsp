<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null,stmt131=null;
    ResultSet rs1=null,rs8=null;
    
    String fromDate=request.getParameter("fromDate");
   // System.out.println("fromDate***************"+fromDate);
    String toDate=request.getParameter("toDate");

    String qry="";
    double billamtcentral=0.0,billamtstate=0.0,billtotal=0.0;
    double billcentral=0,billstate=0,tot=0;
    double tot1=0,bamount=0;
    String div="";
    int count=0;
    int sno=1;
    String dcode=request.getParameter("district");
    //System.out.println("district***"+dcode);
    String dname=request.getParameter("dname");
    String divname=request.getParameter("divpname"); 
    String sname="";
	String a1="",a2="",a3="",a4="";
	String b1="",b2="",b3="",b4="";
	double central=0.0,state=0.0;
	double tot2=0.0;
	double tot3=0;
	double tot4=0;
    
		%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table width="80%"  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back &nbsp; </td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="gridhdbg" colspan="16" > Refund - Report</td>
	
	</tr>
	<tr><td class="gridhdbg" align="center" colspan="16">From Date:<%=fromDate%></font>&nbsp;&nbsp;&nbsp;&nbsp;To Date:<%=toDate%></font></td></tr>
    <%
   if(dcode.equals("all"))
     {%>
   <tr>
	<td class="gridhdbg"  nowrap align=center colspan="16" >Districts:<font color=red><%=dcode%></font></td>
    </tr> 
   <%}else
{%>
<%}%>   
   
	<tr>
	<td class="gridhdbg" rowspan=2 align=center nowrap>Sl.No</td>
<td class="gridhdbg" rowspan=2 align=center nowrap>District</td>
<td class="gridhdbg" rowspan=2 align=center nowrap>Division</td>

<td class="gridhdbg" rowspan=2 align=center nowrap>Programme</td>
               <td class="gridhdbg" rowspan=2 align=center nowrap>Work Id/<br>Work Name</td>
               
               <td class="gridhdbg" rowspan=2 align=center nowrap>Admin No</td>
               <td class="gridhdbg" rowspan=2 align=center nowrap>Admin Sanction Date</td>
			   <td class="gridhdbg" rowspan=2 align=center nowrap>Sanction Amount<br>(Amount in Rs  lakhs)</td>
               <td class="gridhdbg" colspan=4 align=center nowrap>BANK</td>
               <td class="gridhdbg" colspan=4 align=center nowrap>PAO</td>
               
               
              
               
               
               </tr>
              <tr>
               
<td class="gridhdbg" align=center nowrap>BANK Refund Amount<br>(Amount in Rs.)</td>
<td class="gridhdbg" align=center nowrap>Date</td>
<td class="gridhdbg" align=center nowrap>Refund Cheque No</td>
<td class="gridhdbg" align=center nowrap>Remarks</td>
<td class="gridhdbg" align=center nowrap>PAO Refund AMT<br>(Amount in Rs.)</td>
                 <td class="gridhdbg" align=center nowrap>Date</td>
                  <td class="gridhdbg" align=center nowrap>Refund Cheque No</td>
                  <td class="gridhdbg" align=center nowrap>Remarks</td>
              
              </tr>
              



	
<%
try
{
	String houseconn="";
	if(dcode.equals("all"))
	{
	houseconn="select nvl(a.refund_bill_amount,0),to_char(a.update_date,'dd/mm/yyyy'),	nvl(a.refund_chq_no,'-'),nvl(a.remarks,'-'),a.work_id from rws_div_work_bank_refund_tbl a,rws_work_admn_tbl b 	where a.refund_flag='p' and	a.work_id=b.work_id and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE<= to_date('"+toDate+"','dd/mm/yyyy')  order by a.work_id ";
	}
	else
	{
		houseconn="select nvl(a.refund_bill_amount,0),to_char(a.update_date,'dd/mm/yyyy'),";
		houseconn+="nvl(a.refund_chq_no,'-'),nvl(a.remarks,'-'),a.work_id from rws_div_work_bank_refund_tbl a,rws_work_admn_tbl b where a.refund_flag='p' and a.work_id=b.work_id  and substr(b.office_code,2,2)='"+dcode+"' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE<= to_date('"+toDate+"','dd/mm/yyyy') ";
		if(div != null && !div.equals(""))
			{
			houseconn+="and subtsr(b.office_code,4,1)='"+div+"'";
			}
			houseconn+="order by a.work_id";
		
	}
	
	Statement	stmt888=conn.createStatement();
	//System.out.println("houseconn:"+houseconn);
	ResultSet rs888=stmt888.executeQuery(houseconn);
	Hashtable houseconh=new Hashtable();
		while(rs888.next())
	{
		houseconh.put(rs888.getString(5),rs888.getString(1)+"@"+rs888.getString(2)+"@"+rs888.getString(3)+"@"+rs888.getString(4));
	}
	if(stmt888!=null)
		stmt888.close();
	if(rs888!=null)
		rs888.close();
	
	 //rws_div_work_pao_refund_tbl
    String household="";
	if(dcode.equals("all"))
	{
		household="select nvl(a.refund_bill_amount,0),to_char(a.update_date,'dd/mm/yyyy'),nvl(a.refund_chq_no,'-'),nvl(a.remarks,'-'),a.work_id from  rws_div_work_pao_refund_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE<= to_date('"+toDate+"','dd/mm/yyyy') ";
	}
	else
	{
	household="select nvl(a.refund_bill_amount,0),to_char(a.update_date,'dd/mm/yyyy'),nvl(a.refund_chq_no,'-'),nvl(a.remarks,'-'),a.work_id from  rws_div_work_pao_refund_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and refund_flag='p' and substr(b.office_code,2,2)='"+dcode+"' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE<= to_date('"+toDate+"','dd/mm/yyyy') ";
	

	if(div != null && !div.equals(""))
			{
			household+="and subtsr(b.office_code,4,1)='"+div+"'";
			}
			household+="order by a.work_id";
		
	}
	Statement	stmt88=conn.createStatement();
	//System.out.println("household:"+household);
	ResultSet rs88=stmt88.executeQuery(household);
	Hashtable householdh=new Hashtable();
		while(rs88.next())
	{
		householdh.put(rs88.getString(5),rs88.getString(1)+"@"+rs88.getString(2)+"@"+rs88.getString(3)+"@"+rs88.getString(4));
	}
	if(stmt88!=null)
		stmt88.close();
	if(rs88!=null)
		rs88.close();
	

   String hp="";
if(dcode.equals("all"))
	{
 hp="select  distinct a.circle_office_name,a.circle_office_code from rws_circle_office_tbl a,rws_work_admn_tbl b where substr(b.work_id,5,2)=a.circle_office_code and (b.work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and  EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy')) or  b.work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE<= to_date('"+toDate+"','dd/mm/yyyy')))  ";
	}
	else
	{
     hp="select distinct a.circle_office_name,a.circle_office_code from rws_circle_office_tbl a,rws_work_admn_tbl b where substr(b.work_id,5,2)=a.circle_office_code and substr(b.office_code,2,2)='"+dcode+"' and (b.work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p' and  EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE<=to_date('"+toDate+"','dd/mm/yyyy')) or  b.work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p' and  EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE<= to_date('"+toDate+"','dd/mm/yyyy')))  ";
	 if(div != null && !div.equals(""))
			{
			hp+="and subtsr(b.office_code,4,1)='"+div+"'";
			}
        
			
		}
    
	
	Statement	stmt6=conn.createStatement();
	//System.out.println("hp:"+hp);
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
	
	String panch="";
	 if(dcode.equals("all"))
		{
		 panch="select distinct a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_work_admn_tbl b where substr(office_code,2,2)=a.circle_office_code and substr(office_code,4,1)=a.division_office_code and (b.work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy')) or  b.work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy')))  ";
		}
		else
		{
			panch="select distinct a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_work_admn_tbl b where substr(office_code,2,2)=a.circle_office_code and substr(office_code,4,1)=a.division_office_code  and substr(b.office_code,2,2)='"+dcode+"' and (b.work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy')) or  b.work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy')))  ";
			if(div != null && !div.equals(""))
			{
			panch+="and subtsr(b.office_code,4,1)='"+div+"'";
			}
       	}  
System.out.println(panch);
		Statement stmt99=conn.createStatement();
	//	System.out.println("panchlatitude:"+panch);
		ResultSet rs99=stmt99.executeQuery(panch);
		Hashtable panchh=new Hashtable();
		while(rs99.next())
		{
		panchh.put(rs99.getString(2)+rs99.getString(3),rs99.getString(1));
		}
		if(stmt99!=null)
		stmt99.close();
	    if(rs99!=null)
		rs99.close();


   
	 stmt8=conn.createStatement();
	 div=request.getParameter("division");
	//System.out.println("division*********"+div); 
	 if(dcode.equals("all"))
	 {    	
	 qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,substr(office_code,2,2),substr(office_code,4,1),b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b where  substr(a.work_id,1,2)=b.programme_code and (work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy')) or  work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy'))) order by 1";
   
	}
	 else 
	{
	 qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,substr(office_code,2,2),substr(office_code,4,1),b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b  where  substr(a.work_id,1,2)=b.programme_code and  (work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy')) or  work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p' and EE_FORWARD_DATE>=to_date('"+fromDate+"','dd/mm/yyyy') and EE_FORWARD_DATE <= to_date('"+toDate+"','dd/mm/yyyy'))) and substr(office_code,2,2)='"+dcode+"'";
	 if(div != null && !div.equals(""))
 		{
  		qry+=" and substr(office_code,4,1)='"+div+"'";
		}
	}
  // System.out.println("qry1???????????***************"+qry); 
	rs8=stmt8.executeQuery(qry);
    tot3=0.0;
	tot4=0.0;

	while (rs8.next())
	{
		count++;
     	
    String cir=(String)hph.get(rs8.getString(6));
	if(cir!=null && !cir.equals("") && !cir.equals("null"))	
    {

     }
else
{
cir="-";
}
String name=(String)panchh.get(rs8.getString(6)+rs8.getString(7));
	if(name!=null && !name.equals("") && !name.equals("null"))	
    {

     }
else
{
name="-";
}
String hiss1=(String)houseconh.get(rs8.getString(1));
	if(hiss1!=null && !hiss1.equals("") && !hiss1.equals("null"))
	{
	String []hhh=hiss1.split("@");
	a1=hhh[0];
	a2=hhh[1];
	a3=hhh[2];
	a4=hhh[3];
	
	}
	else{
	a1="0";
	a2="-";
	a3="-";
	a4="-";
	}
	String hiss2=(String)householdh.get(rs8.getString(1));
	if(hiss2!=null && !hiss2.equals("") && !hiss2.equals("null"))
	{
	String []hhh1=hiss2.split("@");
	b1=hhh1[0];
	b2=hhh1[1];
	b3=hhh1[2];
	b4=hhh1[3];
	
	}
	else{
	b1="0";
	b2="-";
	b3="-";
	b4="-";
	}
	java.text.DecimalFormat ndf = new java.text.DecimalFormat("####.00");
	central=Double.parseDouble(a1);
	//System.out.println("central"+central);
	
	state=Double.parseDouble(b1);
	
	tot3=tot3+central;
   // System.out.println("tot3"+tot3);
	tot4=tot4+state;
	

tot2=tot2+rs8.getDouble(5);

%>
	<tr>
    <td class="rptValue"><%=sno++%></td>
    <td class="rptValue" align="left"><%=cir%></td>
        <td class="rptValue" align="left"><%=name%></td>
        <td class="rptValue" align="left"><%=rs8.getString(8) %></td>
    <td class="rptValue" align=left><%=rs8.getString(1)%>/<br><%=rs8.getString(2)%></td>
    
    <td class="rptValue" align=left><%=rs8.getString(3)%></td>
        <td class="rptValue" align=center><%=rs8.getString(4)%></td>
        <td class="rptValue" align=center><%=rs8.getDouble(5)%></td>
		<td class="rptValue" align=right><%=a1%></td>
		<td class="rptValue" align=center><%=a2%></td>
		<td class="rptValue" align=center><%=a3%></td>
		<td class="rptValue" align=left><%=a4%></td>
           
        <td class="rptValue" align=center><%=b1%></td>
		<td class="rptValue" align=center><%=b2%></td>
		<td class="rptValue" align=center><%=b3%></td>
		<td class="rptValue" align=left><%=b4%></td>
            
        
        
    
   	</tr>
<%
}
	java.text.DecimalFormat ndf = new java.text.DecimalFormat("####.00");
	
%>
<tr>
<td class="gridhdbg" colspan="7" align="right"><b>Total:</b></td>
<td class="gridhdbg" align=center><%=tot2%></td>
<td class="gridhdbg" align=center ><%=ndf.format(tot3)%></td>
<td class="gridhdbg"></td>
<td class="gridhdbg"></td>
<td class="gridhdbg"></td>

<td class="gridhdbg" align=center ><%=ndf.format(tot4)%></td>
<td class="gridhdbg"></td>
<td class="gridhdbg"></td>
<td class="gridhdbg"></td>
<%
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

  
