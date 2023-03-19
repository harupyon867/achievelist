module Api
  module V1
    class UsersController < ApplicationController
      # ユーザー取得API
      def show
        id_param = params[:id]

        authed_data = authenticate
        unless authed_data.is_a?(String)
          return render json: authed_data.fetch(:body), status: authed_data.fetch(:status)
        end

        user_id = authed_data

        result =
          if id_param != user_id
            ResponseGenerator.un_authorized_error
          else
            ResponseGenerator.success(User.get_public(user_id))
          end

        render json: result.fetch(:body), status: result.fetch(:status)
      end

      # ユーザー登録API
      def create
        creates = params.permit(:name, :mail_address, :password, :password_confirmation)

        user = User.new(creates)

        result =
          if !user.valid?
            ResponseGenerator.validation_error(user.errors.full_messages)
          elsif !user.save
            ResponseGenerator.db_error
          else
            ResponseGenerator.success
          end

        render json: result.fetch(:body), status: result.fetch(:status) unless result.nil?
      end

      # ユーザー更新API
      def update
        id_param = params[:id]
        updates = params.permit(:name, :mail_address)

        authed_data = authenticate
        unless authed_data.is_a?(String)
          return render json: authed_data.fetch(:body), status: authed_data.fetch(:status)
        end

        user_id = authed_data

        user = User.find(user_id)

        if id_param != user_id
          result = ResponseGenerator.un_authorized_error
        elsif user.nil?
          result = ResponseGenerator.not_found
        else
          user.assign_attributes(updates)
          result =
            if !user.valid?
              ResponseGenerator.validation_error(user.errors.full_messages)
            elsif !user.save
              ResponseGenerator.db_error
            else
              ResponseGenerator.success
            end
        end
        render json: result.fetch(:body), status: result.fetch(:status) unless result.nil?
      end
    end
  end
end
