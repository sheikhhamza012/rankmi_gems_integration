class FpyController < ApplicationController
    def create
        input_url = FileUploader.upload(params[:fpy_file])
        ouput_url = GenerateFilesFromGems.fpy(params[:fpy_file])
        redirect_to fpy_index_path(input_url: input_url, output_url:ouput_url)
    end
    def index
    end
end
