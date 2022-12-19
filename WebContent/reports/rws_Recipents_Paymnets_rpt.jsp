<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.util.*" %>
<%
Statement stmt1=null,vstmt=null,vstmt1=null,astmt=null;
ResultSet rs1=null,vrs=null,vrs1=null,ars=null;
 String dcode=request.getParameter("district");
 String divcode=request.getParameter("division");
 String year=request.getParameter("finyear");
 String dname=request.getParameter("dname");
 String divname=request.getParameter("divname");
  String yname=request.getParameter("yname");
nic.watersoft.fundAccounting.Rws_BroData data=new nic.watersoft.fundAccounting.Rws_BroData();
%>

<table border = 0 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
		 <tr>
			<td align="right" class="bwborder">
			<a href="javascript:onclick=history.go(-1)">Back</a> | <a href="../home.jsp">Home</a>|<a href="javascript:window.print()">Print</td> 
			</tr>
		</table>
</caption>
<tr><td class=btext align="center">District :<%=dname%>&nbsp;&nbsp;&nbsp;Division:<%=divname%>&nbsp;&nbsp;&nbsp;Financial Year:<%=yname%></td></tr>
<table border = 1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr><td colspan=2 class=btext align="center">Receipts Vs Payments Report</td></tr>
<td width="50%" valign=top>

<!-- Table on left side -->
<table border = 1 cellspacing = 0 cellpadding = 0  width=100%   style="border-collapse:collapse" bgcolor="#ffffff">
<tr><td class=btext colspan="4" align="center">Receipts</td>
<tr>
<td class=btext align="center">Sl.No</td>
<td class=btext align="center">Date</td>
<td class=btext align="center">Particulars</td>
<td class=btext align="center" nowrap>Amount &nbsp; &nbsp;<br>(in Rupees)</td>
</tr>
<%
Hashtable ht=new Hashtable();
String ary=" select distinct head_of_account from rws_bro_details_tbl ";
astmt=conn.createStatement();
ars=astmt.executeQuery(ary);
while(ars.next())
{
	//System.out.println("code:"+ars.getString(1).substring(0,4));
	String mh=data.getMajorHeadName(ars.getString(1).substring(0,4));
	//System.out.println("mh:"+mh);
		 String smh="->",mih="->",gph="->",sh="->",dh="->",sdh="->";
		if(ars.getString(1).length()>=7 && ars.getString(1).substring(5,7)!=null && !ars.getString(1).substring(5,7).equals("--"))
		    		{
					 smh=data.getSubMajorHeadName(ars.getString(1).substring(0,4),ars.getString(1).substring(5,7));
		    		}
					if(ars.getString(1).length()>=11 && ars.getString(1).substring(8,11)!=null && !ars.getString(1).substring(8,11).equals("---"))
					{
						mih=data.getMinorHeadName(ars.getString(1).substring(0,4),ars.getString(1).substring(5,7),ars.getString(1).substring(8,11));
		    		}
					if(ars.getString(1).length()>=14 && ars.getString(1).substring(12,14)!=null && !ars.getString(1).substring(12,14).equals("--"))
					{
						gph=data.getGrpSubHeadName(ars.getString(1).substring(0,4),ars.getString(1).substring(5,7),ars.getString(1).substring(8,11),ars.getString(1).substring(12,14));
		    		}
					if(ars.getString(1).length()>=17 && ars.getString(1).substring(15,17)!=null && !ars.getString(1).substring(15,17).equals("--"))
	    			{
						 sh=data.getSubHeadName(ars.getString(1).substring(0,4),ars.getString(1).substring(5,7),ars.getString(1).substring(8,11),ars.getString(1).substring(12,14),ars.getString(1).substring(15,17));
		    		}
					if(ars.getString(1).length()>=21 && ars.getString(1).substring(18,21)!=null && !ars.getString(1).substring(18,21).equals("---"))
	    			{
						 dh=data.getDetailedHeadName(ars.getString(1).substring(0,4),ars.getString(1).substring(5,7),ars.getString(1).substring(8,11),ars.getString(1).substring(12,14),ars.getString(1).substring(15,17),ars.getString(1).substring(18,21));
		    		}
					if(ars.getString(1).length()>=25 && ars.getString(1).substring(22,25)!=null && !ars.getString(1).substring(22,25).equals("---"))
	    			{
						 sdh=data.getSubDetailedHeadName(ars.getString(1).substring(0,4),ars.getString(1).substring(5,7),ars.getString(1).substring(8,11),ars.getString(1).substring(12,14),ars.getString(1).substring(15,17),ars.getString(1).substring(18,21),ars.getString(1).substring(22,25));
		    		}

		ht.put(ars.getString(1),mh+"->"+smh+"->"+mih+"->"+gph+"->"+sh+"->"+dh+"->"+sdh);
		//System.out.println("HOA:"+mh+"-"+smh+"-"+mih+"-"+gph+"-"+sh+"-"+dh+"-"+sdh);
}


