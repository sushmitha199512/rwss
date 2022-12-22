<%@page import="java.util.Calendar"%>
<%@	page import="java.sql.*,nic.watersoft.commons.RwsOffices" %>

<td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="finyear" id="combo1" class="mycombo" style="width:150px">
		<option value="0">Select</option>

<%

int cyear = Calendar.getInstance().get(Calendar.YEAR);
int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
int startFinYear=0;
if (month <= 3) {
	startFinYear = cyear - 1;
   
} else {
	startFinYear = cyear;
   
}
String finYear=request.getParameter("finyear");

	try{
					int endFinYear = 2011;
				int tempYear = 0,temp=0;
				//String finYear=request.getParameter("finyear");
				while(startFinYear>=endFinYear){
					tempYear = startFinYear+1;
					//System.out.println("start year :"+startFinYear+" finYear :"+finYear);
					if(finYear != null &&  !finYear.equals("0")){
						temp = Integer.parseInt( finYear.substring(0, 4));
						
					}
					
					if(startFinYear == temp ){
						//System.out.println("in if start year :"+startFinYear+" finYear :"+temp);
						%>
						<option value=<%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %> selected ><%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %></option>
						<%
					}else
					{
					%>
					<option value=<%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %>><%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %></option>
					<%}
					
					startFinYear--;
				}
				
				
		
}catch(Exception e){
System.out.println("ddd");
e.printStackTrace();}
%>

</SELECT>
		</td>
		</tr>
