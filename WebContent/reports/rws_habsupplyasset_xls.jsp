<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null,stmt131=null;
    String qry="";
	ResultSet rs8=null,rs131=null;
	String dname=(String)session.getAttribute("dname");
    
    
	
	
	
	String dcode=(String)session.getAttribute("dcode");
	String mcode=(String)session.getAttribute("mcode");
	String mname=(String)session.getAttribute("mname");
	String type=(String)session.getAttribute("type");
	String typename=(String)session.getAttribute("typename");

	
	
	


    
    int g1=0;
    int g2=0;
    int total=0,mtotal=0;
    int c1=0,c2=0,ctotal=0,htotal=0,shcount=0;
	//System.out.println("mcode***********"+mcode);
	int i=0;
	
   	int sno=1;
	String gqry="";
    int gtotal=0,gtotal1=0,gtotal2=0,gtotal3=0,gtotal4=0;
    int ctotal1=0,ctotal2=0,ctotal3=0;
    int mtotal1=0,mtotal2=0,mtotal3=0,mtotal4=0,mtotal5=0;
    int htotal1=0,htotal2=0,htotal3=0,htotal4=0,htotal5=0;
    int shtotal1=0,shtotal2=0,shtotal3=0,shtotal4=0,shtotal5=0;
	
    
	
	
	
	%>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=25 > Schemes Gap Report (Difference in Assets and Water Supply data)</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center" colspan=25>
	<td class=btext>District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<font color=red><%=mname%></font>Type:<font color=red><%=typename%></font></td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext  nowrap rowspan=2>Sl.No</td>
    <td class=btext  nowrap rowspan=2>Habitation/Code</td>
        <td class=btext  nowrap colspan=5 align=center>PWS</td>
        <td class=btext  nowrap colspan=3 align=center>CPWS</td>
        <td class=btext  nowrap colspan=5 align=center>MPWS</td>
        <td class=btext  nowrap colspan=5 align=center>HANDPUMPS</td>
        <td class=btext  nowrap colspan=5 align=center>SHALLOWHANDPUMPS</td>
        </tr>
                 <tr>
                 <td class=btext  nowrap>Asset</td>
                 <td class=btext  nowrap >Hab(Safe)</td>
                                  <td class=btext  nowrap >Hab(UnSafe)</td>
                                  <td class=btext  nowrap >Total<br>(4+5)</td>
                 <td class=btext  nowrap >Gap<br>(6-3)</td>
<td class=btext  nowrap>Asset</td>
                 <td class=btext  nowrap >Hab(Safe)</td>
                                  
                                  
                 <td class=btext  nowrap >Gap<br>(9-8)</td>
<td class=btext  nowrap>Asset</td>
                 <td class=btext  nowrap >Hab(Safe)</td>
                                  <td class=btext  nowrap >Hab(UnSafe)</td>
                                  <td class=btext  nowrap >Total<br>(12+13)</td>
                 <td class=btext  nowrap >Gap<br>(14-11)</td>
                 
               
                <td class=btext  nowrap>Asset</td>
                 <td class=btext  nowrap >Hab(Safe)</td>
                                  <td class=btext  nowrap >Hab(UnSafe)</td>
                                  <td class=btext  nowrap >Total<br>(17+18)</td>
                 <td class=btext  nowrap >Gap<br>(19-16)</td>
                 
                <td class=btext  nowrap>Asset</td>
                 <td class=btext  nowrap >Hab(Safe)</td>
                                  <td class=btext  nowrap >Hab(UnSafe)</td>
                                  <td class=btext  nowrap >Total<br>(22+23)</td>
                 <td class=btext  nowrap >Gap<br>(24-21)</td>
                
                

	</tr>
