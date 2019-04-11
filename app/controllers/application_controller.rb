class ApplicationController < ActionController::Base
    include Pagy::Backend
    protect_from_forgery with: :exception

    before_action :set_locale, :je_veux_rendre_cette_variable_dinstance_disponible_partout
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    def default_url_options
        { locale: I18n.locale }
    end

    def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
    end

    def je_veux_rendre_cette_variable_dinstance_disponible_partout
        if user_signed_in?
            @question = current_user.questions.build
            @tout_les_questions = Question.count
            @tout_les_reponses = Answer.count
            @les_utilisateurs_recents = User.with_attached_profile_picture.includes(:questions).order(created_at: :desc).limit(5)
        else
            nil
        end
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, company_attributes: [:company_name]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :profile_picture, :about, :phone_number, :city])
end

end
