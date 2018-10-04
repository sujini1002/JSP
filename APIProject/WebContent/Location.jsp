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




	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 

		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);
		
		//교통정보를 표시한다.
		map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC); 
		
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();
		
		// 주소 좌표를 담을 변수를 선언합니다
		var coords;

		// 검색된 주소 좌표를 담을 배열을 선언합니다
		var coordsArray = [];

		// 주소좌표의 y값을 담을 배열을 선언
		var coordsY = [];
		// 주소좌표의 x값을 담을 배열을 선언
		var coordsX = [];
		
		
		

		/* // 마커를 미리 생성합니다
		var marker = new daum.maps.Marker({
		   position : map.getCenter(),
		   map : map
		}); */

		

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
				var newPosLat = ((y1 + y2) / 2);
				console.log("newPosLat"+newPosLat);
				var newPosLng = ((x1 + x2) / 2);
				var newLocation = new daum.maps.LatLng(newPosLat, newPosLng);
				
				console.log('중심좌표 : '+newLocation);
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
			
			//주소를 표시합니다
			searchDetailAddrFromCoords(coordsArray[2],function(result,
					status){
				console.log("result"+result[0]);
				if (status === daum.maps.services.Status.OK) {
					var detailAddr =result[0].road_address.address_name ;
					detailAddr += result[0].address.address_name;
					console.log(detailAddr);
				}//end if
			});

			// 좌표배열을 비워줍니다.
			/* coordsY=[];
			coordsX=[]; */
		}

		function searchDetailAddrFromCoords(coords, callback) {
			// 좌표로 법정동 상세 주소 정보를 요청합니다
			geocoder.coord2Address(coords.ib, coords.jb, callback);
		}
		function route() {
			var index = 0; //아이템 리스트 한개만 보여주기
			var index2 = 0;//아이템 리스트 한개만 보여주기
			var htmlstr = '';
			var title = ''; // 제목
			var title2 = '';// 제목2
			var htmlstr2 = '';
			console.log(coordsArray);
			console.log(coordsArray[0].ib);
			console.log(coordsArray[0].jb);
			console.log(coordsArray[1].ib);
			console.log(coordsArray[1].jb);
			$.ajax({
						
						url : "http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoBySubway?ServiceKey=XqhcB%2B4O4FdfcQVx9UB21n%2BiIB6FAtEwCHvQaY7Nxuk33dr9vyrlczOvLH2cr8hwaPK1yP%2FYC7u7tw1MzbhNNw%3D%3D&startX="
								+ coordsArray[0].ib
								+ "&startY="
								+ coordsArray[0].jb
								+ "&endX="
								+ coordsArray[2].ib //중간위치
								+ "&endY="
								+ coordsArray[2].jb, //중간위치
						success : function(data) {
							var firstLo = null;
							/* $(data).find('msgHeader').each(function(){
								var headerCd = $(this).find('headerCd').text();
								var headerMsg = $(this).find('headerMsg').text();
								htmlstr += headerCd+" : "+headerMsg;
							}); */
							 $(data).find('itemList').each(function(){
								 var tmp_title = '';
								index = index+1;
								console.log(index);
								if(index<2){
								$(data).find('pathList').each(function(){
									
									var fid = $(this).find('fid').text();
									var fname = $(this).find('fname').text();
									var routeNm = $(this).find('routeNm').text();
									var tid = $(this).find('tid').text();
									var tname = $(this).find('tname').text();
									if(firstLo == null){
										firstLo = fid;
										title='<h1>'+fname+'→'+tname + '</h1>';
										tmp_title= '<h1>'+fname+'→';
										htmlstr += '<h5> 탑승지 id: '+ fid +'&nbsp;'
										+'탑승지 명: '+ fname +'&nbsp;'
										+' 지하철: '+ routeNm +'&nbsp;'
										+' 하차지 ID : '+ tid +'&nbsp;'
										+'하차지명 : '+ tname +'</h5>';
										console.log(firstLo);
									}
									else if(fid == firstLo){
									 	return false;
									}else{
										title = tmp_title+tname + '</h1>';
										htmlstr += '<h4>환승</h4>';
										htmlstr += '<h5> 환승 id: '+ fid +'&nbsp;'
										+'환승역 : '+ fname +'&nbsp;'
										+' 환승할 지하철: '+ routeNm +'&nbsp;'
										+' 하차지 ID : '+ tid +'&nbsp;'
										+'하차지명 : '+ tname +'</h5>';
									}
									   
								});
								 var time = $(this).find('time').text();
								 htmlstr += '<h2> 총시간 :'+time +' 분</h2>'; 
								}//end if
							 }); 
							html3 = '';
							$(data).find('railLinkList').each(function(){
								var railLinkId = $(this).find('railLinkId').text();
								html3 += '환승역 : '+ railLinkId +'&nbsp;';
							});
							$('body').append(html3);
							 $('body').append(title);
							 $('body').append(htmlstr);
						},
						error : function() {
							alert("error");
						}
					});
		
			
				  $.ajax({
					url : "http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoBySubway?ServiceKey=XqhcB%2B4O4FdfcQVx9UB21n%2BiIB6FAtEwCHvQaY7Nxuk33dr9vyrlczOvLH2cr8hwaPK1yP%2FYC7u7tw1MzbhNNw%3D%3D&startX="
							+ coordsArray[1].ib
							+ "&startY="
							+ coordsArray[1].jb
							+ "&endX="
							+ coordsArray[2].ib
							+ "&endY="
							+ coordsArray[2].jb,
					success : function(data) {
						var firstLo = null;
						/* $(data).find('msgHeader').each(function(){
							var headerCd = $(this).find('headerCd').text();
							var headerMsg = $(this).find('headerMsg').text();
							htmlstr += headerCd+" : "+headerMsg;
						}); */
						 $(data).find('itemList').each(function(){
								 var tmp_title = '';
							     index2 = index2 + 1; 
								if(index2 < 2){
								$(data).find('pathList').each(function(){
								 var fid = $(this).find('fid').text();
									var fname = $(this).find('fname').text();
									var routeNm = $(this).find('routeNm').text();
									var tid = $(this).find('tid').text();
									var tname = $(this).find('tname').text();
									if(firstLo == null){
										firstLo = fid;
										title2='<h1>'+fname+'→'+tname + '</h1>';
										tmp_title= '<h1>'+fname+'→';
										htmlstr2 += '<h5> 탑승지 id: '+ fid +'&nbsp;'
										+'탑승지 명: '+ fname +'&nbsp;'
										+' 지하철: '+ routeNm +'&nbsp;'
										+' 하차지 ID : '+ tid +'&nbsp;'
										+'하차지명 : '+ tname +'</h5>';
										console.log(firstLo);
									}
								else if(fid == firstLo){
								 	return false;
								}else{
									title2 = tmp_title+tname + '</h1>';
									htmlstr2 += '<h4>환승</h4>'
									+'<h5> 환승역 id: '+ fid +'&nbsp;'
									+'환승역명: '+ fname +'&nbsp;'
									+'환승할 지하철: '+ routeNm +'&nbsp;'
									+'하차지 ID : '+ tid +'&nbsp;'
									+'하차지명 : '+ tname +'</h5>';
								}
								  
							});
								
							 var time = $(this).find('time').text();
							 htmlstr2 += '<h2> 총시간 :'+time +' 분</h2>'; 
							}//end if	
						 }); 
						 $('body').append(title2);
						 $('body').append(htmlstr2);
					},
					error : function() {
						alert("error");
					}
				});  
		}//end of function
	</script>

</body>