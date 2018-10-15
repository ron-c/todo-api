module Api
  module V1
    class TasksController < ApplicationController
      before_action :find_task, only: %i[show update destroy]

      def index
        render json: Task.all
      end

      def show
        render json: @task
      end

      def create
        @task = Task.create(task_params)

        if @task.save
          render json: @task
        else
          render json: @task, status: :forbidden, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        if @task.update_attributes(task_params)
          render json: @task
        else
          render json: @task, status: :forbidden, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def find_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:data).require(:attributes).permit(:title, tags: [])
      end
    end
  end
end
