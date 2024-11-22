module Auth
  class AuthController < ActionController::API
    def register
      user = User.new(user_params)
      if user.save
        render json: { message: "Usuário registrado com sucesso!" }, status: :created
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
        render json: { error: "Credenciais inválidas" }, status: :unauthorized
      end
    end

    def validate
      token = request.headers['Authorization']&.split(' ')&.last
      decoded = JsonWebToken.decode(token)
      if decoded
        user = User.find_by(id: decoded[:user_id])
        if user
          render json: { user: { id: user.id, email: user.email } }, status: :ok
        else
          render json: { error: "Usuário não encontrado" }, status: :unauthorized
        end
      else
        render json: { error: "Token inválido" }, status: :unauthorized
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :unauthorized
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
