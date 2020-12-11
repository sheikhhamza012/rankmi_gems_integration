
require 'open-uri'
class GenerateFilesFromGems
    def self.fpy(file)
        output_file = FpyTemplate::Parse.transform(file.to_io)
        return FileUploader.upload(output_file.stream)
    end
    def self.indicators_template(file)
        metas_bcp = RankmiIndicatorsUpdate::Parse.transform_to_rankmi_template(file.to_io)
        metas_bcp_url = FileUploader.upload(metas_bcp.stream)
        return metas_bcp_url
    end
    def self.indicators_analysis(file)
        metas_bcp_con_info = RankmiIndicatorsUpdate::Parse.first_output_of_step_two(file)
        metas_bcp_con_info_url = FileUploader.upload(metas_bcp_con_info.stream)
        metas_bcp_con_info = open(metas_bcp_con_info_url)
        metas_a_crear = RankmiIndicatorsUpdate::Parse.separate_records(metas_bcp_con_info)
        metas_a_crear_url = FileUploader.upload(metas_a_crear.stream)
        analisis_accione_and_borar = RankmiIndicatorsUpdate::Parse.define_goals_to_eliminate_and_update(metas_bcp_con_info)
        analisis_accione_url = FileUploader.upload(analisis_accione_and_borar[:analisi].stream)
        metas_a_borar_url = FileUploader.upload(analisis_accione_and_borar[:borrar].stream)
        metas_a_actualizer = RankmiIndicatorsUpdate::Parse.excel_with_goals_to_update(metas_bcp_con_info)
        metas_a_actualizer_url = FileUploader.upload(metas_a_actualizer.stream)

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

        return FileUploader.upload(output_file.stream)
    end
    def self.generate_manager(file)
        output_file =  EvaluationsGem::Evaluations.manager_to_collaborator(file.to_io)
        return FileUploader.upload(output_file.stream)
    end
end