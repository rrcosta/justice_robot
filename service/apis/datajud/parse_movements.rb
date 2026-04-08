
module Service
  module Apis
    module Datajud
      module ParseMovements
        extend self

        def execute(movements_struct)
          read_movements(movements_struct)
        end

        def convert_date_time(dt)
          DateTime&.parse(dt)&.strftime('%d-%m-%Y %H:%M')
        rescue
          dt
        end

        def read_movements(movements_struct)
          return if movements_struct.nil?

          all_movements = []

          movements_struct.each_slice(25) do |group|
            group.each do |struct|
              all_movements << {
                name: name(struct),
                date: date(struct),
                complement: struct_complement(struct&.dig('complementosTabelados'))
              }.to_json
            end
          end

          all_movements
        end

        def struct_complement(complement_struct)
          return if complement_struct.nil?

          complements = []

          complement_struct.each do |complement|
            complements << {
              complement_name: complement_name(complement),
              complement_description: complement_description(complement),
            }
          end

          complements&.flatten!
          complements
        end

        def name(struct)
          struct&.dig('nome')
        end

        def date(struct)
          convert_date_time(
            struct&.dig('dataHora')
          )
        end

        # Complement's
        def complement_name(complement_struct)
          complement_struct&.dig('nome')
        end

        def complement_description(complement_struct)
          complement_struct&.dig('descricao')
        end
      end
    end
  end
end