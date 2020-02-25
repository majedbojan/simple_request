require 'pry'

RSpec.describe SimpleRequest do
  subject { described_class }

  let(:endpoint) { 'https://jsonplaceholder.typicode.com/posts' }
  let(:body) do
    {
      title:  'foo',
      body:   'bar',
      userId: 1
    }
  end

  it "has a version number" do
    expect(SimpleHelper::VERSION).not_to be nil
  end

  it 'should fetch list of resources with GET method and return all available methods' do
    VCR.use_cassette('list_success') do
      request = subject.get(url: endpoint, body: {}, headers: {})
      expect(request.host).to eq('jsonplaceholder.typicode.com')
      expect(request.port).to   eq(443)
      expect(request.path).to   eq('/posts')
      expect(request.scheme).to eq('https')
      expect(request.request_uri).to eq('/posts')
      expect(request.json.is_a?(Array)).to be_truthy
      expect(request.plain.is_a?(String)).to be_truthy
    end
  end

  it 'should create a resource with POST method' do
    VCR.use_cassette('post_create_success') do
      request = SimpleRequest.post(      url:     endpoint,      body:    body,      headers: {}    )
      expect(request.json.is_a?(Hash)).to be_truthy
      expect(request.plain.is_a?(String)).to be_truthy
    end
  end

  it 'should update the resource with PUT method' do
    request = SimpleRequest.put(
      url:     "#{endpoint}/1",
      body:    body.merge(userId: 1),
      headers: {}
    )
    expect(request.json.is_a?(Hash)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end

  it 'should update the resource with PATCH method' do
    request = SimpleRequest.patch(
      url:     "#{endpoint}/1",
      body:    { title: 'foo' },
      headers: {}
    )
    expect(request.json.is_a?(Hash)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end

  it 'should delete a resource with DELETE method' do
    request = SimpleRequest.delete(
      url:     "#{endpoint}/1",
      body:    {},
      headers: {}
    )
    expect(request.json.is_a?(Hash)).to be_truthy
    expect(request.plain.is_a?(String)).to be_truthy
  end
end
