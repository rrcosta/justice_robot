require 'net/http'
require 'json'
require 'uri'

module Service
  module Apis
    module Calls
      module Execute
        extend self

        TIMEOUT = 180.freeze

        def call(http_method = nil, url, headers, body_request, timeout)
          return if url.nil?

          http_method = :GET if http_method.nil?
          response = nil

          uri = URI(url)

          http = generates_http(uri, timeout)

          http.start do |session|
            request = calls_http_method(http_method, uri, headers)
            request.body = body_request

            response = session&.request(request)
          end

          response
        rescue => err
          err.message
        end

        def generates_http(uri, timeout)
          timeout = timeout.nil? ? TIMEOUT : timeout

          http = ::Net::HTTP.new(uri&.host, uri&.port)
          http.use_ssl = (uri&.scheme == 'https')
          http.open_timeout  = timeout  # Increase connection timeout to 180 seconds
          http.read_timeout  = timeout  # Increase read timeout to 180 seconds
          http.write_timeout = timeout  # Increase write timeout to 180 seconds

          http
        end

        def calls_http_method(http_method, uri, headers)
          case http_method&.upcase
          when :GET
            get(uri, headers)
          when :POST
            post(uri, headers)
          when :PUT
            put(uri, headers)
          when :DELETE
            delete(uri, headers)
          when :PATCH
            patch(uri, headers)
          when :OPTIONS
            options(uri, headers)
          when :HEAD
            head(uri, headers)
          when :TRACE
            trace(uri, headers)
          end
        end

        def get(uri, headers)
          ::Net::HTTP::Get.new(uri&.path, headers)
        end

        def post(uri, headers)
          ::Net::HTTP::Post.new(uri&.path, headers)
        end

        def put(uri, headers)
          ::Net::HTTP::Put.new(uri&.path, headers)
        end

        def delete(uri, headers)
          ::Net::HTTP::Delete.new(uri&.path, headers)
        end

        def patch(uri, headers)
          ::Net::HTTP::Patch.new(uri&.path, headers)
        end

        def options(uri, headers)
          ::Net::HTTP::Options.new(uri&.path, headers)
        end

        def head(uri, headers)
          ::Net::HTTP::Head.new(uri&.path, headers)
        end

        def trace(uri, headers)
          ::Net::HTTP::Trace.new(uri&.path, headers)
        end
      end
    end
  end
end

# ::Service::Apis::Calls::Execute.call(:POST, url, headers, body_request, timeout = nil)