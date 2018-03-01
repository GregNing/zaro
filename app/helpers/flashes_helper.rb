module FlashesHelper
    FLASH_CLASS = {alert: "danger", notice: "success", warning: "warning"}
    ICON_CLASS = {alert: "error_outline",notice: "check",warning: "warning" }
    def flash_class(key)
        FLASH_CLASS.fetch key.to_sym, key
    end

    def metion_flashes
        flash.to_hash.slice "alert", "notice", "warning"
    end

    def icons_flashes(key)
        ICON_CLASS[key.to_sym]        
    end
end