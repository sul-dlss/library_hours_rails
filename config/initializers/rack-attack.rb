Rack::Attack.safelist('allow from Stanford IPs') do |req|
  req.ip.starts_with?('10') || req.ip.starts_with?('171') || req.ip.starts_with?('172')
end

# Throttle requests to 30/minute
Rack::Attack.throttle("requests by ip", limit: 30, period: 60) do |req|
  next if req.path.start_with? '/api'

  req.ip
end

# Block suspicious requests for '/etc/password' or wordpress specific paths.
# After 3 blocked requests in 10 minutes, block all requests from that IP for 15 minutes.
Rack::Attack.blocklist('fail2ban malicious bots') do |req|
  # `filter` returns truthy value if request fails, or if it's from a previously banned IP
  # so the request is blocked
  Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}", maxretry: 3, findtime: 10.minutes, bantime: 15.minutes) do
    # The count for the IP is incremented if the return value is truthy
    CGI.unescape(req.query_string) =~ Regexp.union('etc', 'passwd', '.ini', '" AND "', '" OR "')
  end
end
