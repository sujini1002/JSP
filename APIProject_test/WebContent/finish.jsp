<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e0a111ce3956b96d4feac576beb420c&libraries=services,clusterer,drawing"></script>
    <title>주소로 장소 표시하기</title>

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
<input type="button" onclick="route()" value="최소환승">
<br>
<div id="map"
     style="width: 800px; height: 500px; margin-top: 10px; display: none"></div>

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
    var coordsY=[];
    // 주소좌표의 x값을 담을 배열을 선언
    var coordsX=[];

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
                    geocoder.addressSearch(data.address, function(
                        results, status) {
                        // 정상적으로 검색이 완료됐으면
                        if (status === daum.maps.services.Status.OK) {

                            var result = results[0]; //첫번째 결과의 값을 활용

                            // 해당 주소에 대한 좌표를 받아서
                            coords = new daum.maps.LatLng(result.y,
                                result.x);
                            var y = result.y;
                            var x = result.x;


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
                            for(var i=0;i<coordsArray.length;i++){
                                marker = new daum.maps.Marker({
                                    map: map,   // 마커를 표시할 지도
                                    position: coordsArray[i] // 마커 위치
                                });
                            }

                            console.log(coordsArray);

                            //좌표계 변환후에 가까운 지하철 주소값 받아오는 것.
                            var geocoder = new daum.maps.services.Geocoder(), // 좌표계 변환 객체를 생성합니다
                                wgsX = x, // 변환할 WGS84 X 좌표 입니다
                                wgsY = y; // 변환할 WGS84 Y 좌표 입니다

                            // WGS84 좌표계의 좌표를 WTM계의 좌표로 변환합니다
                            geocoder.transCoord(wgsX, wgsY, transCoordCB, {
                                input_coord: daum.maps.services.Coords.WGS84, // 변환을 위해 입력한 좌표계 입니다
                                output_coord: daum.maps.services.Coords.WTM // 변환 결과로 받을 좌표계 입니다
                            });




                        }
                    });
                }
            }
            ).open();
    }

	
    function find(){
        if(coordsArray.length != 2){
            alert("주소가 두개가 아님");
            //
        } else{
            // 좌표를 정수형으로 바꿔주기 위해 1을 곱해줍니다
            var y1 = coordsY[0] * 1;
            console.log("y1은"+y1);
            var y2 = coordsY[1] * 1;

            var x1 = coordsX[0] * 1;
            var x2 = coordsX[1] * 1;

            // y좌표와 x좌표의 중간을 구해서
            var newPosLat = ((y1 + y2) / 2).toFixed(4);
            console.log(newPosLat);
            var newPosLng = ((x1 + x2) / 2).toFixed(4);
			

            geocoder.transCoord(newPosLng, newPosLat, transCoordCB, {
                input_coord: daum.maps.services.Coords.WGS84, // 변환을 위해 입력한 좌표계 입니다
                output_coord: daum.maps.services.Coords.WTM // 변환 결과로 받을 좌표계 입니다
            });


        }


    }


    function transCoord(result, status) {
        console.log(result[0].x);
        console.log(result[0].y);
        coordsY.push(result[0].y); //지하철 y좌표
        coordsX.push(result[0].x);//지하철 x좌표
		console.log(coordsX.length)
        if(coordsX.length==3){
            console.log('dd')
            var newLocation = new daum.maps.LatLng(coordsY[2],//y
                coordsX[2]);//x

            coordsArray.push(newLocation);
            console.log(coordsArray);

            // 새 마커를 구합니다.
            marker = new daum.maps.Marker({
                map: map,   // 마커를 표시할 지도
                position: newLocation
            });

            // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
            var bounds = new daum.maps.LatLngBounds();

            for (var j = 0; j < coordsArray.length; j++) {
                // LatLngBounds 객체에 좌표를 추가합니다
                bounds.extend(coordsArray[j]);
            }
            // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
            // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
            map.setBounds(bounds);    // 좌표배열을 비워줍니다.


        }

    }



    //
    // 좌표 변환 결과를 받아서 처리할 콜백함수 입니다.
    function transCoordCB(result, status) {

        $
            .ajax({//변활된 wtm 좌표 값으로 지하철역의 정보를 가져온다.
                url: 'http://swopenAPI.seoul.go.kr/api/subway/576544706e7061723236417a625270/json/nearBy/0/1/'+result[0].x+'/'+result[0].y,
                success: function (data) {
                    $(data.stationList).each(function(key, value){
                        console.log(value.statnNm);
                        console.log(value.subwayNm);
                       
                        //가장 가까운 지하철 역의 wtm 좌표의 값을 wgs84좌표 값으로 변환
                        geocoder.transCoord(value.subwayXcnts, value.subwayYcnts, transCoord, {
                            input_coord: daum.maps.services.Coords.WTM, // 변환을 위해 입력한 좌표계 입니다
                            output_coord: daum.maps.services.Coords.WGS84 // 변환 결과로 받을 좌표계 입니다
                            	
                        });
                    });

                },
                error: function () {
                    alert("error");
                }
            });
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
        console.log(coordsArray[2].ib);
        console.log(coordsArray[2].jb);
        $.ajax({

            url : "http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoBySubway?ServiceKey=XqhcB%2B4O4FdfcQVx9UB21n%2BiIB6FAtEwCHvQaY7Nxuk33dr9vyrlczOvLH2cr8hwaPK1yP%2FYC7u7tw1MzbhNNw%3D%3D&startX="
                + coordsX[0]
                + "&startY="
                + coordsY[0]
                + "&endX="
                + coordsX[2] //중간위치
                + "&endY="
                + coordsY[2], //중간위치
            success : function(data) {
                var firstLo = null;
                var wifiSta = 
                 $(data).find('msgHeader').each(function(){
                   var headerCd = $(this).find('headerCd').text();
                   var headerMsg = $(this).find('headerMsg').text();
                   htmlstr += headerCd+" : "+headerMsg;
                }); 
                $(data).find('itemList').each(function(){
                    var tmp_title = '';
                    index = index+1;
                    if(index<2){
                        $(data).find('pathList').each(function(){

                            var fid = $(this).find('fid').text();
                            var fname = $(this).find('fname').text();
                            var routeNm = $(this).find('routeNm').text();
                            var tid = $(this).find('tid').text();
                            var tname = $(this).find('tname').text();
                            
                            if(firstLo == null){
                                firstLo = fname;
                                wifi(fname);
                                wifi(tname);
                                title='<h1>'+fname+'→'+tname + '</h1>';
                                tmp_title= '<h1>'+fname+'→';
                                //함수호출
                                htmlstr += printRoute(fid,fname,routeNm,tid,tname);
                            }
                            else if(fname == firstLo){
                                return false;
                            }else{
                            	wifi(tname);
                                title = tmp_title+tname + '</h1>';
                                //함수호출
                                htmlstr += twoPrintRoute(fid,fname,routeNm,tid,tname);
                            }

                        });
                        var time = $(this).find('time').text();
                        htmlstr += '<h2> 총시간 :'+time +' 분</h2>';
                    }//end if
                });
                $('body').append(title);
                $('body').append(htmlstr);
            },
            error : function() {
                alert("error");
            }
        });


        $.ajax({
            url : "http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoBySubway?ServiceKey=XqhcB%2B4O4FdfcQVx9UB21n%2BiIB6FAtEwCHvQaY7Nxuk33dr9vyrlczOvLH2cr8hwaPK1yP%2FYC7u7tw1MzbhNNw%3D%3D&startX="
                + coordsX[1]
                + "&startY="
                + coordsY[1]
                + "&endX="
                + coordsX[2] //중간위치
                + "&endY="
                + coordsY[2],
            success : function(data) {
                var firstLo = null;
                 $(data).find('msgHeader').each(function(){
                   var headerCd = $(this).find('headerCd').text();
                   var headerMsg = $(this).find('headerMsg').text();
                   htmlstr2 += headerCd+" : "+headerMsg;
                }); 
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
                            	wifi(fname);
                            	wifi(tname);
                                firstLo = fname;
                                title2='<h1>'+fname+'→'+tname + '</h1>';
                                 tmp_title= '<h1>'+fname+'→';
                              	//함수호출
                                htmlstr2 += printRoute(fid,fname,routeNm,tid,tname);
                            }
                            else if(fname == firstLo){
                                return false;
                            }else{
                            	wifi(tname);
                                title2 = tmp_title+tname + '</h1>';
                                //함수호출
                                htmlstr2 += twoPrintRoute(fid,fname,routeNm,tid,tname);
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
        /* coordsY=[];
        coordsX=[]; */ 

    }//end of function
    function printRoute(fid,fname,routeNm,tid,tname){
    	return '<h5> 탑승지 id: '+ fid +'&nbsp;'
        +'탑승지 명: '+ fname +'&nbsp;'
        +' 지하철: '+ routeNm +'&nbsp;';
        +' 하차지 ID : '+ tid +'&nbsp;'
        +'하차지명 : '+ tname +'</h5>'
        
    }
    function twoPrintRoute(fid,fname,routeNm,tid,tname){
    	return '<h4>환승</h4>'
        +'<h5> 환승역 id: '+ fid +'&nbsp;'
        +'환승역명: '+ fname +'&nbsp;'
        +'환승할 지하철: '+ routeNm +'&nbsp;'
        +'하차지 ID : '+ tid +'&nbsp;'
        +'하차지명 : '+ tname +'</h5>';
    }
     function wifi(fname){
    	 fname = fname.substring(0,fname.length-1);
    	var servicekey = "667849734474676932356563715066";
    	
		$.ajax({
			url : 'http://swopenAPI.seoul.go.kr/api/subway/'+servicekey+'/xml/stationWifi/0/150/'+fname,
			success : function(data){
				var company = null;
				var htmlstr = '';
				var cnt = 0;
				console.log(data);
				$(data).find('row').each(function(){
					var statnNm = $(this).find('statnNm').text(); //지하철역 명
					var subwayNm = $(this).find('subwayNm').text(); //지하철 명
					var telecomSsid = $(this).find('telecomSsid').text(); //Ssid 등록 통신사
					var signalStrength =  $(this).find('signalStrength').text(); //신호 세기
					if(company == null){
						htmlstr += '<h4>'+statnNm+'</h4>';
						htmlstr += printWifi(statnNm,subwayNm,telecomSsid,signalStrength);
						company = telecomSsid.substring(0,1);
						console.log("company == null일때 :  "+company);
						cnt++;
					}else if(company != telecomSsid.substring(0,1) ){
						htmlstr += printWifi(statnNm,subwayNm,telecomSsid,signalStrength);
						company = telecomSsid.substring(0,1);
						console.log("company != telecomSsid : "+company);
						cnt++;
					}
					if(cnt ==3){
						return false;
					}
					
				});
				$('body').append(htmlstr);
			},
		 error : function(){alert("error");}
		});//end ajax
		
	} 
     function printWifi(statnNm,subwayNm,telecomSsid,signalStrength){
    		return '<h5>'
    		 +'지하철 호선 : ' + subwayNm + '&nbsp;'
    		 +'통신사 : ' + telecomSsid + '&nbsp;'
    		 +'신호세기 : ' + signalStrength + '&nbsp;'
    		 +'</h5>';
    }
	
</script>
</body>
</html>