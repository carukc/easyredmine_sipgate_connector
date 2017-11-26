module EasyredmineSipgateConnector
  module UserExtension
  
    extend ActiveSupport::Concern
    
    included do
      serialize :sipgate_devices
    end
    
    def reload_sipgate_devices
      return false if sipgate_token.nil?
      data = rusip_api.devices_for_user(self.sipgate_user_id)
      self.sipgate_devices = {}
      data['items'].map do |item|
        self.sipgate_devices[item['id']] = item['alias'] 
      end
    end
    
    private
    def rusip_api
      @_rusip_api ||= RuSip::Api.new(self.sipgate_token)
    end
    
  end
end  