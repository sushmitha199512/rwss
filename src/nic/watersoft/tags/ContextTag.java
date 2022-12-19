package nic.watersoft.tags;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

public class ContextTag extends TagSupport 
{
	private String page;
	public void setPage(String page)
	{	this.page = page;
	}

	public String getPage()
	{	return page;
	}

	public int doStartTag() throws JspException
	{
		try
		{
			HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
			HttpSession session = request.getSession();
			ServletContext servletContext = session.getServletContext();

			if(page != null)
			if(page.charAt(0) != '/')
				throw new IllegalArgumentException("Page " + page + " does not start with a \"/\" character");
			
			if(page != null)
				pageContext.getOut().print(request.getContextPath()+page);
			else
				pageContext.getOut().print(request.getContextPath());
		}
		catch(IOException ioe)
		{
			throw new JspTagException("Error: IO Exception while writing to the user");
		}
		return SKIP_BODY;
	}
}