/**
 * 
 */

$(".fixed-table-header-columns").on("click", "th div.sortable", function() {
            var sibling = $(this).parent().siblings().find("div.sortable")
            if (!$(this).hasClass("asc") && !$(this).hasClass("desc")) {
                sibling.removeClass("asc desc")
                $(this).addClass("desc")
            } else if ($(this).hasClass("asc")) {
                sibling.removeClass("asc desc")
                $(this).removeClass("asc desc").addClass("desc")
            } else if ($(this).hasClass("desc")) {
                sibling.removeClass("asc desc")
                $(this).removeClass("asc desc").addClass("asc")
            }
        })
         $(".fixed-table-header").on("click", "th div.sortable", function() {
            $(".fixed-table-header-columns th div.sortable").removeClass("asc desc")
        }) 