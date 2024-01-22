RSpec.describe SimpleRequest do
  let(:endpoint) { 'https://jsonplaceholder.typicode.com/posts' }
  let(:body) do
    {
      title:  'foo',
      body:   'bar',
      userId: 1
    }
  end
  let(:empty_body) { {} }

  it 'has a version number' do
    expect(SimpleHelper::VERSION).not_to be nil
  end

  describe 'GET method' do
    it 'fetches a list of resources and returns all available methods' do
      VCR.use_cassette('get_list_success_request') do
        request = described_class.get(url: endpoint, body: {}, headers: {})
        expect(request.host).to eq('jsonplaceholder.typicode.com')
        expect(request.port).to   eq(443)
        expect(request.path).to   eq('/posts')
        expect(request.scheme).to eq('https')
        expect(request.request_uri).to eq('/posts')
        expect(request.json.is_a?(Array)).to be_truthy
        expect(request.plain.is_a?(String)).to be_truthy
      end
    end

    it 'handles invalid URL' do
      VCR.use_cassette('get_invalid_url') do
        expect do
          described_class.get(url: 'invalid_url', body: empty_body, headers: {})
        end.to raise_error(SimpleHelper::UnsupportedURIScheme, %r{URL\s*Must start with http:// or https://})
      end
    end

    # it 'handles non-existent endpoint' do
    #   VCR.use_cassette('get_nonexistent_endpoint') do
    #     expect do
    #       described_class.get(url: "#{endpoint}/nonexistent", body: empty_body, headers: {})
    #     end.to raise_error(SimpleHelper::RedirectionTooDeep)
    #   end
    # end
  end

  describe 'POST method' do
    it 'creates a resource' do
      VCR.use_cassette('post_create_success_request') do
        request = described_class.post(url: endpoint, body:, headers: {})
        expect(request.json.is_a?(Hash)).to be_truthy
        expect(request.plain.is_a?(String)).to be_truthy
      end
    end

    it 'handles invalid request format' do
      VCR.use_cassette('post_invalid_request_format') do
        expect do
          described_class.post(url: endpoint, body: ':body must be a hash', headers: {})
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe 'PUT method' do
    it 'updates the resource' do
      VCR.use_cassette('put_update_success_request') do
        request = described_class.put(url: "#{endpoint}/1", body:)
        expect(request.json.is_a?(Hash)).to be_truthy
        expect(request.plain.is_a?(String)).to be_truthy
      end
    end

    it 'handles non-existent resource for update' do
      VCR.use_cassette('put_nonexistent_resource_update') do
        expect do
          described_class.put(url: "#{endpoint}/nonexistent", body: empty_body)
        end.to raise_error(SimpleHelper::ResourceNotFoundError)
      end
    end
  end

  describe 'PATCH method' do
    it 'updates the resource' do
      VCR.use_cassette('patch_update_success_request') do
        request = described_class.patch(url: "#{endpoint}/1", body:)
        expect(request.json.is_a?(Hash)).to be_truthy
        expect(request.plain.is_a?(String)).to be_truthy
      end
    end

    it 'handles invalid request parameters for update' do
      VCR.use_cassette('patch_invalid_parameters_update') do
        expect do
          described_class.patch(url: "#{endpoint}/1", body: 'invalid_body')
        end.to raise_error(ArgumentError)
      end
    end
  end
  describe 'DELETE method' do
    it 'deletes a resource' do
      VCR.use_cassette('delete_update_success_request') do
        request = described_class.delete(url: "#{endpoint}/1")
        expect(request.plain.is_a?(String)).to be_truthy
      end
    end

    it 'handles non-existent resource for deletion' do
      VCR.use_cassette('delete_nonexistent_resource') do
        expect do
          described_class.delete(url: "#{endpoint}/nonexistent")
        end.to raise_error(SimpleHelper::ResourceNotFoundError)
      end
    end
  end
end
