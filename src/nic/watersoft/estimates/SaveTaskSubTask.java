package nic.watersoft.estimates;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class SaveTaskSubTask extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		HttpSession session = request.getSession();
		TaskSubTaskForm myForm = (TaskSubTaskForm)form;
		String index = myForm.getCompIndex();
		//System.out.println("Index in SaveTaskSubTask is " + index);
		ArrayList tasks = myForm.getTasks();
		EstimateForm estimateForm = (EstimateForm)session.getAttribute("NewEstimateForm");
		ArrayList components = estimateForm.getComponents();
				
		int ndx = Integer.parseInt(index);
		EstimateHolder component = (EstimateHolder)components.get(ndx);
		component.setTasks(tasks);
		components.set(ndx, component);
		estimateForm.setComponents(components);
		
		return mapping.findForward("success");
	}
}