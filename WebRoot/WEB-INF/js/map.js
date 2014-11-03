/**
 * 腾讯地图api
 */

var geolocation,map,marker = null;
var init = function() {
    var center = new soso.maps.LatLng(36.61293250338431,114.49573324487278);
    map = new soso.maps.Map(document.getElementById('mapContainer'),{
        center: center,
        zoomLevel: 13
    });
    geolocation = new soso.maps.Geolocation();
    geolocation.position({}, function(results, status) {
        var city = document.getElementById("city");
        if (status == soso.maps.GeolocationStatus.OK) {
            map.setCenter(results.latLng);
            city.style.display = 'inline';
            city.innerHTML = '所在位置: ' + results.name;
            if (marker != null) {
                marker.setMap(null);
            }
            marker = new soso.maps.Marker({
                map: map,
                position:results.latLng
            });
        } else {
            alert("检索没有结果，原因: " + status);
        }
    });
    var zoomControl = new soso.maps.ZoomHintControl({map:map});
    var maptypectrl = new soso.maps.MapTypeControl({map:map});
    var navControl = new soso.maps.NavigationControl({
        align: soso.maps.ALIGN.TOP_LEFT,
        margin: new soso.maps.Size(5, 15),
        map: map
    });
    soso.maps.Event.addListener(map, 'click', function(event) {
        document.getElementById("latLng").value = event.latLng.getLat() + ',' + event.latLng.getLng();
    });
}