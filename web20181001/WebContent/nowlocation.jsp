<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String addr1 = request.getParameter("address1");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="map" style="width: 100%; height: 350px;"></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e0a111ce3956b96d4feac576beb420c&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);
		
		// 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    {
		        title: '카카오', 
		        latlng: new daum.maps.LatLng(33.450705, 126.570677)
		    },
		    {
		        title: '생태연못', 
		        latlng: new daum.maps.LatLng(33.450936, 126.569477)
		    },
		    {
		        title: '텃밭', 
		        latlng: new daum.maps.LatLng(33.450879, 126.569940)
		    },
		    {
		        title: '근린공원',
		        latlng: new daum.maps.LatLng(33.451393, 126.570738)
		    }
		];

		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		    
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new daum.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new daum.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		}

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(
						'<%=addr1%>',
						function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === daum.maps.services.Status.OK) {

								var coords = new daum.maps.LatLng(result[0].y,
										result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new daum.maps.Marker({
									map : map,
									position : coords
								});

								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new daum.maps.InfoWindow(
										{
											content : '<div style="width:150px;text-align:center;padding:6px 0;">내위치</div>'
										});
								infowindow.open(map, marker);

								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}
						});
	</script>
</body>
</html>