<tr>
<td class=btext>1</td>
<td class=btext>2</td>
<td class=btext>3</td>
<td class=btext>4</td>
<td class=btext>5</td>
<td class=btext>6</td>
<td class=btext>7</td>
<td class=btext>8</td>
<td class=btext>9</td>
<td class=btext>10</td>
<td class=btext>11</td>
<td class=btext>12</td>
<td class=btext>13</td>
<td class=btext>14</td>
<td class=btext>15</td>
<td class=btext>16</td>
<td class=btext>17</td>
<td class=btext>18</td>
<td class=btext>19</td>
<td class=btext>20</td>
<td class=btext>21</td>
<td class=btext>22</td>
<td class=btext>23</td>
<td class=btext>24</td>
<td class=btext>25</td>
</tr>
<%
try
{
String sample="";
String locality1="";
	if(type.equals("1"))
	{
     sample="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_shallowhandpumps_tbl h WHERE h.asset_code=m.asset_code and  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' and m.circle_office_code='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.hab_code in(select panch_code from rws_complete_hab_view) group by m.hab_code";
	}
	else
	{
		sample="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_shallowhandpumps_tbl h WHERE h.asset_code=m.asset_code and  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' and m.circle_office_code='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.hab_code not in(select panch_code from rws_complete_hab_view)  group by m.hab_code";

	}
	Statement stmt55=conn.createStatement();
	//System.out.println("sourcesample:"+sample);
	ResultSet rs55=stmt55.executeQuery(sample);
	Hashtable sourceh=new Hashtable();
		while(rs55.next())
	{
		sourceh.put(rs55.getString(2),rs55.getString(1));
	}
	if(rs55!=null)rs55.close();
	if(stmt55!=null)stmt55.close();
String sample1="";
 if(type.equals("1"))
	{
 sample1="select sum(shp_no_safe),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and shp_no_safe is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"'  and h.hab_code in(select panch_code from rws_complete_hab_view) group by panch_code";
	}
	else
	{
     sample1="select sum(shp_no_safe),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and shp_no_safe is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)  group by panch_code";

	}
	Statement stmt555=conn.createStatement();
	//System.out.println("sourcesample:"+sample);
	ResultSet rs555=stmt555.executeQuery(sample1);
	Hashtable sourcehh=new Hashtable();
		while(rs555.next())
	{
		sourcehh.put(rs555.getString(2),rs555.getString(1));
	}
	if(rs555!=null)rs555.close();
	if(stmt555!=null)stmt555.close();
String sample11="";
if(type.equals("1"))
	{
sample11="select sum(shp_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and shp_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code in(select panch_code from rws_complete_hab_view) group by panch_code";
	}
	else
	{
		sample11="select sum(shp_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and shp_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)  group by panch_code";


    }


	Statement stmt5555=conn.createStatement();
	//System.out.println("sourcesample:"+sample);
	ResultSet rs5555=stmt5555.executeQuery(sample11);
	Hashtable sourcehhh=new Hashtable();
		while(rs5555.next())
	{
		sourcehhh.put(rs5555.getString(2),rs5555.getString(1));
	}
	if(rs5555!=null)rs5555.close();
	if(stmt5555!=null)stmt5555.close();
String locality="";
     if(type.equals("1"))
	{
     locality="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_hp_subcomp_param_tbl h WHERE h.asset_code=m.asset_code and  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and hab_code in(select panch_code from rws_complete_hab_view) group by m.hab_code";
	}
	else
	{
		locality="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_hp_subcomp_param_tbl h WHERE h.asset_code=m.asset_code and  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and m.hab_code not in(select panch_code from rws_complete_hab_view)  group by m.hab_code";
	}

	

	Statement	stmt77=conn.createStatement();
	//System.out.println("locality:"+locality);
	ResultSet rs77=stmt77.executeQuery(locality);
	Hashtable loh=new Hashtable();
		while(rs77.next())
	{
		loh.put(rs77.getString(2),rs77.getString(1));
	}
	if(rs77!=null)rs77.close();
	if(stmt77!=null)stmt77.close();
    
	if(type.equals("1"))
	{
    locality1="select sum(hps_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and hps_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code in(select panch_code from rws_complete_hab_view) group by panch_code";
	}
	else
	{
		locality1="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_hp_subcomp_param_tbl h WHERE h.asset_code=m.asset_code and  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.hab_code not in(select panch_code from rws_complete_hab_view)   group by m.hab_code";
	}

	
	Statement	stmt771=conn.createStatement();
	
	ResultSet rs771=stmt771.executeQuery(locality1);
	Hashtable loh1=new Hashtable();
		while(rs771.next())
	{
		loh1.put(rs771.getString(2),rs771.getString(1));
	}
	if(rs771!=null)rs771.close();
	if(stmt771!=null)stmt771.close();
    String locality11="";
	if(type.equals("1"))
	{
	locality11="select sum(hps_no_unsafe),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and hps_no_unsafe is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"'  and h.hab_code in(select panch_code from rws_complete_hab_view)  group by panch_code";
	}
	else
	{
		locality11="select sum(hps_no_unsafe),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and hps_no_unsafe is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)    group by panch_code";

	}
	Statement	stmt7711=conn.createStatement();
	//System.out.println("locality:"+locality);
	ResultSet rs7711=stmt7711.executeQuery(locality11);
	Hashtable loh11=new Hashtable();
		while(rs7711.next())
	{
		loh11.put(rs7711.getString(2),rs7711.getString(1));
	}
	if(rs7711!=null)rs7711.close();
	if(stmt7711!=null)stmt7711.close();
	String asset="";
   if(type.equals("1"))
   {
    asset="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and hab_code in(select panch_code from rws_complete_hab_view) group by m.hab_code";
   }
   else
   {
    asset="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.hab_code not in(select panch_code from rws_complete_hab_view)   group by m.hab_code";
   }
	Statement	stsh=conn.createStatement();
	//System.out.println("sh:"+sh);
	ResultSet rssh=stsh.executeQuery(asset);
	Hashtable shh=new Hashtable();
	while(rssh.next())
	{
	shh.put(rssh.getString(2),rssh.getString(1));
	}
	if(rssh != null)
	{
		rssh.close();
	}
	if(stsh != null)
	{
		stsh.close();
	}
    //
    String asset1="";
	 if(type.equals("1"))
	 {
     asset1="select sum(mpws_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and mpws_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"'  and h.hab_code in(select panch_code from rws_complete_hab_view)  group by panch_code";
	 }
	 else
	 {
		 asset1="select sum(mpws_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and mpws_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)    group by panch_code";
	 

	 }
	Statement	stsh1=conn.createStatement();
	//System.out.println("sh:"+sh);
	ResultSet rssh1=stsh1.executeQuery(asset1);
	Hashtable shh1=new Hashtable();
	while(rssh1.next())
	{
	shh1.put(rssh1.getString(2),rssh1.getString(1));
	}
	if(rssh1 != null)
	{
		rssh1.close();
	}
	if(stsh1 != null)
	{
		stsh1.close();
	}
    String asset11="";
	if(type.equals("1"))
	{
      asset11="select sum(mpws_unsafe_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and mpws_unsafe_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code in(select panch_code from rws_complete_hab_view) group by panch_code";
	}
	else
	{
      asset11="select sum(mpws_unsafe_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and mpws_unsafe_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)   group by panch_code";
	}
	Statement	stsh11=conn.createStatement();
	//System.out.println("sh:"+sh);
	ResultSet rssh11=stsh11.executeQuery(asset11);
	Hashtable shh11=new Hashtable();
	while(rssh11.next())
	{
	shh11.put(rssh11.getString(2),rssh11.getString(1));
	}
	if(rssh11 != null)
	{
		rssh11.close();
	}
	if(stsh11 != null)
	{
		stsh11.close();
	}
    String hh="";
    if(type.equals("1"))
	{
     hh="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and hab_code in(select panch_code from rws_complete_hab_view)  group by m.hab_code";
	}
	else
	{
		hh="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.hab_code not in(select panch_code from rws_complete_hab_view)    group by m.hab_code";

	}
	Statement	p1=conn.createStatement();
	//System.out.println("hh***************:"+hh);
	ResultSet p2=p1.executeQuery(hh);
	Hashtable hp5=new Hashtable();
	while(p2.next())
	{
	hp5.put(p2.getString(2),p2.getString(1));
	}
	if(p2 != null)
	{
		p2.close();
	}
	if(p1 != null)
	{
		p1.close();
	}
    //
    String cpwsqry="";
	 if(type.equals("1"))
	 {
     cpwsqry="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and hab_code in(select panch_code from rws_complete_hab_view) group by m.hab_code";
	 }
	 else
	 {
		 cpwsqry="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.hab_code not in(select panch_code from rws_complete_hab_view)  group by m.hab_code";

	 }
	Statement	cp=conn.createStatement();
	//System.out.println("hh:"+hh);
	ResultSet cprs=cp.executeQuery(cpwsqry);
	Hashtable cph1=new Hashtable();
	while(cprs.next())
	{
	cph1.put(cprs.getString(2),cprs.getString(1));
	}
	if(cprs != null)
	{
		cprs.close();
	}
	if(cp != null)
	{
		cp.close();
	}
    //
    String cpwsqry1="";
	if(type.equals("1"))
	{
     cpwsqry1="select sum(cpws_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and cpws_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code in(select panch_code from rws_complete_hab_view) group by panch_code";
	}
	else
	{
		cpwsqry1="select sum(cpws_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and cpws_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)  group by panch_code";

	}
	Statement	cp1=conn.createStatement();
	//System.out.println("hh:"+cpwsqry1);
	ResultSet cprs1=cp1.executeQuery(cpwsqry1);
	Hashtable cph11=new Hashtable();
	while(cprs1.next())
	{
	cph11.put(cprs1.getString(2),cprs1.getString(1));
	}
	if(cprs1 != null)
	{
		cprs1.close();
	}
	if(cp1 != null)
	{
		cp1.close();
	}
    
    //
    String hh1="";
	if(type.equals("1"))
	{
     hh1="select sum(pws_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and pws_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"'  and h.hab_code in(select panch_code from rws_complete_hab_view) group by panch_code";
	}
	else
	{
    hh1="select sum(pws_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and pws_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)   group by panch_code";
	}
	Statement	p11=conn.createStatement();
	//System.out.println("hh:"+hh);
	ResultSet p22=p11.executeQuery(hh1);
	Hashtable hp55=new Hashtable();
	while(p22.next())
	{
	hp55.put(p22.getString(2),p22.getString(1));
	}
	if(p22 != null)
	{
		p22.close();
	}
	if(p11 != null)
	{
		p11.close();
	}
    
    //
    String pwsunsafe="";
	if(type.equals("1"))
	{
      pwsunsafe="select sum(pws_unsafe_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and pws_unsafe_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code in(select panch_code from rws_complete_hab_view) group by panch_code";
	}
	else
	{
		pwsunsafe="select sum(pws_unsafe_no),panch_code FROM rws_hab_supply_status_tbl h,rws_panchayat_raj_tbl c WHERE h.hab_code=c.panch_code and pws_unsafe_no is not null and substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"' and h.hab_code not in(select panch_code from rws_complete_hab_view)   group by panch_code";

	}
	Statement	p111=conn.createStatement();
	//System.out.println("hh:"+hh);
	ResultSet p222=p111.executeQuery(pwsunsafe);
	Hashtable hp555=new Hashtable();
	while(p222.next())
	{
	hp555.put(p222.getString(2),p222.getString(1));
	}
	if(p222 != null)
	{
		p222.close();
	}
	if(p111 != null)
	{
		p111.close();
	}
    
    //
    
    
       if(type.equals("1"))
       {
        qry="select  panch_name,panch_code  from rws_panchayat_raj_tbl a where   substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"'  and a.panch_code in(select panch_code from rws_complete_hab_view)";
       }
       else if(type.equals("2"))
       {
        qry="select  panch_name,panch_code  from rws_panchayat_raj_tbl a where   substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"' and a.panch_code not in(select panch_code from rws_complete_hab_view)   ";
       }
		
	    
       //System.out.println("qry*********"+qry);
        stmt8=conn.createStatement(); 
        rs8=stmt8.executeQuery(qry);
        
	while (rs8.next())
	{

      String pws=(String)hp5.get(rs8.getString(2));
      if(pws!=null && !pws.equals("") && !pws.equals("null"))
      {

      }
      else
      {
       pws="0";
      } 
      //pwshabsupply
      String pwshab=(String)hp55.get(rs8.getString(2));
      if(pwshab!=null && !pwshab.equals("") && !pwshab.equals("null"))
      {

      }
      else
      {
       pwshab="0";
      } 
      //
      String pwshab1=(String)hp555.get(rs8.getString(2));
      if(pwshab1!=null && !pwshab1.equals("") && !pwshab1.equals("null"))
      {

      }
      else
      {
       pwshab1="0";
      } 

      //
       g1=Integer.parseInt(pws);
       g2=Integer.parseInt(pwshab);
       int g3=Integer.parseInt(pwshab1);
       int g4=g2+g3;
      total=g4-g1;

       gtotal=gtotal+g1;
      gtotal1=gtotal1+g2;
      gtotal2=gtotal2+g3;
      gtotal3=gtotal3+g4;
      gtotal4=gtotal4+total;


       
      String cpws=(String)cph1.get(rs8.getString(2));
      if(cpws!=null && !cpws.equals("") && !cpws.equals("null"))
      {

      }
      else
      {
       cpws="0";
      } 

      String cpwshab=(String)cph11.get(rs8.getString(2));
      if(cpwshab!=null && !cpwshab.equals("") && !cpwshab.equals("null"))
      {

      }
      else
      {
       cpwshab="0";
      } 
     c1=Integer.parseInt(cpws);
     c2=Integer.parseInt(cpwshab);
     ctotal=c2-c1;
     ctotal1=ctotal1+c1;
     ctotal2=ctotal2+c2;
     ctotal3=ctotal3+ctotal;
     
     
    String mpws=(String)shh.get(rs8.getString(2));
    if(mpws!=null && !mpws.equals("") && !mpws.equals("null"))
    {
    }
    else
{
   mpws="0";
  }
String mpwshab=(String)shh1.get(rs8.getString(2));
    if(mpwshab!=null && !mpwshab.equals("") && !mpwshab.equals("null"))
    {
    }
    else
{
   mpwshab="0";
  }
    String mpwshab1=(String)shh11.get(rs8.getString(2));
    if(mpwshab1!=null && !mpwshab1.equals("") && !mpwshab1.equals("null"))
    {
    }
    else
{
   mpwshab1="0";
  }
int m1=Integer.parseInt(mpws);
int m2=Integer.parseInt(mpwshab);
int m3=Integer.parseInt(mpwshab1);
int m4=m2+m3;
mtotal=m4-m1;
mtotal1=mtotal1+m1;
mtotal2=mtotal2+m2;
mtotal3=mtotal3+m3;
mtotal4=mtotal4+m4;
mtotal5=mtotal5+mtotal;
String handpumps=(String)loh.get(rs8.getString(2));
    if(handpumps!=null && !handpumps.equals("") && !handpumps.equals("null"))
    {
    }
    else
{
   handpumps="0";
  }
 
 String handpumps1=(String)loh1.get(rs8.getString(2));
    if(handpumps1!=null && !handpumps1.equals("") && !handpumps1.equals("null"))
    {
    }
    else
{
   handpumps1="0";
  }
    String handpumps11=(String)loh11.get(rs8.getString(2));
    if(handpumps11!=null && !handpumps11.equals("") && !handpumps11.equals("null"))
    {
    }
    else
{
   handpumps11="0";
  }
int hs=Integer.parseInt(handpumps);
int hs1=Integer.parseInt(handpumps1);
int hs2=Integer.parseInt(handpumps11);
int hs3=hs1+hs2;
htotal=hs3-hs;
htotal1=htotal1+hs;
htotal2=htotal2+hs1;
htotal3=htotal3+hs2;
htotal4=htotal4+hs3;
htotal5=htotal5+htotal;


String shallowhandpumps=(String)sourceh.get(rs8.getString(2));
    if(shallowhandpumps!=null && !shallowhandpumps.equals("") && !shallowhandpumps.equals("null"))
     {
     }
     else
     {
     shallowhandpumps="0";
     }
String shallowhandpumps1=(String)sourcehh.get(rs8.getString(2));
    if(shallowhandpumps1!=null && !shallowhandpumps1.equals("") && !shallowhandpumps1.equals("null"))
     {
     }
     else
     {
     shallowhandpumps1="0";
     }

String shallowhandpumps11=(String)sourcehhh.get(rs8.getString(2));
    if(shallowhandpumps11!=null && !shallowhandpumps11.equals("") && !shallowhandpumps11.equals("null"))
     {
     }
     else
     {
     shallowhandpumps11="0";
     }
int suh=Integer.parseInt(shallowhandpumps);
int suh1=Integer.parseInt(shallowhandpumps1);
int suh2=Integer.parseInt(shallowhandpumps11);
int suh3=suh1+suh2;
shcount=suh3-suh;
shtotal1=shtotal1+suh;
shtotal2=shtotal2+suh1;
shtotal3=shtotal3+suh2;
shtotal4=shtotal4+suh3;
shtotal5=shtotal5+shcount;



 
 
 
   


		%>
	<tr>
    <td class="rptValue"><%=sno++%></td>

    <td class="rptValue"><%=rs8.getString(1)%>/<br>&nbsp;<%=rs8.getString(2)%></td>
    <td class="rptValue"><%=pws%></td>
    <td class="rptValue"><%=pwshab%></td>
    <td class="rptValue"><%=pwshab1%></td>
    <td class="rptValue"><%=g4%></td>
        <td class="rptValue"><%=total%></td>
        <td class="rptValue"><%=cpws%></td>
        <td class="rptValue"><%=cpwshab%></td>
        <td class="rptValue"><%=ctotal%></td>
        <td class="rptValue"><%=mpws%></td>
        <td class="rptValue"><%=mpwshab%></td>
        <td class="rptValue"><%=mpwshab1%></td>
               <td class="rptValue"><%=m4%></td>
        <td class="rptValue"><%=mtotal%></td>
        <td class="rptValue"><%=handpumps%></td> 
        <td class="rptValue"><%=handpumps1%></td>
        <td class="rptValue"><%=handpumps11%></td> 
        <td class="rptValue"><%=hs3%></td>
        <td class="rptValue"><%=htotal%></td>
        <td class="rptValue"><%=shallowhandpumps%></td>
        <td class="rptValue"><%=shallowhandpumps11%></td>
        <td class="rptValue"><%=shallowhandpumps1%></td>
                <td class="rptValue"><%=suh3%></td>
        <td class="rptValue"><%=shcount%></td>
</tr>
<%
}
%>
<tr>
<td class=btext>Total:</td>
<td class=btext></td>
<td class=btext><%=gtotal%></td>
<td class=btext><%=gtotal1%></td>
<td class=btext><%=gtotal2%></td>
<td class=btext><%=gtotal3%></td>
<td class=btext><%=gtotal4%></td>
<td class=btext><%=ctotal1%></td>
<td class=btext><%=ctotal2%></td>
<td class=btext><%=ctotal3%></td>
<td class=btext><%=mtotal1%></td>
<td class=btext><%=mtotal2%></td>
<td class=btext><%=mtotal3%></td>
<td class=btext><%=mtotal4%></td>
<td class=btext><%=mtotal5%></td>
<td class=btext><%=htotal1%></td>
<td class=btext><%=htotal2%></td>
<td class=btext><%=htotal3%></td>
<td class=btext><%=htotal4%></td>
<td class=btext><%=htotal5%></td>
<td class=btext><%=shtotal1%></td>
<td class=btext><%=shtotal3%></td>
<td class=btext><%=shtotal2%></td>
<td class=btext><%=shtotal4%></td>
<td class=btext><%=shtotal5%></td>
</tr>
<%

	
	} catch(Exception e)
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
<p align=left><font color=red>Note:<br>
1.Asset :-the data displayed on basis - Asset Master<br>
2.Hab(Safe)   :-the data displayed on basis - Hab Supply<br> 
3.Hab(UnSafe)   :-the data displayed on basis - Hab Supply 
</font></p>


  
