class PagesController < ApplicationController
    skip_before_action :authenticate_user!

    def landing_page
        # expires_in 3.days, public: false, must_revalidate: true
    end
    
    def home
        
    end

    def terms_of_use
        
    end

    def privacy_policy
        
    end

end
