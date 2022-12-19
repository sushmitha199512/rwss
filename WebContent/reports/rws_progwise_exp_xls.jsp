<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%
	DecimalFormat ndf = new DecimalFormat("####.00");
	Statement st1 = null;
	ResultSet rs1 = null;
	st1 = conn.createStatement();	
%>
<table border=0  align="center">
<tr><td class=btext colspan="72">NRDWP Related Programs - Division wise Expenditure Report</td>
</tr>
<table bgcolor="#FFFFFF" bordercolor= "black" border=1 style="border-collapse:collapse"  align="center">
<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext rowspan = 3>Division</td>
</tr>
<tr> 
		<td class=btext colspan = 8 align="center" nowrap>ARWS</td>
		<td class=btext colspan = 4 align="center" nowrap>20% ARWS</td>
		<td class=btext colspan = 5 align="center" nowrap>SMP</td>
		<td class=btext colspan = 4 align="center" nowrap>BHARAT NIRMAN</td>
		<td class=btext colspan = 4 align="center" nowrap>ARWS BHARAT NIRMAN </td>
		<td class=btext colspan = 4 align="center" nowrap>ARWS (SCP)</td>
		<td class=btext colspan = 4 align="center" nowrap>NRDWP-COV</td>
		<td class=btext colspan = 4 align="center" nowrap>NRDWP-SUS</td>
        <td class=btext colspan = 4 align="center" nowrap>NRDWP-QA</td>
		<td class=btext colspan = 4 align="center" nowrap>NRDWP-DDP </td>
		<td class=btext colspan = 4 align="center" nowrap>NRDWP-CALAMITY</td>
		<td class=btext colspan = 4 align="center" nowrap>NRDWP-OANDM</td>
		<td class=btext colspan = 4 align="center" nowrap>NREGP-COV</td>
		<td class=btext colspan = 4 align="center" nowrap>NREGP-SUS</td>
		<td class=btext colspan = 4 align="center" nowrap>O AND M</td>
		<td class=btext colspan = 4 align="center" nowrap>DDP</td>
</tr>
<tr align = center>
		<td class=btext >Total</td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>
		<td class=btext>15% ARWS </td>
		<td class=btext>5% ARWS</td>
		<td class=btext>-</td>
		<td class=btext>DDF</td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>
		

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>
		<td class=btext>-</td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>

		<td class=btext >Total </td>
		<td class=btext >Plain </td>
		<td class=btext>SC </td> 
		<td class=btext>ST </td>
</tr>

