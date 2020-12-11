class ExcelReviewController < ApplicationController
    def create
        input_url = FileUploader.upload(params[:excel_review_file])
        # output_url = GenerateFilesFromGems.excel_review(params[:excel_review_file])
        # render json:{error:false,data:{input_url: input_url, output_url:output_url}}
        # redirect_to fpy_index_path(input_url: input_url, output_url:ouput_url)
        redirect_to RankmiExcelReview::Engine.routes.url_helpers.review_index_path(:path_to_file=>input_url, :redirect_to=>excel_review_index_path)
    rescue Exception =>e
        render json:{error:true,msg:e.message}
    end
    def index
        byebug
    end
end
