<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e0a111ce3956b96d4feac576beb420c&libraries=services,clusterer,drawing"></script>
    <title>주소로 장소 표시하기</title>
</head>
<body>
<input type="text" id="name" placeholder="이름을 넣어주세요">
<input type="text" id="roadColor" placeholder="ex)빨강색"/>
<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
<input type="button" onclick="find()" value="찾기">
<input type="button" onclick="route()" value="최소환승">
<input type="button" onClick="window.location.reload()" value="지우기">

<br>
<div id="map" style="width: 800px; height: 500px; margin-top: 10px; display: none"></div>
<div id="weather" style="width: 800px; height: 500px; margin-top: 10px; border:1px solid black"></div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
   //지도 관련 초기화 
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
    
    
    
    
    // 주소 좌표를 담을 변수를 선언합니다
    var coords;
    // 검색된 주소 좌표를 담을 배열을 선언합니다
    var coordsArray = [];
    //이름을 담을 배열 선언
    var nameArray=[];
    // 주소좌표의 y값을 담을 배열을 선언
    var coordsY=[];
    // 주소좌표의 x값을 담을 배열을 선언
    var coordsX=[];
    
    //길 색 저장할 배열 선언
   var roadColor=[];
   var rRoadColor=[];
   //JSON형식 받아옴
   var jsondata={};
    
   // 기상청 좌표로 변환한 값을 담을 변수
    var iby;
    var jbx;
    
   // 현재일시를 받아와서 년월일시 분리
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1;
    var yyyy = today.getFullYear();
    var hours = today.getHours();
    var minutes = today.getMinutes();

     if(minutes < 40){
        // 40분보다 작으면 한시간 전 값. 날씨실황이 매시간 40분 이후 제공됨.
        hours = hours - 1;
        if(hours < 0){
            // 자정 이전은 전날로 계산
            today.setDate(today.getDate() - 1);
            dd = today.getDate();
            mm = today.getMonth()+1;
            yyyy = today.getFullYear();
            hours = 23;
        }
    }
    if(hours<10) {
        hours='0'+hours
    }
    if(mm<10) {
        mm='0'+mm
    }
    if(dd<10) {
        dd='0'+dd
    } 
    
    // url에 넣기 위해 현재일시를 스트링타입으로 변환
    yyyy=yyyy.toString();
    mm=mm.toString();
    dd=dd.toString();
    hours=hours.toString();
    minutes=minutes.toString();
    
    // 기본 url
   var base_url='http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastGrib';
   // 인증키
   var wServiceKey='O1sPvpMUcFjQ7E%2FxOtJ%2F6q7YR%2Bt9BCgA5VQFtgVKyLZpx67SlvXQ2ll3IJmks%2BGOlfgko0xFqfUS3ih530gupg%3D%3D';
   // 년월일
   var base_date=yyyy+mm+dd;
   // 시
   var base_time=hours+minutes;
    
    //ajax url을 저장하는 부분
    //인근 지하철역을 찾아주는 api url과 서비스 키
    var subwayLocKey = 'http://swopenAPI.seoul.go.kr/api/subway/576544706e7061723236417a625270/json/nearBy/0/1/';
    //최소 환승 경로를 알려주는 api url과 서비스 키
    var routeUrl = 'http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoBySubway?ServiceKey=XqhcB%2B4O4FdfcQVx9UB21n%2BiIB6FAtEwCHvQaY7Nxuk33dr9vyrlczOvLH2cr8hwaPK1yP%2FYC7u7tw1MzbhNNw%3D%3D&';

    // 주소로 좌표를 검색합니다
    function sample5_execDaumPostcode() {
        new daum.Postcode(
            {
                oncomplete : function(data) {
                    if(document.getElementById("name").value==''){
                        nameArray.push('아무개');
                        roadColor.push(document.getElementById("roadColor").value); 
                    }else{
                        nameArray.push(document.getElementById("name").value); 
                    }
                    // 주소로 상세 정보를 검색
                    geocoder.addressSearch(data.address, function(
                        results, status) {
                        // 정상적으로 검색이 완료됐으면
                        if (status === daum.maps.services.Status.OK) {

                            var result = results[0]; //첫번째 결과의 값을 활용

                            // 해당 주소에 대한 좌표를 받아서
                            coords = new daum.maps.LatLng(result.y,result.x);
                            var y = result.y;
                            var x = result.x;
                            
                            coordsArray.push(coords);
                            // 지도를 보여준다.
                            mapContainer.style.display = "block";
                            map.relayout();

                            //marker.setPosition(coords);

                            // 마커를 생성
                            for(var i=0;i<coordsArray.length;i++){
                                marker = new daum.maps.Marker({
                                    map: map,   // 마커를 표시할 지도
                                    position: coordsArray[i]// 마커 위치

                                });
                                var infowindow = new daum.maps.InfoWindow({
                                    content : '<div style="padding:5px;">'+nameArray[i]+'</div>' // 인포윈도우에 표시할 내용
                                });

                                // 인포윈도우를 지도에 표시한다
                                infowindow.open(map, marker);
                            }
                            // 지도 중심을 변경한다.
                            map.setCenter(coords);
                            // 마커를 결과값으로 받은 위치로 옮긴다.
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
            }).open();
    }



    function find(){
        if(coordsArray.length != 2){
            alert("주소가 두개가 아님");
        } else{
            // 좌표를 정수형으로 바꿔주기 위해 1을 곱해줍니다
            var y1 = coordsY[0] * 1;
            var y2 = coordsY[1] * 1;
            console.log("y1은"+y1);

            var x1 = coordsX[0] * 1;
            var x2 = coordsX[1] * 1;

            // y좌표와 x좌표의 중간을 구해서
            var newPosLat = ((y1 + y2) / 2).toFixed(4);
            var newPosLng = ((x1 + x2) / 2).toFixed(4);
            console.log(newPosLat);


            geocoder.transCoord(newPosLng, newPosLat, transCoordCB, {
                input_coord: daum.maps.services.Coords.WGS84, // 변환을 위해 입력한 좌표계 입니다
                output_coord: daum.maps.services.Coords.WTM // 변환 결과로 받을 좌표계 입니다
            });
          //길 색 저장            
            $.ajax({           
             url:'papago.jsp?id='+ roadColor,
             success: function(data){
                jsondata = JSON.parse(data.trim());
                rRoadColor = jsondata.message.result.translatedText.split(',');
                if(rRoadColor.length==2){
                   rRoadColor[0] = rRoadColor[0].toLowerCase().trim();
                   rRoadColor[1] = rRoadColor[1].toLowerCase().trim();
                }
             }
          });
        }
    }


    function transCoord(result, status) {
        console.log(result[0].x);
        console.log(result[0].y);
        coordsY.push(result[0].y); //지하철 y좌표
        coordsX.push(result[0].x);//지하철 x좌표
        console.log(coordsX.length);
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
            var infowindow = new daum.maps.InfoWindow({
                content : '<div style="padding:5px;">여기가 중간!</div>' // 인포윈도우에 표시할 내용
            });

            // 인포윈도우를 지도에 표시한다
            infowindow.open(map, marker);
            // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
            var bounds = new daum.maps.LatLngBounds();

            for (var j = 0; j < coordsArray.length; j++) {
                // LatLngBounds 객체에 좌표를 추가합니다
                bounds.extend(coordsArray[j]);
            }
            // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
            // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
            map.setBounds(bounds);    // 좌표배열을 비워줍니다.

            // 여기부터 날씨
            
            iby = coordsY[2]*1;
            jbx = coordsX[2]*1;
            var rs = dfs_xy_conv("toXY",iby,jbx);
            console.log(rs.x, rs.y);
            
           var nx=rs.x;
           var ny=rs.y;
           
           var fUrl = base_url+'?ServiceKey='+wServiceKey+'&base_date='+base_date+'&base_time='+base_time+'&nx='+nx+'&ny='+ny;

           $.ajax({
              url: fUrl,
              success: function(data){
                 console.log(data);
                 $(data).find('item').each(function(){
                 
                    // 하늘상태:맑음.구름조금.구름많음.흐림
                    if(($(this).find('category').text())=='SKY'){
                       var sky = $(this).find('obsrValue').text();
                       
                       if(sky==1) {$('#weather').append('<h2>하늘상태 : 맑음</h2>');}
                       if(sky==2) {$('#weather').append('<h2>하늘상태 : 구름조금</h2>');}
                       if(sky==3) {$('#weather').append('<h2>하늘상태 : 구름많음</h2>');}
                       if(sky==4) {$('#weather').append('<h2>하늘상태 : 흐림</h2>');}
                    }
                    
                    // 강수상태 : 없음.비.비/눈.눈
                    if(($(this).find('category').text())=='PTY'){
                       var sky = $(this).find('obsrValue').text();
                       
                       if(sky==0) {$('#weather').append('<h2>강수상태 : 없음</h2>');}
                       if(sky==1) {$('#weather').append('<h2>강수상태 : 비</h2>');}
                       if(sky==2) {$('#weather').append('<h2>강수상태 : 비/눈</h2>');}
                       if(sky==3) {$('#weather').append('<h2>강수상태 : 눈</h2>');}
                    }
                    
                    // 최신기온
                    if(($(this).find('category').text())=='T1H'){
                       var temp = $(this).find('obsrValue').text();
                       
                       $('#weather').append('<h2>현재 기온 : '+temp+'℃</h2>');
                    }
                 });
              }
           });
        }

    }
    // 좌표 변환 결과를 받아서 처리할 콜백함수 입니다.
    // result로 해당 위치의 좌표를 받아와서 인근 지하철역 정보를 반환하는 함수이다.
    function transCoordCB(result, status) {

        $.ajax({//변활된 wtm 좌표 값으로 지하철역의 정보를 가져온다.
                url: subwayLocKey+result[0].x+'/'+result[0].y,
                success: function (data) {
                    console.log(data);
                    $(data.stationList).each(function(key, value){
                        console.log(value.statnNm);
                        console.log(value.subwayNm);
                        //가장 가까운 지하철 역의 wtm 좌표의 값을 wgs84좌표 값으로 변환
                        //최소환승(route())에 필요한 좌표를 받기위해 처리
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
        console.log(coordsArray[1].ib);
        console.log(coordsArray[1].jb);
        $.ajax({

            url : routeUrl + "startX="+coordsX[0] + "&startY=" + coordsY[0]+ "&endX=" + coordsX[2] + "&endY="  + coordsY[2],
            success : function(data) {
                var firstLo = null;
                 $(data).find('msgHeader').each(function(){
                   var headerMsg = $(this).find('headerMsg').text();
                   htmlstr += headerMsg;
                }); 
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
                                firstLo = fname;
                                //와이파이 정보 호출 하는 문장
                                wifi(fname);
                               wifi(tname);
                                title='<h1>'+fname+'→'+tname + '</h1>';
                                tmp_title= '<h1>'+fname+'→';
                                htmlstr += printRoute(fid,fname,routeNm,tid,tname);
                            }
                            else if(fname == firstLo){
                                return false;
                            }else{
                               //와이파이 정보 호출 하는 문장
                               wifi(tname);
                                title = tmp_title+tname + '</h1>';
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
            url :routeUrl + "startX="+coordsX[1] + "&startY=" + coordsY[1]+ "&endX=" + coordsX[2] + "&endY="  + coordsY[2],
            success : function(data) {
                var firstLo = null;
                $(data).find('msgHeader').each(function(){
                    var headerCd = $(this).find('headerCd').text();
                    var headerMsg = $(this).find('headerMsg').text();
                    htmlstr += headerCd+" : "+headerMsg;
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
                                firstLo = fname;
                                //와이파이 정보 호출 하는 문장
                                wifi(fname);
                               wifi(tname);
                                title2='<h1>'+fname+'→'+tname + '</h1>';
                                tmp_title= '<h1>'+fname+'→';
                                htmlstr2 += printRoute(fid,fname,routeNm,tid,tname);
                                console.log(firstLo);
                            }
                            else if(fname == firstLo){
                                return false;
                            }else{
                               //와이파이 정보 호출 하는 문장
                               wifi(tname);
                                title2 = tmp_title+tname + '</h1>';
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
        if (coordsX.length==3){
            //02,12끼리 해줘야함
            var firstCenterLinePath = [
                new daum.maps.LatLng(coordsY[0],coordsX[0]),
                new daum.maps.LatLng(coordsY[2],coordsX[2])
            ];
            var lastCenterLinePath = [
                new daum.maps.LatLng(coordsY[1],coordsX[1]),
                new daum.maps.LatLng(coordsY[2],coordsX[2])
            ];
            var polylineFirst = new daum.maps.Polyline({
                path: firstCenterLinePath, // 선을 구성하는 좌표배열 입니다
                strokeWeight: 5, // 선의 두께 입니다
                strokeColor:rRoadColor[0], // 선의 색깔입니다
                strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'longdashdotdot' // 선의 스타일입니다
            });
            var polylineLast = new daum.maps.Polyline({
                path: lastCenterLinePath, // 선을 구성하는 좌표배열 입니다
                strokeWeight: 5, // 선의 두께 입니다
                strokeColor:rRoadColor[1], // 선의 색깔입니다
                strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'shortdash' // 선의 스타일입니다
            });
            // 지도에 선을 표시합니다
            polylineFirst.setMap(map);
            polylineLast.setMap(map);
        }
        coordsY=[];
        coordsX=[];

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
            $(data).find('row').each(function(){
               var statnNm = $(this).find('statnNm').text(); //지하철역 명
               var subwayNm = $(this).find('subwayNm').text(); //지하철 명
               var telecomSsid = $(this).find('telecomSsid').text(); //Ssid 등록 통신사
               var signalStrength =  $(this).find('signalStrength').text(); //신호 세기
               if(company == null){
                  htmlstr += '<h4>'+statnNm+'</h4>';
                  htmlstr += printWifi(statnNm,subwayNm,telecomSsid,signalStrength);
                  company = telecomSsid.substring(0,1);
                  cnt++;
               }else if(company != telecomSsid.substring(0,1) ){
                  htmlstr += printWifi(statnNm,subwayNm,telecomSsid,signalStrength);
                  company = telecomSsid.substring(0,1);
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
    
    
    //날씨 알려주는 부분
    
    
    // LCC DFS 좌표변환을 위한 기초 자료
    var RE = 6371.00877; // 지구 반경(km)
    var GRID = 5.0; // 격자 간격(km)
    var SLAT1 = 30.0; // 투영 위도1(degree)
    var SLAT2 = 60.0; // 투영 위도2(degree)
    var OLON = 126.0; // 기준점 경도(degree)
    var OLAT = 38.0; // 기준점 위도(degree)
    var XO = 43; // 기준점 X좌표(GRID)
    var YO = 136; // 기1준점 Y좌표(GRID)


	
    function dfs_xy_conv(code, v1, v2) {
        var DEGRAD = Math.PI / 180.0;
        var RADDEG = 180.0 / Math.PI;

        var re = RE / GRID;
        var slat1 = SLAT1 * DEGRAD;
        var slat2 = SLAT2 * DEGRAD;
        var olon = OLON * DEGRAD;
        var olat = OLAT * DEGRAD;

        var sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
        var sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
        var ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
        ro = re * sf / Math.pow(ro, sn);
        var rs = {};
        if (code == "toXY") {
            rs['lat'] = v1;
            rs['lng'] = v2;
            var ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
            ra = re * sf / Math.pow(ra, sn);
            var theta = v2 * DEGRAD - olon;
            if (theta > Math.PI) theta -= 2.0 * Math.PI;
            if (theta < -Math.PI) theta += 2.0 * Math.PI;
            theta *= sn;
            rs['x'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
            rs['y'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
        }
        else {
            rs['x'] = v1;
            rs['y'] = v2;
            var xn = v1 - XO;
            var yn = ro - v2 + YO;
            ra = Math.sqrt(xn * xn + yn * yn);
            if (sn < 0.0) - ra;
            var alat = Math.pow((re * sf / ra), (1.0 / sn));
            alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

            if (Math.abs(xn) <= 0.0) {
                theta = 0.0;
            }
            else {
                if (Math.abs(yn) <= 0.0) {
                    theta = Math.PI * 0.5;
                    if (xn < 0.0) - theta;
                }
                else theta = Math.atan2(xn, yn);
            }
            var alon = theta / sn + olon;
            rs['lat'] = alat * RADDEG;
            rs['lng'] = alon * RADDEG;
        }
        return rs;
    }
</script>
</body>
</html>