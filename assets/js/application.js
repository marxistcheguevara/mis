$(function(){
    
    $( window ).load(function() {
        $("#k-notifications .k-load-content").load("fragments/notifications.html");
        $("#k-notifications .k-loader").delay(500).fadeOut();


        $(".k-c .k-inp").each(function(){
            size = $(this).attr("data-size");
            $(this).css({'width':(size*11.3)+'px'});
        });

        // BURDA SEHIFE YUKLENEN KIMI #k-manual BLOKUNA BUTUN MANUALLAR;N SIYAHISI YUKLENIR
        $("#k-manual").load("fragments/manuals.html");
    });
    
    $(document).on("click","#k-manual .k-manuals-list li", function(){
        manualID = $(this).attr("id");
        // $_GET['id'] GONDERILEN FAYLI BURDAN DEYISE BILERSEN
        $("#k-manual").load("fragments/manual-childs.php/?id="+manualID);
    });

        // BURDA .k-back-manuals DUYMESI BASILANDA #k-manual BLOKUNA BUTUN MANUALLAR;N SIYAHISI YUKLENIR
    $(document).on("click","#k-manual .k-back-manuals", function(){
        $("#k-manual").load("fragments/manuals.html");
    });

    $("input[type=text].k-manual, textarea.k-manual").droppable({
        drop: function(event, ui){
            text = $(ui.draggable).find("p").text();
            $(this).val(text);
        }
    });

    $("input[type=text].k-manual, textarea.k-manual").click(function(){
        id = $(this).attr("data-manualid");
        field = $(this);
        $("#k-manual #"+id).click();
        $(document).on("dblclick","#k-manual .k-manuals-list li",function(){
            field.val($(this).find("p").text());
        });
    });



    notifications_interval = window.setInterval(function(){
        $("#k-notifications .k-loader").delay(500).fadeIn();
        $("#k-notifications .k-load-content").load("fragments/notifications.html");
        $("#k-notifications .k-loader").delay(500).fadeOut();
    }, $("#k-notifications").attr("data-delay"));
    
    
    $(".k-persons-list ul li").click(function(){
        id = $(this).attr("data-id");
        selected_person = $.trim($(this).text());
        $(this).parents(".k-person").first().find(".k-person-name input").val(id);
        $(this).parents(".k-person").first().find(".k-person-name .k-selected-person").text(selected_person);
    });
    
    $(".k-person-name  .k-reset").click(function(){
        $(this).parents(".k-person-name").first().find("input").val("");  
        $(this).parents(".k-person-name").first().find(".k-selected-person").text("Person not selected yet");  
    });
    
});