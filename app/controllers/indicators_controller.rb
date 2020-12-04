class IndicatorsController < ApplicationController
    def create
        analysis_input = params[:analysis_input]
        generate_template_input = params[:generate_template_input]
        analysis_input_url=""
        generate_template_input_url=""
        metas_bcp_url=""
        analysis_files_urls={}
        if !generate_template_input.nil?
            generate_template_input_url = FileUploader.upload(generate_template_input)
            metas_bcp_url = GenerateFilesFromGems.indicators_template(generate_template_input)
        end
        if !analysis_input.nil?
            analysis_input_url = FileUploader.upload(analysis_input)
            analysis_files_urls = GenerateFilesFromGems.indicators_analysis(analysis_input)
        end
        analysis_files_urls['analysis_input_url'] = analysis_input_url
        analysis_files_urls['generate_template_input_url'] = generate_template_input_url
        analysis_files_urls['metas_bcp_url'] = metas_bcp_url
        # redirect_to indicators_path(analysis_files_urls)
        render json:{error:false,data: analysis_files_urls}


    rescue Exception => e
        render json:{error:true,msg: t("error") }
    end
    def index
    end
end
