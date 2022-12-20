



<td width="165"><html:select name="WORK"  property="ssryr" style="width: 120px;" indexed="true" styleClass="mycombo">
           <%

	try{
		String finYear=request.getParameter("ssryr");
		String temp="";
		conn=nic.watersoft.commons.RwsOffices.getConn();
		Statement stmt11=conn.createStatement();
		String fy="";
        
		int fy1=0;
			String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2010 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
		    //System.out.println("Fin"+ finquery);
			ResultSet rs11 = stmt11.executeQuery( finquery);
			while(rs11.next())
			{
				 fy=rs11.getString(1);
				 fy1=Integer.parseInt(fy)+1;
                 if(finYear!=null && !finYear.equals(""))
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
		
}catch(Exception e){e.printStackTrace();}
%>

</html:select>
</td>