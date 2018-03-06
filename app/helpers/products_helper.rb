module ProductsHelper
    def description_format(product)        
        simple_format(product.description)        
    end
    #如果型號件數為0 則會新增以下的style
    def render_nosize_line(size)
        if size.to_i == 0
            "old"
        end
    end
end
