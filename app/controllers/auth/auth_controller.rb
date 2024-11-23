module Auth
  class AuthController < ActionController::API
    def register
      user = User.new(user_params)
      if user.save
        render json: { message: 'User registered successfully!' }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: user.id)
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Invalid credentials' }, status: :unauthorized
      end
    end

    def validate
      token = request.headers['Authorization']&.split(' ')&.last
      decoded_token = JsonWebToken.decode(token)

      if decoded_token
        user = User.find_by(id: decoded_token[:user_id])
        if user
          render json: { valid: true }, status: :ok
        else
          render json: { valid: false }, status: :unauthorized
        end
      else
        render json: { valid: false }, status: :unauthorized
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :unauthorized
    end

    private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
