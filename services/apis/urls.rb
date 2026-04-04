
module Apis
  module Urls
    BASE_URL      = 'https://api-publica.datajud.cnj.jus.br/'.freeze
    TOKEN_DATAJUD = ENV.fetch('TOKEN_API', '').freeze

    ALL = %w(TRIBUNAL_JUSTICA_ESTADUAL JUSTICA_FEDERAL TRIBUNAIS_SUPERIORES JUSTICA_TRABALHO JUSTICA_MILITAR)

    TRIBUNAL_JUSTICA_ESTADUAL = {
      AC:	"api_publica_tjac/_search",
      AL:	"api_publica_tjal/_search",
      AM:	"api_publica_tjam/_search",
      AP:	"api_publica_tjap/_search",
      BA:	"api_publica_tjba/_search",
      CE:	"api_publica_tjce/_search",
      DF: "api_publica_tjdft/_search",
      ES: "api_publica_tjes/_search",
      GO:	"api_publica_tjgo/_search",
      MA:	"api_publica_tjma/_search",
      MG: "api_publica_tjmg/_search",
      MS:	"api_publica_tjms/_search",
      MT:	"api_publica_tjmt/_search",
      PA:	"api_publica_tjpa/_search",
      PB:	"api_publica_tjpb/_search",
      PE:	"api_publica_tjpe/_search",
      PI:	"api_publica_tjpi/_search",
      PR:	"api_publica_tjpr/_search",
      RJ:	"api_publica_tjrj/_search",
      RN:	"api_publica_tjrn/_search",
      RO:	"api_publica_tjro/_search",
      RR:	"api_publica_tjrr/_search",
      RS: "api_publica_tjrs/_search",
      SC: "api_publica_tjsc/_search",
      SE: "api_publica_tjse/_search",
      SP: "api_publica_tjsp/_search",
      TO: "api_publica_tjto/_search"
    }.freeze

    JUSTICA_FEDERAL = {
      TRF1: "api_publica_trf1/_search",
      TRF2: "api_publica_trf2/_search",
      TRF3: "api_publica_trf3/_search",
      TRF4: "api_publica_trf4/_search",
      TRF5: "api_publica_trf5/_search",
      TRF6: "api_publica_trf6/_search"
    }.freeze

    TRIBUNAIS_SUPERIORES = {
      TRABALHO:  "api_publica_tst/_search",
      ELEITORAL: "api_publica_tse/_search",
      JUSTICA:   "api_publica_stj/_search",
      MILITAR:   "api_publica_stm/_search"
    }.freeze

    JUSTICA_ELEITORAL = {
      AC: "api_publica_tre-ac/_search",
      AL: "api_publica_tre-al/_search",
      AM: "api_publica_tre-am/_search",
      AP: "api_publica_tre-ap/_search",
      BA: "api_publica_tre-ba/_search",
      CE: "api_publica_tre-ce/_search",
      DF: "api_publica_tre-dft/_search",
      ES: "api_publica_tre-es/_search",
      GO: "api_publica_tre-go/_search",
      MA: "api_publica_tre-ma/_search",
      MG: "api_publica_tre-mg/_search",
      MS: "api_publica_tre-ms/_search",
      MT: "api_publica_tre-mt/_search",
      PA: "api_publica_tre-pa/_search",
      PB: "api_publica_tre-pb/_search",
      PE: "api_publica_tre-pe/_search",
      PI: "api_publica_tre-pi/_search",
      PR: "api_publica_tre-pr/_search",
      RJ: "api_publica_tre-rj/_search",
      RN: "api_publica_tre-rn/_search",
      RO: "api_publica_tre-ro/_search",
      RR: "api_publica_tre-rr/_search",
      RS: "api_publica_tre-rs/_search",
      SC: "api_publica_tre-sc/_search",
      SE: "api_publica_tre-se/_search",
      SP: "api_publica_tre-sp/_search",
      TO: "api_publica_tre-to/_search",
    }.freeze

    JUSTICA_TRABALHO = {
      JT01: "api_publica_trt1/_search",
      JT02: "api_publica_trt2/_search",
      JT03: "api_publica_trt3/_search",
      JT04: "api_publica_trt4/_search",
      JT05: "api_publica_trt5/_search",
      JT06: "api_publica_trt6/_search",
      JT07: "api_publica_trt7/_search",
      JT08: "api_publica_trt8/_search",
      JT09: "api_publica_trt9/_search",
      JT10:	"api_publica_trt10/_search",
      JT11:	"api_publica_trt11/_search",
      JT12:	"api_publica_trt12/_search",
      JT13:	"api_publica_trt13/_search",
      JT14:	"api_publica_trt14/_search",
      JT15:	"api_publica_trt15/_search",
      JT16:	"api_publica_trt16/_search",
      JT17:	"api_publica_trt17/_search",
      JT18:	"api_publica_trt18/_search",
      JT19:	"api_publica_trt19/_search",
      JT20:	"api_publica_trt20/_search",
      JT21:	"api_publica_trt21/_search",
      JT22:	"api_publica_trt22/_search",
      JT23:	"api_publica_trt23/_search",
      JT24: "api_publica_trt24/_search"
    }.freeze

    JUSTICA_MILITAR = {
      MG: "api_publica_tjmmg/_search",
      RS: "api_publica_tjmrs/_search",
      SP: "api_publica_tjmsp/_search"
    }.freeze

  end
end
