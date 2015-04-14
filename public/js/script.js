$(document).ready(function () {

    //Custom select box
    $("#select-text, #select-button").click(function () {
        $(this).parent().find("ul").toggleClass("open");
    })

    $("ul.select-menu li").click(function () {
        var currentText = $(this).text();
        $("#select-text").html(currentText);
        $(this).parent().removeClass("open");
    })


    function footer() {
        if ($(window).height() > $('body').height()) {
            var extra = $(window).height() - $('body').height();
            $('.bottom').css('margin-top', extra);
        }
    }

    footer();


})