require 'rack/utils'
require 'rack/mock'

describe Rack::Multipart do

  def multipart_file(name)
     File.join(File.dirname(__FILE__), "multipart", name.to_s)
   end

  should "parse Pauls big file with out locking up" do
    file = multipart_file("small.multipart")
    data = File.open(file, 'rb') { |io| io.read }
    
    type = "multipart/form-data; boundary=\"1336161220\""    #  1336161220
    length = data.respond_to?(:bytesize) ? data.bytesize : data.size
    
    stuff = { "CONTENT_TYPE" => type,"CONTENT_LENGTH" => length.to_s, :input => StringIO.new(data) }
      
    env = Rack::MockRequest.env_for("/", stuff )
      
    Rack::Multipart.parse_multipart(env).parse
  
  end  
  
end
