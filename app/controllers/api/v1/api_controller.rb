class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_500
  rescue_from ActiveRecord::ConnectionTimeoutError, with: :return_504

  private

  def return_404
    render json: { error: 'Objeto não encontrado' }, status: 404
  end

  def return_500
    render json: { error: 'Não foi possível conectar ao banco de dados' }, status: 500
  end

  def return_504
    render json: { error: 'Tempo excedido' }, status: 504
  end
end