module Api
  module V1
    class AuthController < ApplicationController
      def login
        mail_address = params[:mail_address]
        password = params[:password]

        user = User.find_by(mail_address:)

        if user.nil?
          result = ResponseGenerator.not_found
          return render json: result.fetch(:body), status: result.fetch(:status)
        end

        authed_user = user.authenticate(password)

        unless authed_user
          result = ResponseGenerator.un_authorized_error
          return render json: result.fetch(:body), status: result.fetch(:status)
        end

        access_token = TokenHandler.generate_access_token(authed_user.id)
        refresh_token = TokenHandler.generate_refresh_token(authed_user.id)
        cookies[:jwt] = refresh_token

        token_issue_event = TokenIssueEvent.new(
          { user_id: authed_user.id, refresh_token:, event_datetime: Time.current }
        )

        result =
          if !token_issue_event.save
            rator.db_error
          else
            ResponseGenerator.success({ access_token: })
          end

        render json: result.fetch(:body), status: result.fetch(:status)
      end

      def refresh
        refresh_token = cookies[:jwt]
        if refresh_token.nil?
          result = ResponseGenerator.un_authorized_error
          return render json: result.fetch(:body), status: result.fetch(:status)
        end

        token_issue_event_old = TokenIssueEvent.find_by(refresh_token:)
        if token_issue_event_old.nil?
          result = ResponseGenerator.un_authorized_error
          return render json: result.fetch(:body), status: result.fetch(:status)
        end

        user_id = token_issue_event_old[:user_id]

        access_token = TokenHandler.generate_access_token(user_id)
        refresh_token = TokenHandler.generate_refresh_token(user_id)
        cookies[:jwt] = refresh_token

        token_issue_event = TokenIssueEvent.new(
          { user_id:, refresh_token:, event_datetime: Time.current }
        )

        result =
          if !token_issue_event.save
            rator.db_error
          else
            ResponseGenerator.success({ access_token: })
          end

        render json: result.fetch(:body), status: result.fetch(:status)
      end
    end
  end
end
