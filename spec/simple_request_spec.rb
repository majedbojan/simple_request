require 'pry'

RSpec.describe SimpleRequest do
  let(:http) { 'http://localhost:3000/v1/admin/' }
  let(:body) { { 'city' => { 'name_ar' => 'المكلا', 'name_en' => 'Mukalla', 'status' => 'active' } } }

  it "has a version number" do
    expect(SimpleHelper::VERSION).not_to be nil
  end

  it 'should make get request and return all available methods' do
    request = SimpleRequest.get(
      url: "#{http}cities?limit=10",
      body: {},
      headers: headers
    )
    expect(request.host).to   eq('localhost')
    expect(request.port).to   eq(3000)
    expect(request.path).to   eq('/v1/admin/cities')
    expect(request.path).to   eq('/v1/admin/cities')
    expect(request.query).to  eq('limit=10')
    expect(request.scheme).to eq('http')
    expect(request.request_uri).to eq('/v1/admin/cities?limit=10')
    expect(request.json.is_a?(Hash)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end

  it 'should make get request with https method' do
    request = SimpleRequest.get(
      url: 'https://jsonplaceholder.typicode.com/posts',
      body: {},
      headers: {}
    )
    expect(request.json.is_a?(Array)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end

  it 'should make post request' do
    request = SimpleRequest.post(
      url: "#{http}cities?limit=10",
      body: body,
      headers: headers
    )
    expect(request.json.is_a?(Hash)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end

  it 'should make put request' do
    request = SimpleRequest.put(
      url: "#{http}cities/1?limit=10",
      body: body,
      headers: headers
    )
    expect(request.json.is_a?(Hash)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end

  it 'should make delete request' do
    request = SimpleRequest.delete(
      url: "#{http}cities/1?limit=10",
      body: {},
      headers: headers
    )
    expect(request.json.is_a?(Hash)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end
end
