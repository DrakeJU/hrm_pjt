package com.example.spring.attendance.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.spring.attendance.dao.AttendDao;

@Service
public class AttendService {

	private static final Logger logger = LoggerFactory.getLogger(AttendService.class);

	@Autowired
	AttendDao attendDao;
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [일일근태등록]
	 * 개요    : 
	 * @Author : 이용선
	 * @Date   : 2018.02.06
	 ***************************************************************************************/

	/**
	 * 츨근 정보 입력 함수 Insert
	 * @param params
	 */
	public void insertDailAttReg(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		attendDao.insertDailAttReg(params);
	}
	
	/**
	 * 출근 / 퇴근 / 검색 버튼 출력 조회 Select
	 * @param params
	 * @return
	 */
	public List<HashMap<String, Object>> selectInDailAttReg(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return attendDao.selectInDailAttReg(params);
	}
	
	/*
	 * 퇴근 정보 입력 함수 Update
	 * @params params
	 * */
	public void updateDailAttReg(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		attendDao.updateDailAttReg(params);
	}

	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [월간 근태 생성/마감]
	 * 개요    : 
	 * @Author : 제영호
	 * @Date   : 2018.01.??
	 ***************************************************************************************/
	
	public List<HashMap<String, Object>> readMnthngAttdCrtCls(HashMap<String, String> paramMap) {
		// TODO Auto-generated method stub
		return attendDao.readMnthngAttdCrtCls(paramMap);
	}
	
	public HashMap<String, Object> readMnthngAttdCrtClsStts(HashMap<String, String> paramMap) {
		// TODO Auto-generated method stub
		return attendDao.readMnthngAttdCrtClsStts(paramMap);
	}

	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [월근태현황]
	 * 개요    : 
	 * @Author : 이용선
	 * @Date   : 2018.02.08
	 ***************************************************************************************/

	public List<HashMap<String, Object>> mAttdSelectEmpList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return attendDao.mAttdSelectEmpList(map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [휴일 /연장 /야간근무 조회]
	 * 개요    : 
	 * @Author : 제영호
	 * @Date   : 2018.01.??
	 ***************************************************************************************/

	public List<HashMap<String, Object>> readHdayExtnNightWorkInqr(HashMap<String, String> paramMap) {
		// TODO Auto-generated method stub
		return attendDao.readHdayExtnNightWorkInqr(paramMap);
	}
	
	
	public HashMap employee_extended_work_deadline(HashMap<String, Object> map) {
		
		attendDao.employee_extended_work_deadline(map);
		return map;
	}

}
