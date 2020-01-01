# frozen_string_literal: true

# exm: SimpleRequest.get(url: 'http://example.com/v1/users?search=Dubai City&page=&limit=', body: {}, headers: {})
class SimpleRequest::Https < SimpleRequest::Base
  attr_reader :uri, :body, :headers, :https

  def initialize(**options)
    options.symbolize_keys!
    @uri     = URI(options[:url])
    @body    = options[:body]
    @headers = options[:headers] || {}
  end

  ##-------------------------------------------- GET Request ------------------------------------------------##
  def self.get(*args)
    new(*args).get
  end

  def get
    open_ssl
    req = Net::HTTP::Get.new(uri.path, header_processed)
    req.body = body.to_json
    parse_response(req)
  end

  ##-------------------------------------------- POST Request -----------------------------------------------##
  def self.post(*args)
    new(*args).post
  end

  def post
    open_ssl
    req = Net::HTTP::Post.new(uri.path, header_processed)
    req.body = body.to_json
    parse_response(req)
  end

  ##-------------------------------------------- PUT Request ------------------------------------------------##
  def self.put(*args)
    new(*args).put
  end

  def put
    open_ssl
    req = Net::HTTP::Put.new(uri.path, header_processed)
    req.body = body.to_json
    parse_response(req)
  end

  ##-------------------------------------------- DELETE Request ---------------------------------------------##
  def self.destroy(*args)
    new(*args).destroy
  end

  def destroy
    open_ssl
    req = Net::HTTP::Delete.new(uri.path, header_processed)
    req.body = body.to_json
    parse_response(req)
  end

  ##---------------------------------------------------------------------------------------------------------##

  private

  def open_ssl
    @https = Net::HTTP.new(uri.host, uri.port)
    @https.use_ssl = true
    @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def header_processed
    { 'Content-Type' => 'application/json' }.merge(headers)
  end

  def parse_response(req)
    https.request(req)
  rescue Timeout::Error || Net::OpenTimeout
    puts "\e[31mTime out!\e[0m"
    'انتهاء الوقت المزامنة'
  rescue Net::HTTPBadResponse || SocketError
    puts "\e[31mRequest Failed!\e[0m"
    'فشل طلب الملف'
  rescue StandardError
    puts "\e[31mAn unknown error occurred!\e[0m"
    'خطا غير معروف'
  end
end
