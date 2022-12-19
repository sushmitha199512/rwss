package nic.watersoft.estimates;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class PickTaskSubTask extends Action
{
	ArrayList tasks = null;
	ArrayList assetTasks = null;
	ArrayList assetSubTasks = null;
	TaskHolder holder = null;
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		CommonLists commonLists = new CommonLists(getDataSource(request));
		String compIndex = request.getParameter("ndx");
		//System.out.println("Index in PickTaskSubTask is " + compIndex);
		String assetTypeCode = request.getParameter("atc");
		String assetTypeName = request.getParameter("atn");
		String componentCode = request.getParameter("wcc");
		String componentName = request.getParameter("wcn");
		String subComponentCode = request.getParameter("scc");
		String subComponentName = request.getParameter("scn");
		
		String mode = request.getParameter("mode");
		TaskSubTaskForm myForm = (TaskSubTaskForm)form;
		
		if(mode == null)
			mode = "data";
		
		//System.out.println("Mode is " + mode);
		
		if(mode.equals("data"))
		{
			myForm.setCompIndex(compIndex);
			myForm.setAssetTypeCode(assetTypeCode);
			myForm.setAssetTypeName(assetTypeName);
			myForm.setComponentCode(componentCode);
			myForm.setComponentName(componentName);
			myForm.setSubComponentCode(subComponentCode);
			myForm.setSubComponentName(subComponentName);
			assetTasks = commonLists.getAssetTasks(assetTypeCode,componentCode, subComponentCode);
			tasks = new ArrayList();
			tasks.add(new TaskHolder());
			myForm.setTasks(tasks);
		}
						
		if(mode.equals("subtask"))
		{
			String index = request.getParameter("index");
			if(index == null)
				index = "0";
			int ndx = 0;
			try
			{	ndx = Integer.parseInt(index);
			}
			catch(NumberFormatException nfe)
			{	//System.out.println("Error converitng index to ndx");			
			}
			
			assetTypeCode = myForm.getAssetTypeCode();
			componentCode = myForm.getComponentCode();
			subComponentCode = myForm.getSubComponentCode();	
			
			tasks = myForm.getTasks();
			holder = (TaskHolder) tasks.get(ndx);
			String taskCode = holder.getTaskCode();
			assetSubTasks = commonLists.getAssetSubTasks(assetTypeCode,componentCode, subComponentCode, taskCode);
			holder.setAssetSubTasks(assetSubTasks);
			tasks.set(ndx,holder);
		}
		if(mode.equals("desc"))
		{
			String index = request.getParameter("index");
			if(index == null)
				index = "0";
			int ndx = 0;
			try
			{	ndx = Integer.parseInt(index);
			}
			catch(NumberFormatException nfe)
			{	//System.out.println("Error converitng index to ndx");			
			}
			assetTypeCode = myForm.getAssetTypeCode();
			componentCode = myForm.getComponentCode();
			subComponentCode = myForm.getSubComponentCode();
			tasks = myForm.getTasks();
			holder = (TaskHolder) tasks.get(ndx);
			String taskCode = holder.getTaskCode();
			String subTaskCode = holder.getSubTaskCode();
			String subTaskDesc = commonLists.getAssetSubTaskDesc(assetTypeCode,componentCode, subComponentCode, taskCode, subTaskCode);
			holder.setSubTaskDesc(subTaskDesc);
			tasks.set(ndx,holder);
		}
		
		if(mode.equals("add"))
		{
			tasks = myForm.getTasks();
			String index = request.getParameter("index");
			if(index == null)
				index = "0";
			
			int ndx = Integer.parseInt(index);
			TaskHolder holder = (TaskHolder)tasks.get(ndx);
			holder.setActionName("-");
			holder.setTitle("Remove this Task / Sub Task");
			tasks.set(ndx,holder);
			tasks.add(new TaskHolder());
			myForm.setTasks(tasks);
		}
		if(mode.equals("remove"))
		{
			tasks = myForm.getTasks();
			String index = request.getParameter("index");
			if(index == null)
				index = "0";
			
			int ndx = Integer.parseInt(index);
			tasks.remove(ndx);
			myForm.setTasks(tasks);
		}
				
		HttpSession session = request.getSession();
		session.setAttribute("assetTasks", assetTasks);
		session.setAttribute("assetSubTasks", assetSubTasks);
		return mapping.findForward("data-success");
	}
}