long ramt=0,pamt=0;
int rcount=0;
String qry1="select distinct to_char(loc_date,'dd/mm/yyyy'), loc_date from rws_loc_details_tbl a,rws_bro_master_tbl b where a.bro_id=b.bro_id and district_code='"+dcode+"' and substr(office_to_code,4,1)='"+divcode+"' and fin_year='"+year+"'  order by loc_date ";
stmt1=conn.createStatement();
//System.out.println("bill dates:"+qry1);
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{
	String qry="select distinct Loc_id,a.bro_id,head_of_account,loc_amount*100000,programme_name,subprogramme_name  from rws_loc_details_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s  where a.programme_code=p.programme_code and  a.programme_code=s.programme_code and p.programme_code=s.programme_code and a.subprogramme_code =s.subprogramme_code and   to_char(loc_date,'dd/mm/yyyy')='"+rs1.getString(1)+"' and substr(office_to_code,2,3)='"+dcode+divcode+"' ";
	//System.out.println("sssssssssssssss:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	String dt=rs1.getString(1);
	while(rs.next())
	{
		String hoa=""+ht.get(rs.getString(3)); 
		String hoa1[]=hoa.split("->");
		//System.out.println("hoa:"+hoa);
		%>
	  
	<tr>
		<td align="center"><font color="black" face="verdana" size=1><%=++rcount%></font></td>
		<%if(dt.equals(rs1.getString(1))) {%>
		<td><font color="black" face="verdana" size=1><%=rs1.getString(1)%></font></td>
		<%} else {%>
		<td></td>
		<%}
	   dt="";
	 %>
	<td nowrap><font color="blue" face="verdana" size=2>Bro Id:&nbsp;<font color="black" face="verdana" size=1><%=rs.getString(2)%></font><br>
	Loc Id:&nbsp;<font color="black" face="verdana" size=1><%=rs.getString(1)%></font><br>Head of Account:&nbsp;
	<% for (int i=0; i<hoa1.length; i++) {%>
	<font color="black" face="verdana" size=1><%=hoa1[i]%></font>
	<%if(i<hoa1.length-1){%>&raquo;<%}%><br><%}%>
	Program:&nbsp;<font color="black" face="verdana" size=1><%=rs.getString(5)%></font><br>
	SubProgram:&nbsp;<font color="black" face="verdana" size=1><%=rs.getString(6)%></font></td>
	<td align="right"><font color="black" face="verdana" size=1><%=rs.getString(4)%></font></td>
	</tr>
	<%
	ramt+=(new Double(rs.getString(4))).longValue();
	 
	 }

 System.out.println("Rmt"+ramt);

}%>

</table>
<!-- END -->
</td>

<td width="50%"  valign=top>

