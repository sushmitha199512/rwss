<%@		page import="java.util.*" %>

<%
		Calendar cal = new GregorianCalendar();
		int syear = cal.get(Calendar.YEAR);
		//out.println("//System Year"+syear);

		int[] census = {2001, 2011, 2021,2031,2041,2051,2061,2071,2081,2091};

		int i = 0;

		for (i=0; i < census.length ; i ++)
		{
			if (syear < census[i])
			{
				//out.println(census [i]);
			}
			else
			{
				out.println(census [i]);

			}
		}

%>