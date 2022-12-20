<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>
<%  
    DecimalFormat ndf = new DecimalFormat("####.00");
    String finYear="";
    String fy="",fy3="";      
	int fy1=0,fy2=0,count=1;

	int habtot=0,works_during_tot=0,schools_san_tot=0,schools_san_till_tot=0,col12_tot=0,schools_san_finyear_tot=0;
	double est_tot=0,exp_tot=0,col7=0,col7_tot=0,col8_tot=0;
	String habcount="",est_cost="",exp_cost="",exp_during="",works_during="",schools_san="",schools_san_till="",schools_san_finyear="";
    //////////////////////////new//////////////////////////////////////////////
    String new_habcount="",new_est_cost="",new_exp_cost="",new_exp_during="",new_works_during="",new_schools_san="",new_schools_san_till="",new_schools_san_finyear="";
    int new_habtot=0,new_works_during_tot=0,new_schools_san_tot=0,new_schools_san_till_tot=0,new_col12_tot=0,new_schools_san_finyear_tot=0;
	double new_est_tot=0,new_exp_tot=0,new_col7=0,new_col7_tot=0,new_col8_tot=0;
	
    String gtxidValueOld = "",gtxidValue="";

	try{
		
		String temp="";
		conn=nic.watersoft.commons.RwsOffices.getConn();
		Statement stmt11=conn.createStatement();
		
			String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2010 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
		    //System.out.println("Fin"+ finquery);
			ResultSet rs11 = stmt11.executeQuery( finquery);
			if(rs11.next())
			{
				 fy=rs11.getString(1);
				 fy1=Integer.parseInt(fy)+1;
                 fy2=Integer.parseInt(fy)-1;
                 fy3=Integer.toString(fy1);
                 System.out.println("fy"+fy);
				System.out.println("fy1"+fy1);
				System.out.println("fy2"+fy2);
                System.out.println("fy3"+fy3);
	           %>
			   <%finYear=fy+"-"+fy1;%>
	           <%
       	    }
      if(rs11!=null)rs11.close();
	  if(stmt11!=null)stmt11.close();
     }
catch(Exception e){e.printStackTrace();}

String today=RwsUtils.getCurrentDate("dd-MMM-yyyy");
System.out.println("my today date"+today);
%>


<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "left">
		<caption align="center" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=23>School Monitoring Report for the  Financial Year( <%=finYear%> )</td>	
	</tr>
	    <tr align=center  align=center>
		<td class=btext align="center" rowspan=2>Sl.No</td>
		<td class=btext  align="center" rowspan=2>District</td>
		<td class=btext align="center" rowspan=2>Division</td>
		<td class=btext align="center" colspan=10>Spill Over</td>
		<td class=btext align="center" colspan=10>New</td>
		</tr>
<tr>
        <td class=btext align="center">No. of works</td>
		<td class=btext align="center">Est.Cost</td>
		<td class=btext align="center">Exp.Upto <br> 31.3.<%=fy %></td>	
		<td class=btext align="center">Bal Est.Cost</td>	
		<td class=btext align="center">Exp.during  <%=finYear%></td>	
		<td class=btext align="center">Works comp. during <%=finYear%></td>
		<td class=btext align="center">Schools Sanctioned</td>
		<td class=btext align="center">Schools Covered upto 31.3.<%=fy %></td>	
		<td class=btext align="center">Balance Schools as on 1.4.<%=fy %></td>	
		<td class=btext align="center">Schools Covered during <%=finYear%></td>	
        <td class=btext align="center">No. of works</td>
		<td class=btext align="center">Est.Cost</td>
		<td class=btext align="center">Exp.From 1.4.<%=fy %></td>	
		<td class=btext align="center">Bal Est.Cost</td>	
		<td class=btext align="center">Exp.during  <%=finYear%></td>	
		<td class=btext align="center">Works comp. during <%=finYear%></td>
		<td class=btext align="center">Schools Sanctioned</td>
		<td class=btext align="center">Schools Covered as on Date</td>	
		<td class=btext align="center">Balance Schools as on 1.4.<%=fy %></td>	
		<td class=btext align="center">Schools Covered during <%=finYear%></td>	
