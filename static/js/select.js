(function($){    
    jQuery.fn.select = function(options){  
        return this.each(function(){  
            var $this = $(this);  
            var $select_option = $this.find(".selectOption");  
            var $select_menu = $this.find(".selectMenu");  
            var $select_li = $this.find("ul > li");						
            $this.click(function(e){        
                $select_menu.toggleClass("dis");  
                e.stopPropagation();  
            });               
            $select_li.bind("click",function(){  
                var $this_ = $(this);                    
                $select_option.removeClass('op')
                $select_option.text($this_.text());  
            });                           
        });         
    }        
})(jQuery); 