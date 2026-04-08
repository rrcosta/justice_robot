require './service/apis/datajud/parse_movements'

module Service
  module Apis
    module Datajud
      module Parse
        extend self

        #body&.dig('hits','hits').first&.dig("_source")

          # [
          # "numeroProcesso",
          # "classe",
          # "sistema",
          # "formato",
          # "tribunal",
          # "dataHoraUltimaAtualizacao",
          # "grau",
          # "@timestamp",
          # "dataAjuizamento",
          # "movimentos",
          # "id",
          # "nivelSigilo",
          # "orgaoJulgador",
          # "assuntos"
          # ]

        def execute(body)
          mv = ::Service::Apis::Datajud::ParseMovements.execute(movements_process(body))

          {
            number_process: body&.dig('hits','hits').first&.dig("_source", "numeroProcesso"),
            subject_process: subject_process(body),
            classe_process: classe_process(body),
            name_system: name_system(body),
            process_format: process_format(body),
            name_court: name_court(body),
            last_updated_info: last_updated_info(body),
            rate: rate(body),
            filing_date: filing_date(body),
            api_datajud_id: api_datajud_id(body),
            level_of_reservation: level_of_reservation(body),
            orgao_julgador: orgao_julgador(body),
            quantidade_movimentos: movements_process_size(body),
            movements: mv
          }.to_json
        end

        def convert_date_time(dt)
          DateTime.parse(dt)&.strftime('%d-%m-%Y %H:%M')
        rescue
          dt
        end

        def movements_process_size(body)
          body&.dig('hits','hits').first&.dig("_source", "movimentos")&.size
        end

        def movements_process(body)
          body&.dig('hits','hits').first&.dig("_source", "movimentos")
        end

        def subject_process(body)
          str_returned = ''

          subj = body&.dig('hits','hits').first&.dig("_source", "assuntos")
          # [{"codigo" => 11811, "nome" => "Práticas Abusivas"}]

          subj.each do |detail|
            str_returned << " #{detail&.dig('codigo')} : #{detail.dig('nome')}"
            str_returned << '//'
          end

          str_returned&.rstrip!('/')&.strip
        end

        def classe_process(body)
          #body&.dig('hits','hits').first&.dig("_source", "classe").keys
          #["codigo", "nome"]
          body&.dig('hits','hits').first&.dig("_source", "classe", "nome")
        end

        def name_system(body)
          body&.dig('hits','hits').first&.dig("_source", "sistema", "nome")
        end

        def process_format(body)
          body&.dig('hits','hits').first&.dig("_source", "formato", "nome")
        end

        def name_court(body)
          body&.dig('hits','hits').first&.dig("_source", "tribunal")
        end

        def last_updated_info(body)
          convert_date_time(
            body&.dig('hits','hits').first&.dig("_source", "dataHoraUltimaAtualizacao")
          )
        rescue
          body&.dig('hits','hits').first&.dig("_source", "dataHoraUltimaAtualizacao")
        end

        def rate(body)
          body&.dig('hits','hits').first&.dig("_source", "grau")
        end

        def filing_date(body)
          convert_date_time(
            body&.dig('hits','hits').first&.dig("_source", "dataAjuizamento")
          )
        end

        def api_datajud_id(body)
          body&.dig('hits','hits').first&.dig("_source", "id")
        end

        def level_of_reservation(body)
          body&.dig('hits','hits').first&.dig("_source", "nivelSigilo")
        end

        def orgao_julgador(body)
          #body&.dig('hits','hits').first&.dig("_source", "orgaoJulgador")
          #{"codigo" => 9819, "nome" => "06 CIVEL DE JUNDIAI"}
          #"#{body&.dig('hits','hits').first&.dig('_source', 'orgaoJulgador', 'codigo')} - #{body&.dig('hits','hits').first&.dig('_source', 'orgaoJulgador', 'nome')}"

          str  = "#{body&.dig('hits','hits').first&.dig('_source', 'orgaoJulgador', 'codigo')} -"
          str << " #{body&.dig('hits','hits').first&.dig('_source', 'orgaoJulgador', 'nome')}"
          str
        end

        def source_api(body)
          body&.dig('hits','hits').first&.dig('_index') || ''
        end

        def name_process_api(body)
          body&.dig('hits','hits').first&.dig("_id") || ''
        end

        def score(body)
          body&.dig('hits','hits').first&.dig("_score") || '00.00'
        end
      end
    end
  end
end
