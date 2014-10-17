$(function(){
    $("#nav ul li").click(function () {

       $(this).attr("class", "active").attr("style","").siblings().attr("class", "");

    });
});
