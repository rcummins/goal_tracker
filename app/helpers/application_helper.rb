module ApplicationHelper
    def insert_form_authenticity_token
        html = "<input type=\"hidden\" "
        html += "name=\"authenticity_token\" "
        html += "value=\"#{form_authenticity_token}\">"

        return html.html_safe
    end
    
    def login_and_signup_buttons
        html = "<form action=#{new_session_url} method=\"get\">"
        html += "<input type=\"submit\" value=\"Log in\">"
        html += "</form>"
        html += "<form action=#{new_user_url} method=\"get\">"
        html += "<input type=\"submit\" value=\"Sign up\">"
        html += "</form>"

        return html.html_safe
    end
end