<%int sno=0;
double col1=0.0,col2=0.0,col3=0.0,col4=0.0,col5=0.0,col6=0.0,col7=0.0,col8=0.0,col9=0.0,col10=0.0,
col11=0.0,col12=0.0,col13=0.0,col14=0.0,col15=0.0,col16=0.0,col17=0.0,col18=0.0,col19=0.0,col20=0.0,
col21=0.0,col22=0.0,col23=0.0,col24=0.0,col25=0.0,col26=0.0,col27=0.0,col28=0.0,col29=0.0,col30=0.0,
col31=0.0,col32=0.0,col33=0.0,col34=0.0,col35=0.0,col36=0.0,col37=0.0,col38=0.0,col39=0.0,col40=0.0,
col41=0.0,col42=0.0,col43=0.0,col44=0.0,col45=0.0,col46=0.0,col47=0.0,col48=0.0,col49=0.0,col50=0.0,
col51=0.0,col52=0.0,col53=0.0,tot1=0.0,tot2=0.0,tot3=0.0,tot4=0.0,tot5=0.0,tot6=0.0,tot7=0.0,tot8=0.0,
tot9=0.0,tot10=0.0,tot11=0.0,tot12=0.0,tot13=0.0,tot14=0.0,tot15=0.0,tot16=0.0;
String qry1="";
String code="";
String qry="select dcode,division_office_code,dname,division_office_name from rws_district_tbl d,rws_division_office_tbl div where d.dcode=div.circle_office_code order by 1,2 ";
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{%>
<tr>
<td class=rptvalue><%=++sno%></td>
<td class=rptvalue><%=rs.getString(3)%></td>
<td class=rptvalue><%=rs.getString(4)%></td>
<%
code=rs.getString(1)+rs.getString(2);

qry1="select (select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='01' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')a,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='01' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')a1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='01' and (substr(a.work_id,3,2)='03'  or substr(a.work_id,3,2)='04') and substr (b.office_code,2,3) ='"+code+"')a2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='01' and substr(a.work_id,3,2)='05'  and substr (b.office_code,2,3) ='"+code+"')a3,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='01' and substr(a.work_id,3,2)='06'  and substr (b.office_code,2,3) ='"+code+"')a4,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='02'  and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')b,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='02' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')b1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='02' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')b2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='18' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')c,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='18' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')c1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='18' and (substr(a.work_id,3,2)='03' or substr(a.work_id,3,2)='04')  and substr (b.office_code,2,3) ='"+code+"')c2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='23' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')d,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='23' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')d1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='23' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')d2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='32' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')e,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='32' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')e1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='32' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')e2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='48' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')f,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='48' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')f1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='48' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')f2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='49' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')g,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='49' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')g1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='49' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')g2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='50' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')h,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='50' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')h1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='50' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')h2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='51' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')i,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='51' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')i1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='51' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')i2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='58'  and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')j,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='58' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')j1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='58' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')j2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='59' and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"') k,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='59' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')k1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='59' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')k2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='60'  and substr(a.work_id,3,2)='01' and substr (b.office_code,2,3) ='"+code+"')l,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='60' and substr(a.work_id,3,2)='02'  and substr (b.office_code,2,3) ='"+code+"')l1,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='60' and substr(a.work_id,3,2)='03'  and substr (b.office_code,2,3) ='"+code+"')l2,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='61' and substr(a.work_id,3,2)='01' and substr(b.office_code,2,3)='"+code+"')m,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='61' and substr (a.work_id,3,2)='02' and substr(b.office_code,2,3)='"+code+"')m1,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='61' and substr(a.work_id,3,2)='03' and substr(b.office_code,2,3)='"+code+"')m2,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='56' and substr(a.work_id,3,2)='01' and substr(b.office_code,2,3)='"+code+"')n,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='56' and substr (a.work_id,3,2)='02' and substr(b.office_code,2,3)='"+code+"')n1,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='56' and substr(a.work_id,3,2)='03' and substr(b.office_code,2,3)='"+code+"')n2,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='27' and substr(a.work_id,3,2)='01' and substr(b.office_code,2,3)='"+code+"')o,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='27' and substr (a.work_id,3,2)='02' and substr(b.office_code,2,3)='"+code+"')o1,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='27' and (substr(a.work_id,3,2)='04' or substr(a.work_id,3,2)='03') and substr(b.office_code,2,3)='"+code+"')o2,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='11' and substr(a.work_id,3,2)='01' and substr(b.office_code,2,3)='"+code+"')p,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='11' and substr (a.work_id,3,2)='02' and substr(b.office_code,2,3)='"+code+"')p1,(select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='11' and (substr(a.work_id,3,2)='03' or substr(a.work_id,3,2)='04') and substr(b.office_code,2,3)='"+code+"')p2,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='01' and substr(a.work_id,3,2)='00' and substr (b.office_code,2,3) ='"+code+"')a6,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='01' and substr(a.work_id,3,2)='07' and substr (b.office_code,2,3) ='"+code+"')a7,(select nvl(sum(voucher_amt),0)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and substr(a.work_id,1,2)='18' and substr(a.work_id,3,2)='00' and substr (b.office_code,2,3) ='"+code+"')c4 from dual ";
//System.out.println("qry1:"+qry1);
rs1=st1.executeQuery(qry1);
if(rs1.next())
{%>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(1)+rs1.getDouble(2)+rs1.getDouble(3))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(1))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(2))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(3))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(4))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(5))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(51))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(52))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(6)+rs1.getDouble(7)+rs1.getDouble(8))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(6))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(7))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(8))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(9)+rs1.getDouble(10)+rs1.getDouble(11))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(9))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(10))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(11))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(53))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(12)+rs1.getDouble(13)+rs1.getDouble(14))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(12))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(13))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(14))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(15)+rs1.getDouble(16)+rs1.getDouble(17))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(15))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(16))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(17))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(18)+rs1.getDouble(19)+rs1.getDouble(20))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(18))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(19))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(20))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(21)+rs1.getDouble(22)+rs1.getDouble(23))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(21))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(22))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(23))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(24)+rs1.getDouble(25)+rs1.getDouble(26))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(24))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(25))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(26))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(27)+rs1.getDouble(28)+rs1.getDouble(29))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(27))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(28))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(29))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(30)+rs1.getDouble(31)+rs1.getDouble(32))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(30))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(31))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(32))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(33)+rs1.getDouble(34)+rs1.getDouble(35))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(33))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(34))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(35))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(36)+rs1.getDouble(37)+rs1.getDouble(38))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(36))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(37))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(38))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(39)+rs1.getDouble(40)+rs1.getDouble(41))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(39))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(40))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(41))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(42)+rs1.getDouble(43)+rs1.getDouble(44))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(42))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(43))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(44))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(45)+rs1.getDouble(46)+rs1.getDouble(47))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(45))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(46))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(47))%></td>

<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(48)+rs1.getDouble(49)+rs1.getDouble(50))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(48))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(49))%></td>
<td class=rptvalue align="right"><%=ndf.format(rs1.getDouble(50))%></td>


