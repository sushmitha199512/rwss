<%@	page import="java.sql.*,nic.watersoft.commons.RwsOffices" %>

<td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="finyear" id="combo1" class="mycombo" style="width:150px">
		<option value="0">Select</option>
	



<%


String finYear=request.getParameter("finyear");
String temp="";
	try{

Statement stmt11=conn.createStatement();
String fy="";
int fy1=0;
			String finquery="select distinct  substr(to_char(BANK_SEND_DATE,'dd/mm/yyyy'),7,4)  from RWS_bill_bank_bridge_TBL where BANK_SEND_DATE is not null and to_char(BANK_SEND_DATE,'MM')>='03'  order by substr(to_char(BANK_SEND_DATE,'dd/mm/yyyy'),7,4) desc ";
		System.out.println("Fin"+ finquery);
			ResultSet rs11 = stmt11.executeQuery( finquery);
			while(rs11.next())
			{
				 fy=rs11.getString(1);
				 fy1=Integer.parseInt(fy)+1;
if(finYear!=null && !finYear.equals("0"))
				{
			 temp=finYear.substring(0,4);
				}
				if(temp.equals(rs11.getString(1))){
	%>
					 <option value="<%=fy+"-"+fy1%>" selected><%=fy+"-"+fy1%></option> 
	<%}else{%>
			<option value="<%=fy+"-"+fy1%>"><%=fy+"-"+fy1%></option> 
	<%}
			}
						if(rs11!=null)rs11.close();
						if(stmt11!=null)stmt11.close();
		
}catch(Exception e){
System.out.println("ddd");
e.printStackTrace();}
%>

</SELECT>
		</td>
		</tr>
