<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%
Statement stmt8=null,stmt131=null;
Statement st1=null;
ResultSet rs1=null;
double qty=0.0;
int noofhabs=0;
int c1=0,c2=0,c3=0,c4=0;
ResultSet rs8=null,rs131=null;
ResultSet rssh=null;
Statement stsh=null;
int counter=0;
int sno=1;
int gtnHabs=0,gtPopServed=0;
double gTransqty=0;
int ghnHabs=0,ghPopServed=0, gHnSources=0;
int gpowerTot=0,gPowerProblem=0,tothrhabs=0,tothrsources=0,tothrppopulation=0,totpwhabs=0,tothabsall=0;

//String qry="";
//String a1="",a2="",a3="",a4="",a5="",a6="",a7="",a8="";
//String s3="",s1="",s2="";

StringBuffer query=new StringBuffer();
StringBuffer a1=new StringBuffer();
StringBuffer a2=new StringBuffer();
StringBuffer a3=new StringBuffer();
StringBuffer a4=new StringBuffer();
StringBuffer a5=new StringBuffer();
StringBuffer a6=new StringBuffer();
StringBuffer a7=new StringBuffer();

StringBuffer a8=new StringBuffer();
StringBuffer a9=new StringBuffer();
StringBuffer a10=new StringBuffer();
StringBuffer a11=new StringBuffer();
StringBuffer a12=new StringBuffer();
StringBuffer a13=new StringBuffer();

