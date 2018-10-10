<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>

</body>
<script>
function wifi(fname){
	 fname = fname.substring(0,fname.length-1);
	var servicekey = "667849734474676932356563715066";
	
	$.ajax({
		url : 'http://swopenAPI.seoul.go.kr/api/subway/'+servicekey+'/xml/stationWifi/0/10/'+fname,
		
		success : function(data){
			var company = null;
			var htmlstr = '';
			console.log(fname.length);
			console.log('http://swopenAPI.seoul.go.kr/api/subway/' + servicekey +'/xml/stationWifi/0/5/' + fname);
			console.log(data);
			$(data).find('row').each(function(){
				var statnNm = $(this).find('statnNm').text(); //지하철역 명
				var subwayNm = $(this).find('subwayNm').text(); //지하철 명
				var telecomSsid = $(this).find('telecomSsid').text(); //Ssid 등록 통신사
				var signalStrength =  $(this).find('signalStrength').text(); //신호 세기
				if(company == null){
					htmlstr += printWifi(statnNm,subwayNm,telecomSsid,signalStrength);
				}else if(company != telecomSsid ){
					htmlstr += printWifi(statnNm,subwayNm,telecomSsid,signalStrength);
					company = telecomSsid;
				}
				
								
				$('body').append(htmlstr);
				
			});
		},
	 error : function(){alert("error");}
	});//end ajax
}
function printWifi(statnNm,subwayNm,telecomSsid,signalStrength){
	return '<h5>'+
	 +'지하철 역명 : ' + statnNm + '&nbsp;'
	 +'지하철 호선 : ' + subwayNm + '&nbsp;'
	 +'통신사 : ' + telecomSsid + '&nbsp;'
	 +'신호세기 : ' + signalStrength + '&nbsp;'
	 +'</h5>'
}
</script>
</html>