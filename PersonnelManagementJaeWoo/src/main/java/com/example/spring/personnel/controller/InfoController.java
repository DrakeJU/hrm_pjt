package com.example.spring.personnel.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.personnel.service.InfoService;

@Controller
public class InfoController {
	
	@Autowired
	private InfoService infoService;
	

	@RequestMapping(value="employeeInfo")
	public String InfoController(){
		
		
		return "employeeInfo";

	
	}//������� ��� view�� ������ ��Ʈ�ѷ� 
	
	@RequestMapping(value="default")
	public String defaultPage(){
		 	
		return "default";
		
	}//dafault ��� �˻� ùȭ������ ������ ��Ʈ�ѷ�
		
	@RequestMapping(value="search")
	public ModelAndView infoSearch(@RequestParam HashMap<String, Object> map) {
		System.out.println("��Ʈ�ѷ�����");
		ModelAndView mv = new ModelAndView();
		
		//System.out.println(map);
		
		mv.addObject("list",infoService.infoSearch(map));
		System.out.println(mv);
		mv.setViewName("searchResult");
		
		return mv;
		
		
		}
//	
		@RequestMapping(value="insert")
		public ModelAndView infoInsert(@RequestParam HashMap<String, String> map) {
			
			
//			String name="";
//			String department="";	
//			String position="";
			
//			map.put("name",request.getParameter("name"));
//			map.put("department",request.getParameter("department"));
//			map.put("position",request.getParameter("position"));
			ModelAndView mv = new ModelAndView();
			
			System.out.println(map);
			
			List list =new ArrayList();			
			infoService.infoInsert(map);
			
			
			mv.addObject("list",list);
			mv.setViewName("/personnel/employeeinfo/tempPage");
			return mv;
			
			
			
		}
		
		
}







