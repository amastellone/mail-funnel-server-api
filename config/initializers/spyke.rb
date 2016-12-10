# config/initializers/spyke.rb

class JSONParser < Faraday::Response::Middleware
	def parse(body)
		json = MultiJson.load(body, symbolize_keys: true)
		{
			 data: json[:result],
			 metadata: json[:extra],
			 errors: json[:errors]
		}
	end
end

# Replace Server URL wit .env Variable
Spyke::Base.connection = Faraday.new(url: 'http://localhost:3001') do |c|
	c.request   :json
	c.use       JSONParser
	c.adapter   Faraday.default_adapter
end