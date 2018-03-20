module ProductsHelper
    def render_description_format(product)        
        simple_format(product.description)        
    end
    #如果型號件數為0 則會新增以下的style
    def render_nosize_line(size)
        if size.to_i == 0
            "old"
        end
    end
    def render_product_image(product)
        url = product.image.file.present? ? product.image_url : "http://placehold.it/200x200&text=No Pic"
        image_tag(url)
    end
end
