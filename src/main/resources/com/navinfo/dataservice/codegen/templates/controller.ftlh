package ${package}.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.web.servlet.ModelAndView;

import ${package}.model.${modelClassName};
import com.navinfo.dataservice.commons.log.LoggerRepos;
import com.navinfo.dataservice.commons.springmvc.BaseController;
import com.navinfo.dataservice.commons.util.DateUtils;
import com.navinfo.dataservice.commons.util.StringUtils;
import ${package}.service.${modelClassName}Service;
import com.navinfo.navicommons.database.Page;

import net.sf.json.JSONObject;

/** 
* @ClassName: ${modelClassName}Controller 
* @author code generator 
* @date 2016年4月6日 下午6:25:24 
* @Description: TODO
*/
@Controller
public class ${modelClassName}Controller extends BaseController {
	private Logger log = LoggerRepos.getLogger(this.getClass());
	@Autowired 
	private ${modelClassName}Service service;

	
	@RequestMapping(value = "/create")
	public ModelAndView create(HttpServletRequest request){
		try{	
			String parameter = request.getParameter("param");
			if (StringUtils.isEmpty(parameter)){
				throw new IllegalArgumentException("param参数不能为空。");
			}		
			JSONObject dataJson = JSONObject.fromObject(URLDecode(parameter));			
			if(dataJson==null){
				throw new IllegalArgumentException("param参数不能为空。");
			}
			service.create(dataJson);			
			return new ModelAndView("jsonView", success("创建成功"));
		}catch(Exception e){
			log.error("创建失败，原因："+e.getMessage(), e);
			return new ModelAndView("jsonView",exception(e));
		}
	}
	@RequestMapping(value = "/update")
	public ModelAndView update(HttpServletRequest request){
		try{			
			JSONObject dataJson = JSONObject.fromObject(URLDecode(request.getParameter("param")));			
			if(dataJson==null){
				throw new IllegalArgumentException("param参数不能为空。");
			}
			service.update(dataJson);			
			return new ModelAndView("jsonView", success("修改成功"));
		}catch(Exception e){
			log.error("修改失败，原因："+e.getMessage(), e);
			return new ModelAndView("jsonView",exception(e));
		}
	}
	@RequestMapping(value = "/delete")
	public ModelAndView delete(HttpServletRequest request){
		try{			
			JSONObject dataJson = JSONObject.fromObject(URLDecode(request.getParameter("param")));			
			if(dataJson==null){
				throw new IllegalArgumentException("param参数不能为空。");
			}
			service.delete(dataJson);			
			return new ModelAndView("jsonView", success("删除成功"));
		}catch(Exception e){
			log.error("删除失败，原因："+e.getMessage(), e);
			return new ModelAndView("jsonView",exception(e));
		}
	}
	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest request){
		try{			
			JSONObject dataJson = JSONObject.fromObject(URLDecode(request.getParameter("param")));			
			if(dataJson==null){
				throw new IllegalArgumentException("param参数不能为空。");
			}
			int curPageNum= 1;//默认为第一页
			String curPage= request.getParameter("page");
			if (StringUtils.isNotEmpty(curPage)){
				curPageNum = Integer.parseInt(curPage);
			}
			Page data = service.list(dataJson,curPageNum);			
			return new ModelAndView("jsonView", success(data));
		}catch(Exception e){
			log.error("获取列表失败，原因："+e.getMessage(), e);
			return new ModelAndView("jsonView",exception(e));
		}
	}
	
	@RequestMapping(value = "/query")
	public ModelAndView query(HttpServletRequest request){
		try{
			JSONObject dataJson = JSONObject.fromObject(URLDecode(request.getParameter("param")));			
			if(dataJson==null){
				throw new IllegalArgumentException("param参数不能为空。");
			}
			HashMap data = service.query(dataJson);			
			return new ModelAndView("jsonView", success(data));
		}catch(Exception e){
			log.error("获取明细失败，原因："+e.getMessage(), e);
			return new ModelAndView("jsonView",exception(e));
		}
	}
}
