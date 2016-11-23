describe API do
	context 'GET /api/statuses/public_timeline' do
		it 'returns an empty array of statuses' do
			get '/api/statuses/public_timeline'
			expect(response.status).to eq(200)
			expect(JSON.parse(response.body)).to eq []
		end
	end
	context 'GET /api/statuses/:id' do
		it 'returns a status by id' do
			status = Status.create!
			get "/api/statuses/#{status.id}"
			expect(response.body).to eq status.to_json
		end
	end
end