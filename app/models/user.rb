class User
  def self.from_request(request)
    User.new request.env['REMOTE_USER']
  end

  attr_reader :uid

  def initialize(uid)
    @uid = uid
  end
end
