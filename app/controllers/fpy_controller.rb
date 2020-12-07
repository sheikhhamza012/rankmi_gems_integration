class FpyController < ApplicationController
    def create
        input_url = FileUploader.upload(params[:fpy_file])
        output_url = GenerateFilesFromGems.fpy(params[:fpy_file])
        render json:{error:false,data:{input_url: input_url, output_url:output_url}}
        # redirect_to fpy_index_path(input_url: input_url, output_url:ouput_url)

    rescue Exception =>e
        render json:{error:true,msg:e.message}
    end
    def index
    end
end
