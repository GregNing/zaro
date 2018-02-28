module FlashesHelper
    FLASH_CLASS = {alert: "danger", notice: "success", warning: "warning"}
    def flash_class(key)
        FLASH_CLASS.fetch key.to_sym, key
    end

    def metion_flashes
        flash.to_hash.slice "alert", "notice", "warning"
    end
end