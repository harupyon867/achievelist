module Api
  module V1
    class TasksController < ApplicationController
      # タスク一覧取得API
      def index
        cleared = params[:cleared].to_bool

        authed_data = authenticate
        unless authed_data.is_a?(String)
          return render json: authed_data.fetch(:body), status: authed_data.fetch(:status)
        end

        user_id = authed_data

        result =
          if cleared == true
            ResponseGenerator.success(ClearedTask.where(user_id))
          elsif cleared == false
            ResponseGenerator.success(Task.where(user_id))
          else
            ResponseGenerator.validation_error(['cleaed は真偽値で指定してください。'])
          end

        render json: result.fetch(:body), status: result.fetch(:status)
      end

      # タスク保存API
      def create
        name = params[:name]
        limit = params[:limit]
        priority = params[:priority]

        authed_data = authenticate
        unless authed_data.is_a?(String)
          return render json: authed_data.fetch(:body), status: authed_data.fetch(:status)
        end

        user_id = authed_data

        task = Task.new({ user_id:, name:, limit:, priority: })

        result =
          if !task.valid?
            ResponseGenerator.validation_error(task.errors.full_messages)
          elsif !task.save
            ResponseGenerator.db_error
          else
            ResponseGenerator.success
          end

        render json: result.fetch(:body), status: result.fetch(:status) unless result.nil?
      end

      # タスク削除API
      def destroy
        task_id = params[:id]

        authed_data = authenticate
        unless authed_data.is_a?(String)
          return render json: authed_data.fetch(:body), status: authed_data.fetch(:status)
        end

        user_id = authed_data

        task = Task.find_by(id: task_id, user_id:)
        result =
          if task.nil?
            ResponseGenerator.not_found
          elsif !task.destroy
            ResponseGenerator.db_error
          else
            ResponseGenerator.success
          end

        render json: result.fetch(:body), status: result.fetch(:status) unless result.nil?
      end

      # タスク更新API
      def update
        task_id = params[:id]
        updates = params.permit(:name, :limit, :priority)

        authed_data = authenticate
        unless authed_data.is_a?(String)
          return render json: authed_data.fetch(:body), status: authed_data.fetch(:status)
        end

        user_id = authed_data

        task = Task.find_by(id: task_id, user_id:)

        if task.nil?
          result = ResponseGenerator.not_found
        else
          task.assign_attributes(updates)
          result =
            if !task.valid?
              ResponseGenerator.validation_error(task.errors.full_messages)
            elsif !task.save
              ResponseGenerator.db_error
            else
              ResponseGenerator.success
            end
        end
        render json: result.fetch(:body), status: result.fetch(:status) unless result.nil?
      end

      # タスク解消API
      def clear
        task_id = params[:id]

        authed_data = authenticate
        unless authed_data.is_a?(String)
          return render json: authed_data.fetch(:body), status: authed_data.fetch(:status)
        end

        user_id = authed_data

        result =
          if !TaskClearEvent.task_clear(task_id, user_id)
            ResponseGenerator.db_error
          else
            ResponseGenerator.success
          end

        render json: result.fetch(:body), status: result.fetch(:status) unless result.nil?
      end
    end
  end
end
