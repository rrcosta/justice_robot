require './lib/creates_xlsx/generates'

RSpec.describe CreatesXlsx::Generates do
  let(:struct) do
    {
      "movements": [
        "{\"name\":\"Distribuição\",\"date\":\"27-05-2014 19:43\",\"complement\":[{\"complement_name\":\"sorteio\",\"complement_description\":\"tipo_de_distribuicao_redistribuicao\"}]}",
        "{\"name\":\"Conclusão\",\"date\":\"05-06-2014 12:25\",\"complement\":[{\"complement_name\":\"para despacho\",\"complement_description\":\"tipo_de_conclusao\"}]}",
        "{\"name\":\"Conclusão\",\"date\":\"05-06-2014 15:13\",\"complement\":[{\"complement_name\":\"para despacho\",\"complement_description\":\"tipo_de_conclusao\"}]}",
        "{\"name\":\"Petição\",\"date\":\"10-06-2014 15:22\",\"complement\":[{\"complement_name\":\"Petição (outras)\",\"complement_description\":\"tipo_de_peticao\"}]}",
        "{\"name\":\"Petição\",\"date\":\"19-08-2014 15:19\",\"complement\":[{\"complement_name\":\"Petição (outras)\",\"complement_description\":\"tipo_de_peticao\"}]}",
        "{\"name\":\"Conclusão\",\"date\":\"19-08-2014 15:21\",\"complement\":[{\"complement_name\":\"para despacho\",\"complement_description\":\"tipo_de_conclusao\"}]}",
        "{\"name\":\"Petição\",\"date\":\"10-10-2014 15:45\",\"complement\":[{\"complement_name\":\"Petição (outras)\",\"complement_description\":\"tipo_de_peticao\"}]}"
      ]
    }
  end

  let(:struct_prepared) do
    struct.to_a.flatten.drop(1)
  end

  describe 'Lambdas' do
    describe 'FIRST_AND_LAST_MOV' do
      it 'FIRST_AND_LAST_MOV' do
        expect(
          described_class::FIRST_AND_LAST_MOV.call(struct_prepared))
        .not_to eql(struct_prepared[0])
      end
    end
  end
end