module Api
  module V1
    class TasksController < ApplicationController
      # タスク一覧取得API
      def index
        cleared = params[:cleared].to_bool

        # TODO: JWTから取得
        user_id = '1'

        if cleared == true
          result = ClearedTask.where(user_id)
        elsif cleared == false
          result = Task.where(user_id)
        else
          ResponseGenerator.validation_error(['cleaed は真偽値で指定してください。'])
        end

        render json: result
      end

      # タスク保存API
      def create
        name = params[:name]
        limit = params[:limit]
        priority = params[:priority]

        # TODO: JWTから取得
        user_id = '1'

        task = Task.new({ user_id:, name:, limit:, priority: })

        result =
          if !task.valid?
            ResponseGenerator.validation_error(task.errors.full_messages)
          elsif !task.save
            ResponseGenerator.db_error
          else
            ResponseGenerator.success
          end

        render json: result unless result.nil?
      end
    end
  end
end
