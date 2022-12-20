package nic.watersoft.tags;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class AlertTag extends TagSupport 
{
	private HttpSession session;
	private HttpServletRequest request;
	private Object oMessage;
	private String property;
	private String scope;
	
	public void setProperty(String property)
	{	this.property = property;
	}

	public String getProperty()
	{	return property;
	}
	
	public void setScope(String scope)
	{	this.scope = scope;
	}

	public String getScope()
	{	return scope;
	}
	
	public int doStartTag() throws JspException
	{
		try
		{
			request = (HttpServletRequest)pageContext.getRequest();
			session = request.getSession();
			ServletContext servletContext = session.getServletContext();
			
			if(property == null)
			{
				property = "GlobalConstants.Message";
				oMessage = session.getAttribute(property);
			}
			else
			{
				oMessage = pageContext.getAttribute(property);
				if(oMessage == null)
				{
					oMessage = request.getAttribute(property);
					if(oMessage == null)
					{
						oMessage = session.getAttribute(property);
						if(oMessage == null)
						{	
							oMessage = servletContext.getAttribute(property);
						}
					}
				}
			}
			
			/*
			if(oMessage == null)
				throw new IllegalArgumentException("Cannot find attribute " + property + " in any scope");
			*/

			String message = (String)oMessage;
			
			JspWriter out = pageContext.getOut();
			//out.println("message="+message);
			
			if(message != null)
			{
				out.println("<script>");
				out.println("<!--");
				out.println("alert('" + message + "')");
				out.println("//-->");
				out.println("</script>");
			}
		}
		catch(IOException ioe)
		{	throw new JspTagException("Error: IO Exception while writing to the user");
		}
		finally
		{	session.removeAttribute(property);
		}
		return SKIP_BODY;
	}
}