<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null,stmt131=null;
    ResultSet rs1=null,rs8=null;
    String qry="";
    int styleCount=0;
    String style="";

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
	<table border = 0 cellspacing = 0 cellpadding = 0 width="100%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back &nbsp; </td>
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Describancy( Difference ) in No. Of Habs  - Report</td>
	</tr>
    <%
   if(dcode.equals("all"))
     {%>
   <tr>
	<td class=gridhdbg  nowrap align=center rowspan=2><b>*****Districts: </b><font color=red><%=dcode%></font></td>
    </tr> 
   <%}else
{%>
<%}%> 
	</table>
   
   <table width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>Circle</td>
    <td class=gridhdbg rowspan=2>Division</td>
    <td class=gridhdbg rowspan=2>Work Id</td>
	<td class=gridhdbg rowspan=2>Work Name</td>
    <td class=gridhdbg rowspan=2>Admin Number</td>
    <td class=gridhdbg rowspan=2>Admin Date</td>
	<td class=gridhdbg rowspan=2>Sanction Amount<br> ( Amount in Rs. Lakhs )</td>
    <td class=gridhdbg rowspan=2>No Of Habs</td>
    <td class=gridhdbg rowspan=2>Admin Habs</td>
    <td class=gridhdbg rowspan=2>Office </td>
	
	</tr>
    <tr>
       </tr>
<%
try
{
	//circle starts here
	String hp="";
if(dcode.equals("all"))
	{
 hp="select  a.circle_office_name,a.circle_office_code from rws_circle_office_tbl a,rws_work_admn_tbl b where substr(b.work_id,5,2)=a.circle_office_code  ";
	}
	else
	{
     hp="select  a.circle_office_name,a.circle_office_code from rws_circle_office_tbl a,rws_work_admn_tbl b where substr(b.work_id,5,2)=a.circle_office_code  and substr(b.office_code,2,2)='"+dcode+"' ";
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
		 panch="select  a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_work_admn_tbl b where substr(office_code,2,2)=a.circle_office_code and substr(office_code,4,1)=a.division_office_code  ";
		}
		else
		{
			panch="select  a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_work_admn_tbl b where substr(office_code,2,2)=a.circle_office_code and substr(office_code,4,1)=a.division_office_code  and substr(b.office_code,2,2)='"+dcode+"' ";
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
	//admin count
//
	String owq1="";
	 if(dcode.equals("all"))
		{
		 owq1="select  count(hab_code),a.work_id from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and work_cancel_dt is null group by a.work_id";
		}
		else
		{
		owq1="select  count(hab_code),a.work_id from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and work_cancel_dt is null and substr(office_code,2,2)='"+dcode+"' group by a.work_id";
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
	



   //main qry
   
   stmt8=conn.createStatement();
   div=request.getParameter("division");
   //System.out.println("division*********"+div); 
   if(dcode.equals("all"))
   {    	
   qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,office_code,substr(office_code,2,2),substr(office_code,4,1),nvl(no_of_habs,0) from rws_work_admn_tbl where  work_cancel_dt is null order by substr(work_id,5,2) ";
   }
   else 
{
  qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,office_code,substr(office_code,2,2),substr(office_code,4,1),nvl(no_of_habs,0) from rws_work_admn_tbl where  work_cancel_dt is null and substr(office_code,2,2)='"+dcode+"'";
 		if(div != null && !div.equals(""))
 		{
  		qry+=" and substr(office_code,4,1)='"+div+"'";
		}
}
  // System.out.println("qry1***************"+qry); 
	rs8=stmt8.executeQuery(qry);
   
	while (rs8.next())
	{
		count++;
		
		
     	
    
String cir=(String)hph.get(rs8.getString(7));
	if(cir!=null && !cir.equals("") && !cir.equals("null"))	
    {

     }
else
{
cir="-";
}
String name=(String)panchh.get(rs8.getString(7)+rs8.getString(8));
	if(name!=null && !name.equals("") && !name.equals("null"))	
    {

     }
else
{
name="-";
}
String status1="";
String name1=(String)owhh.get(rs8.getString(1));
//System.out.println("name1"+name1);
	if(name1!=null && !name1.equals("") )	
    {
     
     }
else
{

name1="0";
}
//
//
String name11=(String)owhh.get(rs8.getString(1));
	if(name11!=null && !name11.equals("") )	
    {
     status1="Grounded";
     }
else
{
status1="Not Grounded";
name11="-";
}

	
	int admnHabLnkhabs=Integer.parseInt(name1);
	int nofhabs=Integer.parseInt(rs8.getString(9));
	
	
	if(admnHabLnkhabs==nofhabs){
		continue;
	}
	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style %> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style %> "style="text-align: left;"><%=cir%></td>
    <td class="<%=style %> "style="text-align: left;"><%=name%></td>
    <td class="<%=style %> "style="text-align: right;"><%=rs8.getString(1)%></td>
    <td class="<%=style %> "style="text-align: left;"><%=rs8.getString(2)%></td>  
    <td class="<%=style %> "style="text-align: right;"><%=rs8.getString(3)%></td>
    <td class="<%=style %> "style="text-align: right;"><%=rs8.getString(4)%></td>
    <td class="<%=style %> "style="text-align: right;"><%=rs8.getDouble(5)%></td>
    <td class="<%=style %> "style="text-align: right;"><%=rs8.getString(9)%></td>
    <td class="<%=style %> "style="text-align: right;"><%=name1%></td>
    <td class="<%=style %> " style="text-align: right;"><%=rs8.getString(6)%></td>
 
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

  
