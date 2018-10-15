module Api
  module V1
    class TagsController < ApplicationController
      before_action :find_tag, only: %i[update destroy]

      def index
        render json: Tag.all
      end

      def create
        @tag = Tag.new(tag_params)

        if @tag.save
          render json: @tag
        else
          render json: @tag, status: :forbidden, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        if @tag.update_attributes(tag_params)
          render json: @tag
        else
          render json: @tag, status: :forbidden, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def destroy
        @tag.destroy
        head :no_content
      end

      private

      def find_tag
        @tag = Tag.find(params[:id])
      end

      def tag_params
        params.require(:data).require(:attributes).permit(:title)
      end
    end
  end
end
