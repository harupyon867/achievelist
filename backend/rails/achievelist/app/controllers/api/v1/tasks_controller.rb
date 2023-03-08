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
          render json: { 'status': 400 }
        end
        logger.debug(result)

        render json: result
      end
    end
  end
end
