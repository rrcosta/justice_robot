require 'net/http'
require 'json'
require 'uri'

require './service/apis/datajud/urls'

module Service
  module Apis
    module Datajud
      module Call
        extend self

        # Não pode ter o freeze pois tera concat
        PREFIX = "::Service::Apis::Datajud::Urls::"

        # ::Service::Apis::Datajud::Urls
        CONTENT_TYPE    = 'application/json'.freeze
        TIMEOUT         = 180.freeze
        TOKEN_DATAJUD   = ::Service::Apis::Datajud::Urls::TOKEN_DATAJUD
        BASE_URL        = ::Service::Apis::Datajud::Urls::BASE_URL

        def execute(log, contents)
          read_contents(log, contents)

          [ true, { status: :ok } ]
        rescue => err
          [ false, { error: err.message } ]
        end

        def read_contents(log, contents)
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

            destin = { court: content&.dig(:court), sub_court: content&.dig(:sub_court) }

            calls_provider(
              log,
              destin,
              params(content&.dig(:number_process_withoutmask)),
              content&.dig(:number_process_withoutmask)
            )
          end
        end

        def calls_provider(log, destin, body, num_process)
          url = url(**destin)
          uri = URI(url)

          http = Net::HTTP.new(uri&.host, uri&.port)
          http.use_ssl = (uri&.scheme == 'https')
          http.open_timeout  = TIMEOUT  # Increase connection timeout to 180 seconds
          http.read_timeout  = TIMEOUT  # Increase read timeout to 180 seconds
          http.write_timeout = TIMEOUT  # Increase write timeout to 180 seconds

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
          sufix_url = get_complement_url(options)

          BASE_URL + eval(sufix_url)
        end

        def get_complement_url(options)
          sub_court = options[:sub_court] || nil
          court     = options.nil? ? "TRIBUNAL_JUSTICA_ESTADUAL" : options[:court]

          return "#{PREFIX}#{court}" if sub_court.nil?

          PREFIX.concat(court).concat('[')
          PREFIX.concat(":#{sub_court}]")

          PREFIX
        end

        def check_response(log, status, body, num_process)
          puts "Processo: #{num_process}"
          puts body

          # TODO
          # Criar no Service uma camada para tratar o retorno do response
          #
          # Exemplo de erro:
          # Processo: 10011963820225020712
          # {"took":3567,"timed_out":false,"_shards":{"total":1,"successful":1,"skipped":0,"failed":0},"hits":{"total":{"value":0,"relation":"eq"},"max_score":null,"hits":[]}}
          #
          # Exemplo de Sucesso
          # {"took":6169,"timed_out":false,"_shards":{"total":20,"successful":20,"skipped":0,"failed":0},"hits":{"total":{"value":1,"relation":"eq"},"max_score":15.49847,"hits":[{"_index":"api_publica_tjsp","_id":"TJSP_G1_00104905620258260309","_score":15.49847,"_source":{"numeroProcesso":"00104905620258260309","classe":{"codigo":156,"nome":"Cumprimento de sentença"},"sistema":{"codigo":3,"nome":"SAJ"},"formato":{"codigo":1,"nome":"Eletrônico"},"tribunal":"TJSP","dataHoraUltimaAtualizacao":"2026-02-05T15:45:31.114000Z","grau":"G1","@timestamp":"2026-02-05T15:45:31.114000Z","dataAjuizamento":"20250919104220","movimentos":[{"codigo":11385,"nome":"Execução/Cumprimento de Sentença Iniciada (o)","dataHora":"2025-09-22T16:05:37.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"complementosTabelados":[{"codigo":3,"valor":5,"nome":"para despacho","descricao":"tipo_de_conclusao"}],"codigo":51,"nome":"Conclusão","dataHora":"2025-09-26T16:04:56.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"codigo":12164,"nome":"Outras Decisões","dataHora":"2025-09-29T08:07:37.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"complementosTabelados":[{"codigo":18,"valor":40,"nome":"outros motivos","descricao":"motivo_da_remessa"}],"codigo":123,"nome":"Remessa","dataHora":"2025-09-29T09:11:51.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"codigo":92,"nome":"Publicação","dataHora":"2025-09-30T06:34:25.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"complementosTabelados":[{"codigo":19,"valor":57,"nome":"Petição (outras)","descricao":"tipo_de_peticao"}],"codigo":85,"nome":"Petição","dataHora":"2025-10-03T15:15:11.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"codigo":11383,"nome":"Ato ordinatório","dataHora":"2025-10-21T02:23:16.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"complementosTabelados":[{"codigo":19,"valor":57,"nome":"Petição (outras)","descricao":"tipo_de_peticao"}],"codigo":85,"nome":"Petição","dataHora":"2025-10-24T10:15:36.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"codigo":11383,"nome":"Ato ordinatório","dataHora":"2025-12-04T09:32:11.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"complementosTabelados":[{"codigo":18,"valor":40,"nome":"outros motivos","descricao":"motivo_da_remessa"}],"codigo":123,"nome":"Remessa","dataHora":"2025-12-04T10:16:27.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"codigo":92,"nome":"Publicação","dataHora":"2025-12-05T01:33:34.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}},{"complementosTabelados":[{"codigo":19,"valor":57,"nome":"Petição (outras)","descricao":"tipo_de_peticao"}],"codigo":85,"nome":"Petição","dataHora":"2026-01-26T11:05:52.000Z","orgaoJulgador":{"codigo":"9819","nome":"06 CIVEL DE JUNDIAI"}}],"id":"TJSP_G1_00104905620258260309","nivelSigilo":0,"orgaoJulgador":{"codigoMunicipioIBGE":null,"codigo":9819,"nome":"06 CIVEL DE JUNDIAI"},"assuntos":[{"codigo":11811,"nome":"Práticas Abusivas"}]}}]}}
        end
      end
    end
  end
end