</tr>
	    <tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7(5-6)</td><td align="center" class=btext>8</td><td align="center" class=btext>9</td><td align="center" class=btext>10</td><td align="center" class=btext>11</td><td align="center" class=btext>12<br>(10-11)</td><td align="center" class=btext>13</td><td align="center" class=btext>14</td><td align="center" class=btext>15</td><td align="center" class=btext>16</td><td align="center" class=btext>17(15-16)</td><td align="center" class=btext>18</td><td align="center" class=btext>19</td><td align="center" class=btext>20</td><td align="center" class=btext>21</td><td align="center" class=btext>22</td><td align="center" class=btext>23</td>
</tr>
<%
try{
 

    String qry88="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(b.school_code) from rws_work_admn_tbl a, rws_work_School_lnk_tbl b where a.work_id=b.work_id and a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy') and a.ADMIN_DATE <=to_date('31-MAR-"+fy1+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st88=conn.createStatement();
	ResultSet r88=st88.executeQuery(qry88);
    System.out.println("qr88"+qry88);
	Hashtable list88=new Hashtable();
	while(r88.next())
	{
	list88.put(r88.getString(1)+r88.getString(2),r88.getString(3));
	}
	if(r88 != null)
	{
		r88.close();
	}
	if(st88 != null)
	{
		st88.close();
	}
    
    String qry77="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(b.school_code) from rws_work_admn_tbl a, rws_work_School_lnk_tbl b where a.work_id=b.work_id and a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st77=conn.createStatement();
	ResultSet r77=st77.executeQuery(qry77);
    System.out.println("qry77"+qry77);
	Hashtable list77=new Hashtable();
	while(r77.next())
	{
	list77.put(r77.getString(1)+r77.getString(2),r77.getString(3));
	}
	if(r77 != null)
	{
		r77.close();
	}
	if(st77 != null)
	{
		st77.close();
	}

    String qry66="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(b.school_code) from rws_work_admn_tbl a, rws_work_School_lnk_tbl b where a.work_id=b.work_id and a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st66=conn.createStatement();
	ResultSet r66=st66.executeQuery(qry66);
    System.out.println("qry66"+qry66);
	Hashtable list66=new Hashtable();
	while(r66.next())
	{
	list66.put(r66.getString(1)+r66.getString(2),r66.getString(3));
	}
	if(r66 != null)
	{
		r66.close();
	}
	if(st66 != null)
	{
		st66.close();
	}



    String qry55="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(*) from rws_work_admn_tbl a, rws_work_completion_tbl b where substr(a.work_id,7,2)='11' and a.work_id=b.work_id and  a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy') and b.date_of_completion is not null and b.date_of_completion>=to_date('1-APR-"+fy+"','dd-MON-yyyy') and b.date_of_completion<=to_date('31-MAR-"+fy1+"','dd-MON-yyyy')  group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st55=conn.createStatement();
	ResultSet r55=st55.executeQuery(qry55);
    System.out.println("qry55"+qry55);
	Hashtable list55=new Hashtable();
	while(r55.next())
	{
	list55.put(r55.getString(1)+r55.getString(2),r55.getString(3));
	}
	if(r55 != null)
	{
		r55.close();
	}
	if(st55 != null)
	{
		st55.close();
	}


    String qry44="select  substr(a.office_code,2,2),substr(a.office_code,4,1),nvl(sum(voucher_amt),0) from rws_work_admn_tbl a,rws_work_exp_voucher_tbl b where substr(a.work_id,7,2)='11' and a.work_id=b.work_id and  a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy') and b.VOUCHER_DT>=to_date('1-APR-"+fy+"','dd-MON-yyyy') and  b.VOUCHER_DT<=to_date('"+today+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st44=conn.createStatement();
	ResultSet r44=st44.executeQuery(qry44);
    System.out.println("qry44"+qry44);
	Hashtable list44=new Hashtable();
	while(r44.next())
	{
	list44.put(r44.getString(1)+r44.getString(2),r44.getString(3));
	}
	if(r44 != null)
	{
		r44.close();
	}
	if(st44 != null)
	{
		st44.close();
	}
    
    String qry33="select  substr(a.office_code,2,2),substr(a.office_code,4,1),nvl(sum(voucher_amt),0) from rws_work_admn_tbl a,rws_work_exp_voucher_tbl b  where substr(a.work_id,7,2)='11' and  a.work_id=b.work_id and a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy') and b.VOUCHER_DT>=to_date('1-APR-"+fy+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st33=conn.createStatement();
	ResultSet r33=st33.executeQuery(qry33);
    System.out.println("qry33"+qry33);
	Hashtable list33=new Hashtable();
	while(r33.next())
	{
	list33.put(r33.getString(1)+r33.getString(2),r33.getString(3));
	}
	if(r33!= null)
	{
		r33.close();
	}
	if(st33 != null)
	{
		st33.close();
	}


    String qry22="select substr(office_code,2,2),substr(office_code,4,1),nvl(sum(SANCTION_AMOUNT),0) from rws_work_admn_tbl a where substr(a.work_id,7,2)='11'  and a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy')  group by substr(office_code,2,2),substr(office_code,4,1) order by substr(office_code,2,2),substr(office_code,4,1)";
	Statement st22=conn.createStatement();
	ResultSet r22=st22.executeQuery(qry22);
    System.out.println("qry22"+qry22);
	Hashtable list22=new Hashtable();
	while(r22.next())
	{
	list22.put(r22.getString(1)+r22.getString(2),r22.getString(3));
	}
	if(r22 != null)
	{
		r22.close();
	}
	if(st22 != null)
	{
		st22.close();
	}


    String qry11="select substr(office_code,2,2),substr(office_code,4,1),count(*) from rws_work_admn_tbl a where substr(a.work_id,7,2)='11' and a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy')  group by substr(office_code,2,2),substr(office_code,4,1) order by substr(office_code,2,2),substr(office_code,4,1)";
	Statement st11=conn.createStatement();
	ResultSet r11=st11.executeQuery(qry11);
    System.out.println("qry11"+qry11);
	Hashtable list11=new Hashtable();
	while(r11.next())
	{
	list11.put(r11.getString(1)+r11.getString(2),r11.getString(3));
	}
	if(r11 != null)
	{
		r11.close();
	}
	if(st11 != null)
	{
		st11.close();
	}

         //////////////////////////////////////new//////////////////////////////////////////
    String qry8="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(b.school_code) from rws_work_admn_tbl a, rws_work_School_lnk_tbl b where a.work_id not in (select c.work_id from rws_work_completion_tbl c ) and a.work_id=b.work_id and a.ADMIN_DATE >=to_date('1-APR-"+fy+"','dd-MON-yyyy') and a.ADMIN_DATE <=to_date('31-MAR-"+fy1+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st8=conn.createStatement();
	ResultSet r8=st8.executeQuery(qry8);
    System.out.println("qr8"+qry8);
	Hashtable list8=new Hashtable();
	while(r8.next())
	{
	list8.put(r8.getString(1)+r8.getString(2),r8.getString(3));
	}
	if(r8 != null)
	{
		r8.close();
	}
	if(st8 != null)
	{
		st8.close();
	}
     
    
    String qry7="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(b.school_code) from rws_work_admn_tbl a, rws_work_School_lnk_tbl b where a.work_id not in (select c.work_id from rws_work_completion_tbl c ) and a.work_id=b.work_id and a.ADMIN_DATE <=to_date('31-MAR-"+fy+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st7=conn.createStatement();
	ResultSet r7=st7.executeQuery(qry7);
    System.out.println("qry7"+qry7);
	Hashtable list7=new Hashtable();
	while(r7.next())
	{
	list7.put(r7.getString(1)+r7.getString(2),r7.getString(3));
	}
	if(r7 != null)
	{
		r7.close();
	}
	if(st7 != null)
	{
		st7.close();
	}

   
    String qry6="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(b.school_code) from rws_work_admn_tbl a, rws_work_School_lnk_tbl b where a.work_id not in (select c.work_id from rws_work_completion_tbl c ) and a.work_id=b.work_id  group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st6=conn.createStatement();
	ResultSet r6=st6.executeQuery(qry6);
    System.out.println("qry6"+qry6);
	Hashtable list6=new Hashtable();
	while(r6.next())
	{
	list6.put(r6.getString(1)+r6.getString(2),r6.getString(3));
	}
	if(r6 != null)
	{
		r6.close();
	}
	if(st6 != null)
	{
		st6.close();
	}
        
    String qry5="select substr(a.office_code,2,2),substr(a.office_code,4,1),count(*) from rws_work_admn_tbl a, rws_work_completion_tbl b where substr(a.work_id,7,2)='11' and a.work_id=b.work_id and b.date_of_completion is not null and b.date_of_completion>=to_date('1-APR-"+fy+"','dd-MON-yyyy') and b.date_of_completion<=to_date('31-MAR-"+fy1+"','dd-MON-yyyy')  group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st5=conn.createStatement();
	ResultSet r5=st5.executeQuery(qry5);
    System.out.println("qry5"+qry5);
	Hashtable list5=new Hashtable();
	while(r5.next())
	{
	list5.put(r5.getString(1)+r5.getString(2),r5.getString(3));
	}
	if(r5 != null)
	{
		r5.close();
	}
	if(st5 != null)
	{
		st5.close();
	}

    String qry4="select  substr(a.office_code,2,2),substr(a.office_code,4,1),nvl(sum(voucher_amt),0) from rws_work_admn_tbl a,rws_work_exp_voucher_tbl b where substr(a.work_id,7,2)='11' and a.work_id not in (select c.work_id from  rws_work_completion_tbl c ) and a.work_id=b.work_id and b.VOUCHER_DT>=to_date('1-APR-"+fy+"','dd-MON-yyyy') and  b.VOUCHER_DT<=to_date('31-MAR-"+fy1+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st4=conn.createStatement();
	ResultSet r4=st4.executeQuery(qry4);
    System.out.println("qry4"+qry4);
	Hashtable list4=new Hashtable();
	while(r4.next())
	{
	list4.put(r4.getString(1)+r4.getString(2),r4.getString(3));
	}
	if(r4 != null)
	{
		r4.close();
	}
	if(st4 != null)
	{
		st4.close();
	}

    String qry3="select  substr(a.office_code,2,2),substr(a.office_code,4,1),nvl(sum(voucher_amt),0) from rws_work_admn_tbl a,rws_work_exp_voucher_tbl b  where substr(a.work_id,7,2)='11' and a.work_id not in (select c.work_id from rws_work_completion_tbl c) and a.work_id=b.work_id and b.VOUCHER_DT<=to_date('31-MAR-"+fy+"','dd-MON-yyyy') group by substr(a.office_code,2,2),substr(a.office_code,4,1) order by substr(a.office_code,2,2),substr(a.office_code,4,1)";
	Statement st3=conn.createStatement();
	ResultSet r3=st3.executeQuery(qry3);
    System.out.println("qry3"+qry3);
	Hashtable list3=new Hashtable();
	while(r3.next())
	{
	list3.put(r3.getString(1)+r3.getString(2),r3.getString(3));
	}
	if(r3 != null)
	{
		r3.close();
	}
	if(st3 != null)
	{
		st3.close();
	}

  
	String qry2="select substr(office_code,2,2),substr(office_code,4,1),nvl(sum(SANCTION_AMOUNT),0) from rws_work_admn_tbl a where substr(a.work_id,7,2)='11' and a.work_id not in (select b.work_id from rws_work_completion_tbl b ) group by substr(office_code,2,2),substr(office_code,4,1) order by substr(office_code,2,2),substr(office_code,4,1)";
	Statement st2=conn.createStatement();
	ResultSet r2=st2.executeQuery(qry2);
    System.out.println("qry2"+qry2);
	Hashtable list2=new Hashtable();
	while(r2.next())
	{
	list2.put(r2.getString(1)+r2.getString(2),r2.getString(3));
	}
	if(r2 != null)
	{
		r2.close();
	}
	if(st2 != null)
	{
		st2.close();
	}


   
	String qry1="select substr(office_code,2,2),substr(office_code,4,1),count(*) from rws_work_admn_tbl a where substr(a.work_id,7,2)='11' and a.work_id not in (select b.work_id from rws_work_completion_tbl b ) group by substr(office_code,2,2),substr(office_code,4,1) order by substr(office_code,2,2),substr(office_code,4,1)";
	Statement st1=conn.createStatement();
	ResultSet r1=st1.executeQuery(qry1);
    System.out.println("qry1"+qry1);
	Hashtable list1=new Hashtable();
	while(r1.next())
	{
	list1.put(r1.getString(1)+r1.getString(2),r1.getString(3));
	}
	if(r1 != null)
	{
		r1.close();
	}
	if(st1 != null)
	{
		st1.close();
	}


         String query= "select a.circle_office_code,a.circle_office_name,b.division_office_code, b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code";
		 query+=" order by circle_office_name ";           
		 stmt=conn.createStatement();
		 rs=stmt.executeQuery(query);
         System.out.println("main qry:"+query);
         while(rs.next())
		    {  
               gtxidValue =rs.getString(2);
            
	           habcount=""+list1.get(rs.getString(1)+rs.getString(3));
			   if(habcount!=null && !habcount.equals("") && !habcount.equals("null"))
               {
               }
               else
               {
                 habcount="0";
               }

	           est_cost=""+list2.get(rs.getString(1)+rs.getString(3));
			   if(est_cost!=null && !est_cost.equals("") && !est_cost.equals("null"))
               {
               }
               else
               {
                 est_cost="0";
               }

               exp_cost=""+list3.get(rs.getString(1)+rs.getString(3));
			   if(exp_cost!=null && !exp_cost.equals("") && !exp_cost.equals("null"))
               {
               }
               else
               {
                 exp_cost="0";
               }

               exp_during=""+list4.get(rs.getString(1)+rs.getString(3));
			   if(exp_during!=null && !exp_during.equals("") && !exp_during.equals("null"))
               {
               }
               else
               {
                 exp_during="0";
               }

               works_during=""+list5.get(rs.getString(1)+rs.getString(3));
			   if(works_during!=null && !works_during.equals("") && !works_during.equals("null"))
               {
               }
               else
               {
                 works_during="0";
               }
               
               schools_san=""+list6.get(rs.getString(1)+rs.getString(3));
			   if(schools_san!=null && !schools_san.equals("") && !schools_san.equals("null"))
               {
               }
               else
               {
                 schools_san="0";
               }


               schools_san_till=""+list7.get(rs.getString(1)+rs.getString(3));
			   if(schools_san_till!=null && !schools_san_till.equals("") && !schools_san_till.equals("null"))
               {
               }
               else
               {
                 schools_san_till="0";
               }

               schools_san_finyear=""+list8.get(rs.getString(1)+rs.getString(3));
			   if(schools_san_finyear!=null && !schools_san_finyear.equals("") && !schools_san_finyear.equals("null"))
               {
               }
               else
               {
                 schools_san_finyear="0";
               }
            //////////////////////////////////new/////////////////////////////////////////////////////////////////
             new_habcount=""+list11.get(rs.getString(1)+rs.getString(3));
			   if(new_habcount!=null && !new_habcount.equals("") && !new_habcount.equals("null"))
               {
               }
               else
               {
                 new_habcount="0";
               }
           
              new_est_cost=""+list22.get(rs.getString(1)+rs.getString(3));
			   if(new_est_cost!=null && !new_est_cost.equals("") && !new_est_cost.equals("null"))
               {
               }
               else
               {
                 new_est_cost="0";
               }

			   new_exp_cost=""+list33.get(rs.getString(1)+rs.getString(3));
			   if(new_exp_cost!=null && !new_exp_cost.equals("") && !new_exp_cost.equals("null"))
               {
               }
               else
               {
                 new_exp_cost="0";
               }

               new_exp_during=""+list44.get(rs.getString(1)+rs.getString(3));
			   if(new_exp_during!=null && !new_exp_during.equals("") && !new_exp_during.equals("null"))
               {
               }
               else
               {
                 new_exp_during="0";
               }
              
               new_works_during=""+list55.get(rs.getString(1)+rs.getString(3));
			   if(new_works_during!=null && !new_works_during.equals("") && !new_works_during.equals("null"))
               {
               }
               else
               {
                 new_works_during="0";
               }
                
               new_schools_san=""+list66.get(rs.getString(1)+rs.getString(3));
			   if(new_schools_san!=null && !new_schools_san.equals("") && !new_schools_san.equals("null"))
               {
               }
               else
               {
                 new_schools_san="0";
               }
               
               new_schools_san_till=""+list77.get(rs.getString(1)+rs.getString(3));
			   if(new_schools_san_till!=null && !new_schools_san_till.equals("") && !new_schools_san_till.equals("null"))
               {
               }
               else
               {
                 new_schools_san_till="0";
               } 

               new_schools_san_finyear=""+list88.get(rs.getString(1)+rs.getString(3));
			   if(new_schools_san_finyear!=null && !new_schools_san_finyear.equals("") && !new_schools_san_finyear.equals("null"))
               {
               }
               else
               {
                 new_schools_san_finyear="0";
               }
	       %>
	          <tr align=center  align=center>
              
              <%
					if(!gtxidValue.equals(gtxidValueOld)){
              %>
                <td class=rptValue align="left" ><%=count++ %></td> 
				<td class=rptValue align="left" bgcolor="lightgray"><%=rs.getString(2) %></td>
                <%}
                else
				{%><td class=rptValue align="left"></td>
                   <td class=rptValue align="left"></td>
                <%}
                 %>
				<td class=rptValue  align="left" bgcolor="lightyellow"><%=rs.getString(4) %></td>
				<td class=rptValue align="right"><%=habcount %></td>
               <% double col5=Double.parseDouble(est_cost);
                  double col6=Double.parseDouble(exp_cost)/100000;
                  col7=(col5-col6);
                  double col8=Double.parseDouble(exp_during)/100000;
                  int col12=Integer.parseInt(schools_san)-Integer.parseInt(schools_san_till);
                %>
				<td class=rptValue align="right"><%=ndf.format(col5)%></td>
                <td class=rptValue align="right"><%=ndf.format(col6)%></td>
				<td class=rptValue align="right"><%=ndf.format(col7) %></td>	
				<td class=rptValue align="right"><%=ndf.format(col8) %></td>	
				<td class=rptValue align="right"><%=works_during %></td>	
				<td class=rptValue align="right"><%=schools_san%></td>
				<td class=rptValue align="right"><%=schools_san_till%></td>
				<td class=rptValue align="right"><%=col12 %></td>	
				<td class=rptValue align="right"><%=schools_san_finyear %></td>	
                <% double new_col5=Double.parseDouble(new_est_cost);
 				   double new_col6=Double.parseDouble(new_exp_cost)/100000;
				   new_col7=(new_col5-new_col6);
                   double new_col8=Double.parseDouble(new_exp_during)/100000;
                   int new_col12=Integer.parseInt(new_schools_san)-Integer.parseInt(new_schools_san_till);
                %>




				<td class=rptValue align="right"><%=new_habcount%></td>
                <td class=rptValue align="right"><%=ndf.format(new_col5)%></td>
				<td class=rptValue align="right"><%=ndf.format(new_col6)%></td>	
				<td class=rptValue align="right"><%=ndf.format(new_col7)%></td>	
				<td class=rptValue align="right"><%=ndf.format(new_col8) %></td>	
				<td class=rptValue align="right"><%=new_works_during %></td>
				<td class=rptValue align="right"><%=new_schools_san %></td>
				<td class=rptValue align="right"><%=new_schools_san_till %></td>	
				<td class=rptValue align="right"><%=new_col12 %></td>	
				<td class=rptValue align="right"><%=new_schools_san_finyear %></td>	
				
		     </tr>
          <% 
           
	 gtxidValueOld = gtxidValue;
     habtot+=Integer.parseInt(habcount);
	 est_tot+=Double.parseDouble(est_cost);
     exp_tot+=Double.parseDouble(exp_cost)/100000;
     col7_tot+=col7;
     col8_tot+=col8;
     works_during_tot+=Integer.parseInt(works_during);
     schools_san_tot+=Integer.parseInt(schools_san);
     schools_san_till_tot+=Integer.parseInt(schools_san_till);
     col12_tot+=col12;
     schools_san_finyear_tot+=Integer.parseInt(schools_san_finyear);
         ////////////////new//////////////////////////
     new_habtot+=Integer.parseInt(new_habcount);
     new_est_tot+=Double.parseDouble(new_est_cost);
     new_exp_tot+=Double.parseDouble(new_exp_cost)/100000;
     new_col7_tot+=new_col7;
     new_col8_tot+=new_col8;
     new_works_during_tot+=Integer.parseInt(new_works_during);
     new_schools_san_tot+=Integer.parseInt(new_schools_san);
     new_schools_san_till_tot+=Integer.parseInt(new_schools_san_till);
     new_col12_tot+=new_col12;
     new_schools_san_finyear_tot+=Integer.parseInt(new_schools_san_finyear);
   }
	 	 
		  %>
      <tr align=center  align=center>
				<td class=btext align="center" colspan=3>Total</td>
				<td class=btext  align="right"><%=habtot %></td>
				<td class=btext align="right"><%=ndf.format(est_tot) %></td>
				<td class=btext align="right"><%=ndf.format(exp_tot) %></td>
				<td class=btext align="right"><%=ndf.format(col7_tot) %></td>
				<td class=btext align="right"><%=ndf.format(col8_tot) %></td>	
				<td class=btext align="right"><%=works_during_tot%></td>	
				<td class=btext align="right"><%=schools_san_tot %></td>	
				<td class=btext align="right"><%=schools_san_till_tot%></td>
				<td class=btext align="right"><%=col12_tot %></td>
				<td class=btext align="right"><%=schools_san_finyear_tot %></td>	
				<td class=btext align="right"><%=new_habtot %></td>
                <td class=btext align="right"><%=ndf.format(new_est_tot) %></td>
				<td class=btext align="right"><%=ndf.format(new_exp_tot) %></td>	
				<td class=btext align="right"><%=ndf.format(new_col7_tot) %></td>	
				<td class=btext align="right"><%=ndf.format(new_col8_tot) %></td>	
				<td class=btext align="right"><%=new_works_during_tot %></td>
				<td class=btext align="right"><%=new_schools_san_tot %></td>
				<td class=btext align="right"><%=new_schools_san_till_tot %></td>	
				<td class=btext align="right"><%=new_col12_tot %></td>	
				<td class=btext align="right"><%=new_schools_san_finyear_tot %></td>		
		     </tr>
		    <%
      
		
  }    
	
     catch(Exception e)
	   {
	    System.out.println("exception in waterqtly report:");
        e.printStackTrace();
	   }
	  
	   %>




</table>

<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
<%@ include file="/commons/rws_footer.jsp" %>