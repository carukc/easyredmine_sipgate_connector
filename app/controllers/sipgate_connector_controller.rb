class SipgateConnectorController < ApplicationController
  
  before_filter :require_login
  
  def auth
    session[:sipgate_from_url] = params[:from]
    redirect_to rusip_auth.auth_redirect_url
  end
  
  def callback
    if params[:code]
      response_for_token = rusip_auth.post_token_request(params[:code])
      if response_for_token.code == '200'
        data = JSON.parse(response_for_token.body)
        user_info = RuSip::Api.new(data['access_token']).authorization_userinfo
        user = User.current
        user.update_attributes(sipgate_token: data['access_token'], sipgate_user_id: user_info['sub'])
        user.reload_sipgate_devices
        user.save
      else
        flash[:error] = "Sipgate Auth Failed"
      end
      
      redirect_to session[:sipgate_from_url] || root_path
    end    
  end
  
  private 
  
  def rusip_auth
    @_rusip_auth ||= RuSip::Auth.new(
      EasyredmineSipgateConnector.client_id,
      EasyredmineSipgateConnector.client_secret,
      EasyredmineSipgateConnector.redirect_url,
      EasyredmineSipgateConnector.scope
    )
  end
  
end