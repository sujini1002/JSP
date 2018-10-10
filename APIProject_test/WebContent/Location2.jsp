<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e0a111ce3956b96d4feac576beb420c&libraries=services,clusterer,drawing"></script>
<title>주소로 장소 표시하기</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>

</head>
<body>
	<!-- <p style="margin-top: -12px">
      <em class="link"> <a href="javascript:void(0);"
         onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
            혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요. </a>
      </em>
   </p> -->

	<input type="text" id="sample5_address" placeholder="주소">
	<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
	<input type="button" onclick="find()" value="찾기">
	<input type="button" onclick="route()" value="최단환승">

	<br>
	<div id="map"
		style="width: 800px; height: 500px; margin-top: 10px; display: none"></div>
	<hr>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>



	<div id="map" style="width: 100%; height: 350px;"></div>


	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 

		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		/* // 마커를 미리 생성합니다
		var marker = new daum.maps.Marker({
		   position : map.getCenter(),
		   map : map
		}); */

		// 주소 좌표를 담을 변수를 선언합니다
		var coords;

		// 검색된 주소 좌표를 담을 배열을 선언합니다
		var coordsArray = [];

		// 주소좌표의 y값을 담을 배열을 선언
		var coordsY = [];
		// 주소좌표의 x값을 담을 배열을 선언
		var coordsX = [];

		// 주소로 좌표를 검색합니다
		function sample5_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var fullAddr = data.address; // 최종 주소 변수
							var extraAddr = ''; // 조합형 주소 변수

							// 기본 주소가 도로명 타입일때 조합한다.
							if (data.addressType === 'R') {
								//법정동명이 있을 경우 추가한다.
								if (data.bname !== '') {
									extraAddr += data.bname;
								}
								// 건물명이 있을 경우 추가한다.
								if (data.buildingName !== '') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
								fullAddr += (extraAddr !== '' ? ' ('
										+ extraAddr + ')' : '');
							}

							// 주소 정보를 해당 필드에 넣는다.
							document.getElementById("sample5_address").value = fullAddr;
							// 주소로 상세 정보를 검색
							geocoder
									.addressSearch(
											data.address,
											function(results, status) {
												// 정상적으로 검색이 완료됐으면
												if (status === daum.maps.services.Status.OK) {

													var result = results[0]; //첫번째 결과의 값을 활용

													// 해당 주소에 대한 좌표를 받아서
													coords = new daum.maps.LatLng(
															result.y, result.x);
													var y = result.y;
													var x = result.x;
													coordsY.push(y);
													coordsX.push(x);

													console.log("y는 " + y);

													coordsArray.push(coords);
													// 지도를 보여준다.
													mapContainer.style.display = "block";
													map.relayout();
													// 지도 중심을 변경한다.
													map.setCenter(coords);
													// 마커를 결과값으로 받은 위치로 옮긴다.
													//marker.setPosition(coords);   

													// 마커를 생성
													for (var i = 0; i < coordsArray.length; i++) {
														marker = new daum.maps.Marker(
																{
																	map : map, // 마커를 표시할 지도
																	position : coordsArray[i]
																// 마커 위치
																});
													}

													console.log(coordsArray);
												}
											});
						}
					}).open();
		}

		function find() {
			if (coordsArray.length != 2) {
				alert("주소가 두개가 아님");
				// 
			} else {
				// 좌표를 정수형으로 바꿔주기 위해 1을 곱해줍니다
				var y1 = coordsY[0] * 1;
				console.log("y1은" + y1);
				var y2 = coordsY[1] * 1;

				var x1 = coordsX[0] * 1;
				var x2 = coordsX[1] * 1;

				// y좌표와 x좌표의 중간을 구해서
				var newPosLat = ((y1 + y2) / 2).toFixed(4);
				console.log(newPosLat);
				var newPosLng = ((x1 + x2) / 2).toFixed(4);
				var newLocation = new daum.maps.LatLng(newPosLat, newPosLng);

				coordsArray.push(newLocation);

				console.log(coordsArray);

				// 새 마커를 구합니다.
				marker = new daum.maps.Marker({
					map : map, // 마커를 표시할 지도
					position : newLocation
				});

				// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
				var bounds = new daum.maps.LatLngBounds();

				for (var j = 0; j < coordsArray.length; j++) {
					// LatLngBounds 객체에 좌표를 추가합니다
					bounds.extend(coordsArray[j]);
				}
				// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
				// 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
				map.setBounds(bounds);

			}
			console.log("coordsY는 " + coordsY);
			console.log("coordsX는 " + coordsX);

			// 좌표배열을 비워줍니다.
			/* coordsY=[];
			coordsX=[]; */
		}
		function route() {
			var htmlstr = '';	
			$
					.ajax({
						url : "http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoBySubway?serviceKey=XqhcB%2B4O4FdfcQVx9UB21n%2BiIB6FAtEwCHvQaY7Nxuk33dr9vyrlczOvLH2cr8hwaPK1yP%2FYC7u7tw1MzbhNNw%3D%3D&startX="
								+ "127.016394"
								+ "&startY="
								+ "37.592557"
								+ "&endX="
								+ "127.025063"
								+ "&endY="
								+ "37.603369",
						success : function(data) {
							$(data).find('itemList').each(function(){
								
								 
								$(data).find('pathList').each(function(){
									
									var fid = $(this).find('fid').text();
									var fname = $(this).find('fname').text();
									var railLinkList = $(this).find('railLinkList').text();
									var railLinkId = $(this).find('railLinkId').text();
									var routeNm = $(this).find('routeNm').text();
									var tid = $(this).find('tid').text();
									var tname = $(this).find('tname').text();
									
									 htmlstr += '<h5> 탑승지 id: '+ fid +'</h5>'
												+'탑승지 명: '+ fname +'</h5>'
											     +'<h5> 경유지지하철 목록: '+ railLinkList +'</h5>'
												+'<h5> 지하철: '+ routeNm +'</h5>'
												+'<h5>탑승 버스/지하철 : '+ routeNm +'&nbsp;'
												+'<h5> 하차지 ID : '+ tid +'&nbsp;'
												+'<h5>하차지명 : '+ tname +'</h5>'
							});
								 var time = $(this).find('time').text();
								 htmlstr += '<h3> 총시간 :'+time +' 분</h3>'
								 $('body').append(htmlstr); 
							});
						},
						error : function() {
							alert("error");
						}
					});
		}
	</script>

</body>