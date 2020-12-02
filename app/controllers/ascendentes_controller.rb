class AscendentesController < ApplicationController
    def create
        peers_definition_input_file = params[:peers_definition_file]
        peers_definition_input_url = ""
        evaluator_ascendentes_input_file = params[:evaluator_ascendentes_file]
        evaluator_ascendentes_input_url = ""
        
        if !peers_definition_input_file.nil?
            peers_definition_input_url = FileUploader.upload(peers_definition_input_file)
            peers_output_url = GenerateFilesFromGems.generate_peers(peers_definition_input_file)
        end
        if !evaluator_ascendentes_input_file.nil?
            evaluator_ascendentes_input_url = FileUploader.upload(evaluator_ascendentes_input_file)
            evaluator_ascendentes_output_url = GenerateFilesFromGems.generate_manager(evaluator_ascendentes_input_file)
        end

        redirect_to ascendentes_path(evaluator_ascendentes_input_url:evaluator_ascendentes_input_url,peers_definition_input_url: peers_definition_input_url,peers_output_url:peers_output_url, evaluator_ascendentes_output_url:evaluator_ascendentes_output_url,)
    end
    def index
    end
end
