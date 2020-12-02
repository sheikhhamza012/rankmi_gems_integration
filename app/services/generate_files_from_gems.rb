
require 'open-uri'
class GenerateFilesFromGems
    def self.fpy(file)
        output_file = FpyTemplate::Parse.transform(file.to_io)
        return FileUploader.upload(open(output_file))
    end
    def self.indicators_template(file)
        metas_bcp = RankmiIndicatorsUpdate::Parse.transform_to_rankmi_template(file.to_io)
        metas_bcp_url = FileUploader.upload(open(metas_bcp))
        return metas_bcp_url
    end
    def self.indicators_analysis(file)
        metas_bcp_con_info = RankmiIndicatorsUpdate::Parse.first_output_of_step_two(file)
        metas_bcp_con_info_url = FileUploader.upload(open(metas_bcp_con_info))
        metas_bcp_con_info = open(metas_bcp_con_info_url)
        metas_a_crear = RankmiIndicatorsUpdate::Parse.separate_records(metas_bcp_con_info)
        metas_a_crear_url = FileUploader.upload(open(metas_a_crear))
        analisis_accione = RankmiIndicatorsUpdate::Parse.define_goals_to_eliminate_and_update(metas_bcp_con_info)
        metas_a_borar_url = FileUploader.upload(open(analisis_accione))
        analisis_accione_url = FileUploader.upload(open('Análisis accione.xlsx'))
        metas_a_actualizer = RankmiIndicatorsUpdate::Parse.excel_with_goals_to_update(metas_bcp_con_info)
        metas_a_actualizer_url = FileUploader.upload(open(metas_a_actualizer))

        return {
            metas_bcp_con_info_url:metas_bcp_con_info_url,
            metas_a_crear_url:metas_a_crear_url,
            analisis_accione_url:analisis_accione_url,
            metas_a_borar_url:metas_a_borar_url,
            metas_a_actualizer_url:metas_a_actualizer_url
        }
    end
    def self.generate_peers(file)

        output_file =  EvaluationsGem::Evaluations.peer_to_peer(file.to_io)

        return FileUploader.upload(open(output_file))
    end
    def self.generate_manager(file)
        output_file =  EvaluationsGem::Evaluations.manager_to_collaborator(file.to_io)
        return FileUploader.upload(open(output_file))
    end
end