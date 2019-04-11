module ApplicationHelper

    # Mon code
    include Pagy::Frontend
    
        # Pour afficher les formulaires de de la gem devise dans une fenêtre modal.
        def resource_name
            :user
        end

        def resource
            @resource ||= User.new
        end

        def resource_class
            User
        end

        def devise_mapping
            @devise_mapping ||= Devise.mappings[:user]
        end
        # Pour afficher les formulaires de de la gem devise dans une fenêtre modal.

        def custom_bootstrap_flash
          flash_messages = []
          flash.each do |type, message|
            type = 'success' if type == 'notice'
            type = 'error'   if type == 'alert'
            text = "<script>toastr.#{type}('<h6>#{message}</h6>');</script>"
            flash_messages << text.html_safe if message
        end
        flash_messages.join("\n").html_safe
    end
    # Mon code
    
end
