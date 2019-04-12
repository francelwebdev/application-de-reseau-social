class PagesController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :lutilisateur_connecte_doit_pas_voir_la_landing_page, only: :landing_page

    def landing_page
        # expires_in 3.days, public: false, must_revalidate: true
    end
    
    def home
        
    end

    def terms_of_use
        
    end

    def privacy_policy
        
    end

    private

    def lutilisateur_connecte_doit_pas_voir_la_landing_page
        if user_signed_in?
            flash[:notice] = "Vous êtes déja connecté !"
            redirect_to questions_path
        end
    end

end
