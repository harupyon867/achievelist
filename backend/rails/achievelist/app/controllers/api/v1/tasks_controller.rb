module Api
  module V1
    class TasksController < ApplicationController
      def index
        cleared = params[:cleared];

        result = {taskId: 1, name: 'メール返信', limit: '2023-03-07 00:00:00', priority: 'MIDDLE'}
        render json: result;
      end
    end
  end
end