<!-- Table on right side -->
<table border = 1 cellspacing = 0 cellpadding = 0  width=100%  style="border-collapse:collapse" bgcolor="#ffffff">
<tr><td class=btext colspan="4" align="center">Payments</td></tr>
<tr>
<td class=btext align="center">Sl.No</td>
<td class=btext align="center">Date</td>
<td class=btext align="center">Particulars</td>
<td class=btext align="center" nowrap>Amount &nbsp; &nbsp;<br>(in Rupess)</td>
</tr>
<% int pcount=0;
String vqry="SELECT DISTINCT to_char(voucher_dt,'dd/mm/yyyy') as v1 from  rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c  where a.work_id=b.work_id  and a.work_id=c.work_id  and b.work_id=c.work_id and substr(a.work_id,5,2)='"+dcode+"'  and substr(office_code,4,1)='"+divcode+"' and  VOUCHER_DT <='31/MAR/"+year.substring(5)+"' and VOUCHER_DT >='01/APR/"+year.substring(0,4)+"' and a.bill_sl_no<>'0' order by substr(v1,9,10) desc,substr(v1,4,2) desc, substr(v1,1,2) desc";
//select distinct to_char(voucher_dt,'dd/mm/yyyy') from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c  where a.work_id=b.work_id  and a.work_id=c.work_id  and b.work_id=c.work_id and substr(a.work_id,5,2)='"+dcode+"'  and substr(office_code,4,1)='"+divcode+"' and VOUCHER_DT <='31/MAR/"+year.substring(5)+"' and VOUCHER_DT >='01/APR/"+year.substring(0,4)+"' and a.bill_sl_no<>'0' order by to_char(voucher_dt,'dd/mm/yyyy')  desc";
System.out.println("achuta:"+vqry);
//String vqry="select distinct to_char(voucher_dt,'dd/mm/yyyy') from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c  where a.work_id=b.work_id  and a.work_id=c.work_id  and b.work_id=c.work_id and substr(a.work_id,5,2)='"+dcode+"'  and substr(office_code,4,1)='"+divcode+"' and  bill_date >='01/APR/"+year.substring(0,4)+"'  and   bill_date <='31/MAR/"+year.substring(5)+"'  and a.bill_sl_no<>'0' order by to_char(voucher_dt,'dd/mm/yyyy')  desc";
//System.out.println("vqry11111:"+vqry);
vstmt=conn.createStatement();
vstmt1=conn.createStatement();
vrs=vstmt.executeQuery(vqry);
while(vrs.next())
{
   String vqry1=" select  voucher_no,voucher_amt,mbook_no,a.work_id,work_name,bill_no  from   rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id  and  a.work_id=c.work_id  and   b.work_id=c.work_id  and  a.bill_sl_no=b.bill_sl_no and  a.bill_sl_no<>'0' and  to_char(voucher_dt,'dd/mm/yyyy')='"+vrs.getString(1)+"' and substr(a.work_id,5,2)='"+dcode+"' and substr(office_code,4,1)='"+divcode+"' ";
  System.out.println("vqry1:"+vqry1);
   vrs1=vstmt1.executeQuery(vqry1);
   while(vrs1.next())
	{%>
	<tr>
	<td align="center"><font color="black" face="verdana" size=1><%=++pcount%></td>
	<td align="center"><font color="black" face="verdana" size=1><%=vrs.getString(1)%></td>
	<td  nowrap><font color="blue" face="verdana" size=2>Voucher No:&nbsp;<font color="black" face="verdana" size=1><%=vrs1.getString(1)%></font><br><font color="blue" face="verdana" size=2>MBook No:&nbsp;<font color="black" face="verdana" size=1><%=vrs1.getString(3)%></font><br><font color="blue" face="verdana" size=2>Work Id:&nbsp;<font color="black" face="verdana" size=1><%=vrs1.getString(4)%></font><br>
	<font color="blue" face="verdana" size=2>Work Name:&nbsp;<font color="black" face="verdana" size=1><%=vrs1.getString(5)%></font><br>
	<font color="blue" face="verdana" size=2>Bill No:&nbsp;<font color="black" face="verdana" size=1><%=vrs1.getString(6)%></font></td>
       <td align="right"><font color="black" face="verdana" size=1><%=vrs1.getString(2)%></td>  
	<%
	   
   pamt+=(new Double(vrs1.getString(2))).longValue();
   }
 System.out.println("pamt"+pamt);
%>

</tr>
<%}


%>

</table>
<!-- END -->
<tr colspan=2>
<td class=btext align=right>Total  :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ramt%> </td>
<td class=btext  align=right>Total :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=pamt%></td>
</tr>
<%if(ramt > pamt){%>
<tr>
<td class=btext align="right" colspan=2>By Balance(c/f): <%= ramt-pamt %></td></tr>
<%}else if(ramt < pamt) {%>
<td class=btext align="left" colspan=2>To Balance: <%= pamt-ramt %></td></tr>
<%}%>


</table>  