StringBuffer s1=new StringBuffer();
StringBuffer s2=new StringBuffer();
StringBuffer s3=new StringBuffer();

    
    
	   // String habtype=(String)session.getAttribute("habtype");
	   StringBuffer habtype=new StringBuffer();
	habtype.append(session.getAttribute("habtype"));



	//System.out.println("habtype:"+habtype);

	%>
     <%if(habtype.toString() !=null && habtype.toString().equals("0"))
     {
    //String ddate=(String)session.getAttribute("ddate");
     StringBuffer ddate=new StringBuffer();
       ddate.delete(0,ddate.length());
      ddate.append(session.getAttribute("ddate"));
    //System.out.println("ddate"+ddate);
    //
    DecimalFormat ndf = new DecimalFormat("######.##");
	
Format formatter4;

int dayrr=Integer.parseInt(ddate.toString().substring(0,2));
int month3=Integer.parseInt(ddate.toString().substring(3,5));
int year3=Integer.parseInt(ddate.toString().substring(6,10));
java.util.Date date4 = new java.util.Date(year3-1900,month3-1,dayrr);
formatter4 = new SimpleDateFormat("dd/MMM/yyyy");
ddate.delete(0,ddate.length());
ddate.append(formatter4.format(date4));

 %>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=10> Abstract of Daily Report on Drinking Water Situation ( Drought ) - Report</td>
	</tr>
	<tr  align="center">
	<td align="center" class="rptHeading" colspan=10> Date :<font color=red><%=ddate%></font></td>
	</tr>
	
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext   align=center rowspan=3>Sl.No</td>
    <td class=btext   align=center rowspan=3>District</td>
    <td class=btext   align="center" colspan=8>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Transportation</td>
	<td class=btext   align=center colspan=3>&nbsp;&nbsp;Hiring&nbsp;of&nbsp;Private&nbsp;Sources</td>
    <td class=btext   align=center >Power Problem<br>( Low Voltage )</td>
	<td class=btext   align=center >Total</td>
	</tr>
	<tr>
	<td class=btext align=center colspan=4>Human Population</td>
	<td class=btext align=center colspan=4>Live Stock (Cattle)</td>
	<td class=btext align=center rowspan=2>No. Of Habs.</td>
	<td class=btext align=center rowspan=2>No. Of Sources</td>
    <td class=btext align=center rowspan=2>Population Served</td>
	<td class=btext align=center rowspan=2>No. Of Habs.</td>
	<td class=btext align=center rowspan=2>No. Of Habs.</td>
	</tr>
	
	<tr>
	  <td class=btext align=center>No.of.Habs</td>
		<td class=btext align=center>Population Served</td>
		<td class=btext align=center>No.of Tanker Trips</td>
		<td class=btext align=center>Quantity(KL)</td>
		<td class=btext align=center>No.of.Habs</td>
		<td class=btext align=center>Population Served</td>
		<td class=btext align=center>No.of Tanker Trips</td>
		<td class=btext align=center>Quantity(KL)</td>
	</tr>
    <%
	//tablename: rws_drought_con_tr_hir_tbl;

    StringBuffer aw=new StringBuffer();
	try
	
		{
		query.delete(0,query.length());
		query.append("select to_char(DR_DATE,'dd/MON/yyyy'),nvl(NO_OF_HABS_TR,0),nvl(POP_SERVED_TR,0),nvl(HUMAN_TANKER_TRIPS,0),nvl(QTY_TR,0),nvl(NO_OF_HABS_CAT,0),nvl(POP_SERVED_CAT,0),nvl(CATTLE_TANKER_TRIPS,0),nvl(QTY_CAT,0),nvl(NO_OF_HABS_HR,0),nvl(NO_OF_SOURCES,0),nvl(POP_SERVED_HR,0),nvl(NO_OF_HABS_POW,0),DCODE   from  rws_drought_con_tr_hir_tbl where dr_date=to_date('"+ddate+"','dd/Mon/yyyy')");
 
		Statement	stsh1=conn.createStatement();
	//System.out.println("asset:"+asset);
		ResultSet rssh1=stsh1.executeQuery(query.toString());
	Hashtable shh=new Hashtable();
	while(rssh1.next())
	{
		shh.put(rssh1.getString(14),rssh1.getString(1)+"#"+rssh1.getString(2)+"#"+rssh1.getString(3)+"#"+rssh1.getString(4)+"#"+rssh1.getString(5)+"#"+rssh1.getString(6)+"#"+rssh1.getString(7)+"#"+rssh1.getString(8)+"#"+rssh1.getString(9)+"#"+rssh1.getString(10)+"#"+rssh1.getString(11)+"#"+rssh1.getString(12)+"#"+rssh1.getString(13));
	}
	if(rssh1 != null)
	{
		rssh1.close();
	}
	if(stsh1 != null)
	{
		stsh1.close();
	}
		st1=conn.createStatement();
		query.delete(0,query.length());
	    query.append("select dcode,dname from rws_district_tbl where dcode<>'16' order by dname");
	
	rs1=st1.executeQuery(query.toString());
	while(rs1.next())
	{
		aw.delete(0,aw.length());
		//aw.append(String.valueOf(shh.get(rs1.getString(1))));
		aw.append(shh.get(rs1.getString(1)));
		
		
	if(aw.toString()!=null && !aw.toString().equals("") && !aw.toString().equals("null"))
	{
		String []awh=aw.toString().split("#");
		a1.delete(0,a1.length());
	    a1.append(awh[0]);
	    
	    a2.delete(0,a2.length());
	    a2.append(awh[1]);
	    
	    a3.delete(0,a3.length());
		a3.append(awh[2]);
		
		a4.delete(0,a4.length());
	    a4.append(awh[3]);
	    
	    a5.delete(0,a5.length());
		a5.append(awh[4]);
		
		a6.delete(0,a6.length());
		a6.append(awh[5]);
		
		a7.delete(0,a7.length());
		a7.append(awh[6]);
		
		a8.delete(0,a8.length());
		a8.append(awh[7]);
		
		a9.delete(0,a9.length());
		a9.append(awh[8]);
	    
		a10.delete(0,a10.length());
		a10.append(awh[9]);
		
		a11.delete(0,a11.length());
		a11.append(awh[10]);
		
		a12.delete(0,a12.length());
		a12.append(awh[11]);
		
		a13.delete(0,a13.length());
		a13.append(awh[12]);
	     
     
	}
	else{
		a1.delete(0,a1.length());
		a1.append("-");
		
		a2.delete(0,a2.length());
		a2.append("0");
		
		a3.delete(0,a3.length());
		a3.append("0");
		
		a4.delete(0,a4.length());
	    a4.append("0");
	    
	    a5.delete(0,a5.length());
		a5.append("0");
		
		a6.delete(0,a6.length());
		a6.append("0");
		
		a7.delete(0,a7.length());
		a7.append("0");
		
		a8.delete(0,a8.length());
		a8.append("0");
		
		
		a9.delete(0,a9.length());
		a9.append("0");
	    
		a10.delete(0,a10.length());
		a10.append("0");
		
		a11.delete(0,a11.length());
		a11.append("0");
		
		a12.delete(0,a12.length());
		a12.append("0");
		
		a13.delete(0,a13.length());
		a13.append("0");
	    
    
	}
	//System.out.println("a5"+a5);
    qty=Double.parseDouble(a5.toString());
    //System.out.println("qty"+qty);
 
   
    c1=Integer.parseInt(a2.toString());
   // System.out.println("c1"+c1);
    
    c3=Integer.parseInt(a10.toString());
   // System.out.println("c3"+c3);
    
    c2=Integer.parseInt(a13.toString());
  //  System.out.println("c3"+c3);
    
    noofhabs=c1+c3+c2;

   // System.out.println("noofhabs"+noofhabs);


    gtnHabs+=Integer.parseInt(a2.toString());
    gtPopServed+=Integer.parseInt(a3.toString());
    gTransqty+=qty;
    ghnHabs+=Integer.parseInt(a4.toString());
    ghPopServed+=Integer.parseInt(a7.toString());
    gHnSources+=Integer.parseInt(a6.toString());
    gPowerProblem+=Integer.parseInt(a8.toString());
    tothrhabs+=Integer.parseInt(a9.toString());
    tothrsources+=Integer.parseInt(a10.toString());

    tothrppopulation+=Integer.parseInt(a11.toString());
    totpwhabs+=Integer.parseInt(a12.toString());
    tothabsall+=Integer.parseInt(a13.toString());

    gpowerTot+=noofhabs;


   %>

	
	<tr >
    <td  class="rptValue" align=center><%=sno++%></td>
	<td class="rptValue" align=left><%=rs1.getString(2)%></td>
	<!-- <td class="rptValue"><%=a1%></td> -->
	<td class="rptValue" align=right><%=a2%></td>
	<td class="rptValue" align=right><%=a3%></td>
	<td class="rptValue" align=right><%=a4%></td>
	<td class="rptValue" align=right><%=qty%></td>
	<td class="rptValue" align=right> <%=a6%></td>
	<td class="rptValue" align=right><%=a7%></td>
	<td class="rptValue" align=right><%=a8%></td>
	
	
	<td class="rptValue" align=right><%=a9%></td>
	<td class="rptValue" align=right><%=a10%></td>
	<td class="rptValue" align=right> <%=a11%></td>
	<td class="rptValue" align=right><%=a12%></td>
	<td class="rptValue" align=right><%=a13%></td>
	
	
    	<td class="rptValue" align=right><%=noofhabs%></td>
   <tr>
   <%
   }
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
    finally
    {
    try
{
    if(rs1 != null)
    {
     rs1.close();
    }
    if(st1 !=null)
    {
    st1.close();
    }
}catch(Exception p)
{
p.printStackTrace();
}
    }
	
	%>
   <tr>
<td class=btext colspan=2 align=right>Total:</td>
<td class=btext align=right><%=gtnHabs %></td>
<td class=btext align=right><%=gtPopServed %></td>
<td class=btext align=right><%=ghnHabs%></td>
<td class=btext align=right><%=gTransqty%></td>
<td class=btext align=right><%=gHnSources %></td>
<td class=btext align=right><%=ghPopServed %></td>
<td class=btext align=right><%=gPowerProblem %>

<td class=btext align=right><%=tothrhabs %></td>
<td class=btext align=right><%=tothrsources %></td>
<td class=btext align=right><%=tothrppopulation %></td>
<td class=btext align=right><%=totpwhabs %></td>
<td class=btext align=right><%=tothabsall %></td>


</td><td class=btext align=right><%=gpowerTot %></td>
</tr>

</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>
<%}else if(habtype.toString() !=null && habtype.toString().equals("1"))
{
//String dname=(String)session.getAttribute("dname");
StringBuffer dname=new StringBuffer();
dname.append(session.getAttribute("dname"));
   

//String district=(String)session.getAttribute("district");
StringBuffer district=new StringBuffer();
district.append(session.getAttribute("district"));


//String frdate=(String)session.getAttribute("frdate");
StringBuffer frdate=new StringBuffer();
frdate.append(session.getAttribute("frdate"));
//System.out.println("fdate**********"+frdate);


//String tdate=(String)session.getAttribute("tdate");
StringBuffer tdate=new StringBuffer();
tdate.append(session.getAttribute("tdate"));


DecimalFormat ndf4 = new DecimalFormat("######.##");
	
Format formatter;

 int day=Integer.parseInt(frdate.toString().substring(0,2));
int month=Integer.parseInt(frdate.toString().substring(3,5));
int year=Integer.parseInt(frdate.toString().substring(6,10));

int day1=Integer.parseInt(tdate.toString().substring(0,2));
int month1=Integer.parseInt(tdate.toString().substring(3,5));
int year1=Integer.parseInt(tdate.toString().substring(6,10));

//
java.util.Date date = new java.util.Date(year-1900,month-1,day);
java.util.Date date1 = new java.util.Date(year1-1900,month1-1,day1);
formatter = new SimpleDateFormat("dd/MMM/yyyy");

//fromdate=fromdate.replace("/","-");
//System.out.println("f1*************"+fromdate);

		
	
	//todate=todate.replace("/","-");
//frdate=formatter.format(date);
//tdate=formatter.format(date1);
frdate.delete(0,frdate.length());
frdate.append(formatter.format(date));

tdate.delete(0,tdate.length());
tdate.append(formatter.format(date1));


////

//
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=10> Abstract of Daily Report on Drinking Water Situation ( Drought ) - Report</td>
	</tr>
	<tr  align="center">
	<td align="center" class="rptHeading" colspan=10> District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;From Date :<font color=red><%=frdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;To Date:<font color=red><%=tdate%></font><font color=red>&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	</tr>
	
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext   align=center rowspan=3>Sl.No</td>
    <td class=btext   align=center rowspan=3>District</td>
    <td class=btext   align="center" colspan=8>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Transportation</td>
	<td class=btext   align=center colspan=3>&nbsp;&nbsp;Hiring&nbsp;of&nbsp;Private&nbsp;Sources</td>
    <td class=btext   align=center >Power Problem<br>( Low Voltage )</td>
	<td class=btext   align=center >Total</td>
	</tr>
	<tr>
	<td class=btext align=center colspan=4>Human Population</td>
	<td class=btext align=center colspan=4>Live Stock (Cattle)</td>
	<td class=btext align=center rowspan=2>No. Of Habs.</td>
	<td class=btext align=center rowspan=2>No. Of Sources</td>
    <td class=btext align=center rowspan=2>Population Served</td>
	<td class=btext align=center rowspan=2>No. Of Habs.</td>
	<td class=btext align=center rowspan=2>No. Of Habs.</td>
	</tr>
	
	<tr>
	  <td class=btext align=center>No.of.Habs</td>
		<td class=btext align=center>Population Served</td>
		<td class=btext align=center>No.of Tanker Trips</td>
		<td class=btext align=center>Quantity(KL)</td>
		<td class=btext align=center>No.of.Habs</td>
		<td class=btext align=center>Population Served</td>
		<td class=btext align=center>No.of Tanker Trips</td>
		<td class=btext align=center>Quantity(KL)</td>
	</tr>
    <%
	//tablename: rws_drought_con_tr_hir_tbl;

	try
	{
/////
//
		

		stsh=conn.createStatement();
		st1=conn.createStatement();
		query.delete(0,query.length());
	    query.append("select dcode,dname from rws_district_tbl where dcode='"+district+"' order by dname");
	
	rs1=st1.executeQuery(query.toString());
	while(rs1.next())
		{
		query.delete(0,query.length());
	    query.append("select  to_char(DR_DATE,'dd/MON/yyyy'),nvl(NO_OF_HABS_TR,0),nvl(POP_SERVED_TR,0),nvl(HUMAN_TANKER_TRIPS,0),nvl(QTY_TR,0),nvl(NO_OF_HABS_CAT,0),nvl(POP_SERVED_CAT,0),nvl(CATTLE_TANKER_TRIPS,0),nvl(QTY_CAT,0),nvl(NO_OF_HABS_HR,0),nvl(NO_OF_SOURCES,0),nvl(POP_SERVED_HR,0),nvl(NO_OF_HABS_POW,0),DCODE  from  rws_drought_con_tr_hir_tbl where to_date(dr_date) >= '"+frdate+"'  and to_date(dr_date) <='"+tdate+"' and dcode='"+rs1.getString(1)+"'");
        rssh=stsh.executeQuery(query.toString());
        while(rssh.next())
	{
	
	
        	 counter=counter+1;
        	    s1.delete(0,s1.length());
        	    s1.append(rssh.getInt(2));
        	    
        	    s2.delete(0,s2.length());
        	    s2.append(rssh.getInt(10));
        	    
        	    s3.delete(0,s3.length());
        	    s3.append(rssh.getInt(13));
        	    
        	noofhabs=rssh.getInt(2)+rssh.getInt(10)+rssh.getInt(13);

        	gtnHabs+=rssh.getInt(2);
        	
        	gtPopServed+=rssh.getInt(3);
        	
        	gTransqty+=rssh.getInt(5);
        
        	ghnHabs+=rssh.getInt(4);
     
        	ghPopServed+=rssh.getInt(7);
        	
        	gHnSources+=rssh.getInt(6);
        
        	gPowerProblem+=rssh.getInt(8);
        	
        	tothrhabs+=rssh.getInt(9);
        	
        	tothrsources+=rssh.getInt(10);
        	
        	tothrppopulation+=rssh.getInt(11);
        	totpwhabs+=rssh.getInt(12);
        	tothabsall+=rssh.getInt(13);

        	gpowerTot+=noofhabs;


%>
	<tr>
    <td class="rptValue" align=center><%=sno++%></td>
	<!-- <td class="rptValue"><%=rs1.getString(2)%></td> -->
	 <td class="rptValue" align=left><%=rssh.getString(1)%></td> 
	<td class="rptValue" align=right><%=rssh.getString(2)%></td>
	<td class="rptValue" align=right><%=rssh.getString(3)%></td>
	<td class="rptValue" align=right><%=rssh.getInt(4)%></td>
	<td class="rptValue" align=right><%=rssh.getString(5)%></td>
	<td class="rptValue" align=right><%=rssh.getString(6)%></td>
	<td class="rptValue" align=right><%=rssh.getString(7)%></td>
	<td class="rptValue" align=right><%=rssh.getString(8)%></td>
	
	<td class="rptValue" align=right><%=rssh.getString(9)%></td>
	<td class="rptValue" align=right><%=rssh.getString(10)%></td>
	<td class="rptValue" align=right><%=rssh.getString(11)%></td>
	<td class="rptValue" align=right><%=rssh.getString(12)%></td>
	<td class="rptValue" align=right><%=rssh.getString(13)%></td>
	
	
   <td class="rptValue" align=right><%=noofhabs%></td>
   </tr>
   <%
   }
    
   }
   if(counter==0)
   {%>
<tr>
<td class="rptValue" align=center colspan=10>No records</td>
</tr>
<%
}else {
%>
<tr>
<td class=btext colspan=2 align=right>Total:</td>
<td class=btext align=right><%=gtnHabs %></td>
<td class=btext align=right><%=gtPopServed %></td>
<td class=btext align=right><%=ghnHabs%></td>
<td class=btext align=right><%=gTransqty%></td>
<td class=btext align=right><%=gHnSources %></td>
<td class=btext align=right><%=ghPopServed %></td>
<td class=btext align=right><%=gPowerProblem %></td>
<td class=btext align=right><%=tothrhabs %></td>
<td class=btext align=right><%=tothrsources %></td>
<td class=btext align=right><%=tothrppopulation %></td>
<td class=btext align=right><%=totpwhabs %></td>
<td class=btext align=right><%=tothabsall %></td>


<td class=btext align=right><%=gpowerTot %></td>
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
	query=null;
      a1=null;
      a2=null;
      a3=null;
      a4=null;
      a5=null;
      a6=null;
      a7=null;
      a8=null;
      s1=null;
      s2=null;
      s3=null;
      habtype=null;
      
try
{
if(rssh !=null)
{
rssh.close();
}
if(stsh != null)
{
stsh.close();
}
if(rs1 != null)
{
rs1.close();
}
if(st1 !=null)
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
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

<%} %>

  
