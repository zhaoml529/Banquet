$(function(){

    $("ul[class*=pagination] li:nth-child(2)").attr("class", "active");
    $("#down").click(function(){
        $("ul[class*=pagination] li[class*=active]").parent().next().attr("class", "active");
    });
    $("ul[class*=nav] li").click(function () {
        var daohang = $(this);
        daohang.attr("class", "active").attr("style","").siblings().attr("class", "");
    });
});