<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% 
	//스크립트는 맨 앞의 숫자 '0'을 못 읽기때문에 JSP에서 controller로부터 로그인정보(session값-userEmno)받은 후 hidden('#reqUserEmno')의 value값에 입력
	//hidden('#reqUserEmno')는 스크립트 영역 밑의 <body>영역에 있음
	String userEmno = (String)request.getAttribute("userEmno");
%>
<script language="javascript">

	$(document).ready(function(){
		
		var empEmno = $("#reqUserEmno").val();	

		certificateRequestEmpInfoFunc(empEmno);
		certificateRequestListFunc(empEmno);
		
	});
	
	//증명서 신청 시 사원정보
	function certificateRequestEmpInfoFunc(empEmno){
		
		var url = "/spring/certificateRequestEmpInfo.do";
		var data = {"empEmno":empEmno};
		
		paging.ajaxSubmit(url,data,function(result){
			
			console.log("data: " + JSON.stringify(result));

			var thisBody = $("#crtfRequestEmpInfo tbody");
			thisBody.find("input[name='crtfRequestDate']").val(result.crtfRequestDate);
			thisBody.find("input[name='empEmno']").val(result.empEmno);
			thisBody.find("input[name='empName']").val(result.empName);
			thisBody.find("input[name='rankName']").val(result.rankName);
			thisBody.find("input[name='deptName']").val(result.deptName);
			
		});
		
	}//certificateRequestInfoFunc
	
	//증명서 신청내역
	function certificateRequestListFunc(empEmno){
		
		var url = "/spring/certificateRequestList.do";
		var data = {"empEmno":empEmno};
		
		paging.ajaxSubmit(url,data,function(result){
			
			console.log("listData: " + JSON.stringify(result));
			
			var thisBody = $("#crtfRequestList table tbody");
			
			if(result.length <= 0 || result == null){	//증명서 신청내역이 없을경우
				
				if(thisBody.find("tr")){
					
					thisBody.find("tr").each(function(){
						$(this).remove();
					});

				}//if
				
			}else{										//증명서 신청내역이 있을경우
				
				if(thisBody.find("tr")){
					
					thisBody.find("tr").each(function(){
						$(this).remove();
					});
					
				}//if
				
				$.each(result,function(idx){
				
					thisBody.append(
							"<tr data-toggle='modal' data-target='#viewModal' onClick='certificateRequestInfoFunc($(this))'>" + 
								"<td name='crtfSeq'>" + result[idx].crtfSeq + "</td>" + 
								"<td name='empEmno'>" + result[idx].empEmno + "</td>" + 
								"<td name='empName'>" + result[idx].empName + "</td>" + 
								"<td name='commName'>" + result[idx].commName + "</td>" + 
								"<td name='crtfUse'>" + result[idx].crtfUse + "</td>" + 
								"<td name='crtfRequestDate'>" + result[idx].crtfRequestDate + "</td>" + 
								"<td name='crtfIssueDate'>" + result[idx].crtfIssueDate + "</td>" + 
								"<td name='crtfProgressSituation'>" + result[idx].crtfProgressSituation + "</td>" + 
							"</tr>"
					);
				});
			
			}//if
			
		});
		
	}//certificateRequestList
	
	//증명서 신청하기
	$("#crtfRequestBtn").on("click",function(){
		
		var crtfSelect = $("#crtfRequestEmpInfo select").find("option:selected").val();
		var crtfUse = $("#crtfRequestEmpInfo input[name='crtfUse']").val();
		
		if(crtfSelect == 'default'){
			alert("증명서를 선택하여 주십시오.");
			return false;
		}else if(crtfUse == '' || crtfUse == null){
			alert("용도를 입력하여 주십시오.");
			return false;
		}//if
		
		var url = "/spring/certificateInsert.do";
		var frm = $("#crtfRequestEmpInfo form").attr("id");
		
		if(confirm("정말로 신청하시겠습니까?")){
			
			paging.ajaxFormSubmit(url,frm,function(result){
				
				if(result != 0){
					alert("신청이 완료되었습니다.");
					location.href = "/spring/certificateRequest.do";
				}else{
					alert("신청에 실패하였습니다. 다시 시도하여 주십시오.");
					location.href = "/spring/certificateRequest.do";
				}//if
				
			});
			
		}else{
			return false;
		}//if
	});
	
	
	
	//증명서 상세정보
	function certificateRequestInfoFunc(data){
		
		//각 tr의 정보(발행번호)를 가져온다
		var obj = {};
		obj.crtfSeq = data.find("td[name='crtfSeq']").text();	//발행번호
		
		paging.ajaxSubmit("certificateSearchInfo.exc",obj,function(rslt){
			
			var crtfSeq = rslt.crtfSeq;								//발행번호
			var empEmno = rslt.empEmno;								//사원번호
			var empName = rslt.empName;								//성명
			var commName = rslt.commName;							//증명서종류
			var crtfUse = rslt.crtfUse;								//용도
			var crtfRequestDate = rslt.crtfRequestDate;				//신청일
			var crtfIssueDate = rslt.crtfIssueDate;					//발행일
			var crtfProgressSituation = rslt.crtfProgressSituation 	//결제상태
			
			var formId = $("#viewForm");
			//viewForm에 데이터를 넣는다
			formId.find("[name='crtfSeq']").val(crtfSeq);							//발행번호
			formId.find("[name='empEmno']").val(empEmno);							//사원번호
			formId.find("[name='empName']").val(empName);							//성명
			formId.find("[name='crtfSelect']").val(commName).prop("selected",true);	//증명서종류
			formId.find("[name='use']").val(crtfUse);								//용도
			formId.find("[name='requestDate']").val(crtfRequestDate);				//신청일
			formId.find("[name='issueDate']").val(crtfIssueDate);					//발행일
			formId.find("[name='progressSituation']").val(crtfProgressSituation);	//결제상태

		});
		
		//사원정보가져오기
		obj.emno = data.find("td[name='empEmno']").text();
		
		paging.ajaxSubmit("empInfo.do",obj,function(rslt){
			
			console.log("data2: " + JSON.stringify(rslt));
			
			 $("#viewModal #viewForm input[name='deptName']").val(rslt.deptName); //부서명
			 $("#viewModal #viewForm input[name='rankName']").val(rslt.rankName); //직위/직급명
		});
		
	}
	
	//증명서 신청내역 검색
	function crtfSearchFunc(){
		
		var crtfSearchSelectName = $("#crtfSearch").find("select[name='crtfSearchSelectLg'] option:selected").val();
		var crtfSearchSelectMd = $("#crtfSearch").find("select[name='crtfSearchSelectMd']");
		var crtfSearchSelectCRTF = $("#crtfSearch").find("select[name='crtfSearchSelectCRTF']");
		var crtfSearchSelectCPS = $("#crtfSearch").find("select[name='crtfSearchSelectCPS']");

		if(crtfSearchSelectName == "certificate"){
			
			crtfSearchSelectMd.style.display="none";
			crtfSearchSelectCRTF.style.display="";
			crtfSearchSelectCPS.style.display="none";
			
		}else if(crtfSearchSelectName == "crtfProgressSituation"){

			crtfSearchSelectMd.style.display="none";
			crtfSearchSelectCRTF.style.display="none";
			crtfSearchSelectCPS.style.display="";
			
		}else{
			
			crtfSearchSelectMd.style.display="";
			crtfSearchSelectCRTF.style.display="none";
			crtfSearchSelectCPS.style.display="none";
			
		}//if
		
	}
	
	//상세보기, 미리보기 버튼 클릭시
	$("#viewBtn").click(function(){
	   
		var formId = $("#viewForm");
		var crtfSeq = formId.find("input [name='crtfSeq']").val();
		var userEmno = $("#reqUserEmno").val();
		var url = "";
		alert(userEmno);
		if(formId.find("[name='crtfSelect']").val() == "재직증명서"){
		   url = "workCertificate.exc?emno="+userEmno+"&crtfSeq="+crtfSeq;
		}else if(formId.find("[name='crtfSelect']").val() == "경력증명서"){
		   url = "carriereCertificate.exc?emno="+userEmno+"&crtfSeq="+crtfSeq;
		}else if(formId.find("[name='crtfSelect']").val() == "퇴직증명서"){
		   url = "rtirementCertificate.exc?emno="+userEmno;
		}
			
		window.open(url, "_blank", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");      
	});
	
	//증명서 삭제
	var certificateDelete = $("#deleteBtn").on("click",function(){
		
		//각 tr의 정보(발행번호)를 가져온다
		var obj = {};
		obj.crtfSeq = $("#viewModal").find("#viewForm").find("input[name='crtfSeq']").val();	//발행번호
		
		if(confirm("삭제하시겠습니까?") == true){
			
			paging.ajaxSubmit("certificateDelete.exc",obj,function(result){
				console.log("result : " + result);
				if(result > 0){
					alert("삭제되었습니다");
					location.href="/spring/certificateRequest.do";
				}else{
					alert("삭제실패. 다시 실행해주세요");
					location.href="/spring/certificateRequest.do";
				}
			});
		} 
	});




</script>
</head>
<body>
	<input type="hidden" id="reqUserEmno" value="<%=userEmno%>">
</body>
</html>