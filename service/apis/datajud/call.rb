require './service/apis/datajud/urls'
require './service/apis/calls/execute'

module Service
  module Apis
    module Datajud
      module Call
        extend self

        TOKEN_DATAJUD   = ::Service::Apis::Datajud::Urls::TOKEN_DATAJUD.freeze
        BASE_URL        = ::Service::Apis::Datajud::Urls::BASE_URL.freeze
        PREFIX          = "::Service::Apis::Datajud::Urls::".freeze
        STRUCT_RETURNED = []

        def execute(log, contents)
          read_contents(log, contents)

          [ true,  STRUCT_RETURNED ]
        rescue => err
          [ false, { error: err.message } ]
        end

        def read_contents(log, contents)
          return unless contents.instance_of?(Array)

          # SAMPLE 'contents'
          # {
          #   court: "TRIBUNAL_JUSTICA_ESTADUAL",
          #   sub_court: "SP",
          #   basename_file: "01.xls",
          #   number_process: "0020480-56.2025.8.26.1011",
          #   number_process_withoutmask: "00204805620258261011"
          # }

          contents.each do |content|
            next if content&.dig(:number_process_withoutmask).nil?

            calls_provider(
              log,
              { court: content&.dig(:court), sub_court: content&.dig(:sub_court) },
              params(content&.dig(:number_process_withoutmask)),
              content&.dig(:number_process_withoutmask)
            )
          end
        end

        def calls_provider(log, destin, body, num_process)
          url = url(**destin)

          response = ::Service::Apis::Calls::Execute.call(
            :POST,
            url,
            headers,
            body,
            180
          )

          calls_error_log(
            log, url, num_process, response&.code
          ) if response&.code != '200'

          STRUCT_RETURNED << JSON.parse(response&.body&.strip)
        end

        def headers
          {
            'Content-Type': 'application/json',
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
          sufix_url = get_complement_url(options)

          BASE_URL + eval(sufix_url)
        end

        def get_complement_url(options)
          str_returned = PREFIX.dup
          sub_court    = options[:sub_court] || nil
          court        = options.nil? ? "TRIBUNAL_JUSTICA_ESTADUAL" : options[:court]

          return "#{str_returned}#{court}" if sub_court.nil?

          str_returned.concat(court).concat('[')
          str_returned.concat(":#{sub_court}]")

          str_returned
        end

        def calls_error_log(log, url, num_process, http_code)
          log.warn(
            "Erro ao chamar a Url: #{url} - HTTP CODE: #{http_code} para o processo: #{num_process}"
          )
        end
      end
    end
  end
end