<%
col1+=rs1.getDouble(1);col2+=rs1.getDouble(2);col3+=rs1.getDouble(3);col4+=rs1.getDouble(4);
col5+=rs1.getDouble(5);col6+=rs1.getDouble(6);col7+=rs1.getDouble(7);col8+=rs1.getDouble(8);
col9+=rs1.getDouble(9);col10+=rs1.getDouble(10);

col11+=rs1.getDouble(11);col12+=rs1.getDouble(12);col13+=rs1.getDouble(13);col14+=rs1.getDouble(14);
col15+=rs1.getDouble(15);col16+=rs1.getDouble(16);col17+=rs1.getDouble(17);col18+=rs1.getDouble(18);
col19+=rs1.getDouble(19);col20+=rs1.getDouble(20);

col21+=rs1.getDouble(21);col22+=rs1.getDouble(22);col23+=rs1.getDouble(23);col24+=rs1.getDouble(24);
col25+=rs1.getDouble(25);col26+=rs1.getDouble(26);col27+=rs1.getDouble(27);col28+=rs1.getDouble(28);
col29+=rs1.getDouble(29);col30+=rs1.getDouble(30);

col31+=rs1.getDouble(31);col32+=rs1.getDouble(32);col33+=rs1.getDouble(33);col34+=rs1.getDouble(34);
col35+=rs1.getDouble(35);col36+=rs1.getDouble(36);col37+=rs1.getDouble(37);col38+=rs1.getDouble(38);
col39+=rs1.getDouble(39);col40+=rs1.getDouble(40);

col41+=rs1.getDouble(41);col42+=rs1.getDouble(42);col43+=rs1.getDouble(43);col44+=rs1.getDouble(44);
col45+=rs1.getDouble(45);col46+=rs1.getDouble(46);col47+=rs1.getDouble(47);col48+=rs1.getDouble(48);
col49+=rs1.getDouble(49);col50+=rs1.getDouble(50);col51+=rs1.getDouble(51);col52+=rs1.getDouble(52);
col53+=rs1.getDouble(53);

tot1+=rs1.getDouble(1)+rs1.getDouble(2)+rs1.getDouble(3);
tot2+=rs1.getDouble(6)+rs1.getDouble(7)+rs1.getDouble(8);
tot3+=rs1.getDouble(9)+rs1.getDouble(10)+rs1.getDouble(11);
tot4+=rs1.getDouble(12)+rs1.getDouble(13)+rs1.getDouble(14);
tot5+=rs1.getDouble(15)+rs1.getDouble(16)+rs1.getDouble(17);
tot6+=rs1.getDouble(18)+rs1.getDouble(19)+rs1.getDouble(20);
tot7+=rs1.getDouble(21)+rs1.getDouble(22)+rs1.getDouble(23);
tot8+=rs1.getDouble(24)+rs1.getDouble(25)+rs1.getDouble(26);
tot9+=rs1.getDouble(27)+rs1.getDouble(28)+rs1.getDouble(29);
tot10+=rs1.getDouble(30)+rs1.getDouble(31)+rs1.getDouble(32);
tot11+=rs1.getDouble(33)+rs1.getDouble(34)+rs1.getDouble(35);
tot12+=rs1.getDouble(36)+rs1.getDouble(37)+rs1.getDouble(38);
tot13+=rs1.getDouble(39)+rs1.getDouble(40)+rs1.getDouble(41);
tot14+=rs1.getDouble(42)+rs1.getDouble(43)+rs1.getDouble(44);
tot15+=rs1.getDouble(45)+rs1.getDouble(46)+rs1.getDouble(47);
tot16+=rs1.getDouble(48)+rs1.getDouble(49)+rs1.getDouble(50);


}%>

</tr>
<%}%>
<tr>
<td colspan="3" align="center" class=btext>Total</td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot1)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col1)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col2)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col3)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col4)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col5)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col51)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col52)%></td>


<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot2)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col6)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col7)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col8)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot3)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col9)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col10)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col11)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col53)%></td>


<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot4)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col12)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col13)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col14)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot5)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col15)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col16)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col17)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot6)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col18)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col19)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col20)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot7)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col21)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col22)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col23)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot8)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col24)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col25)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col26)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot9)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col27)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col28)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col29)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot10)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col30)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col31)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col32)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot11)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col33)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col34)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col35)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot12)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col36)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col37)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col38)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot13)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col39)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col40)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col41)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot14)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col42)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col43)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col44)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot15)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col45)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col46)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col47)%></td>

<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(tot16)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col48)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col49)%></td>
<td align="right" class="btext" nowrap align="right" class="btext" nowrap><%=ndf.format(col50)%></td>

</tr>
</table>
<p align="left">
<font color="red" face="verdana" size="2">Note:Total=Plain+Sc+St</font><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" face="verdana" size="2">ST=TSP+NTSP</font></p>