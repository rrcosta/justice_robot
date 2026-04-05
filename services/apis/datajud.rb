require 'net/http'
require 'json'
require 'uri'

require './services/apis/urls'

module Apis
  module Datajud
    extend self

    CONTENT_TYPE    = 'application/json'.freeze
    TOKEN_DATAJUD   = ::Apis::Urls::TOKEN_DATAJUD

    BASE_URL        = ::Apis::Urls::BASE_URL

    def call(log, contents)
      read_contents(log, contents)

      [ true, { status: :ok } ]
    end

    def read_contents(log, contents)
      # SAMPLE
      # { court: "JUSTICA_TRABALHO", sub_court: "JT24", file: "/home/rafael/Development/r2c/justice_robot/entrada/JUSTICA_TRABALHO/JT24/01.xlsx", basename_file: "01.xlsx", extension_file: ".xlsx" }
      # { court: "TRIBUNAL_JUSTICA_ESTADUAL", sub_court: "SP", file: "/home/rafael/Development/r2c/justice_robot/entrada/TRIBUNAL_JUSTICA_ESTADUAL/SP/01.xlsx", basename_file: "01.xlsx", extension_file: ".xlsx" }
      # { court: "TRIBUNAL_JUSTICA_ESTADUAL", sub_court: "SP", file: "/home/rafael/Development/r2c/justice_robot/entrada/TRIBUNAL_JUSTICA_ESTADUAL/SP/01_.ods", basename_file: "01_.ods", extension_file: ".ods" }

      contents.each do |content|
        next if content[:number_process_withoutmask].nil?

        calls_provider(
          log,
          params(content[:number_process_withoutmask]),
          content[:number_process_withoutmask]
        )
      end
    end

    def calls_provider(log, body, num_process)
      uri = URI(url(nil))

      http = Net::HTTP.new(uri&.host, uri&.port)
      http.use_ssl = (uri&.scheme == 'https')

      http.start do |session|
        request = Net::HTTP::Post.new(uri&.path, headers)
        request.body = body

        response = session.request(request)

        check_response(log, response&.code, response&.body&.strip, num_process)
      end
    end

    def headers
      {
        'Content-Type': CONTENT_TYPE,
        'Authorization': "APIKey #{TOKEN_DATAJUD}"
      }
    end

    def params(num_process)
      {
        "query": {
          "match": {
            "numeroProcesso": num_process
          }
        }
      }.to_json
    end

    def url(options = nil)
      BASE_URL + ::Apis::Urls::TRIBUNAL_JUSTICA_ESTADUAL[:SP]
    end

    def check_response(log, status, body, num_process)
      puts "Processo: #{num_process}"
      puts body
    end
  end
end