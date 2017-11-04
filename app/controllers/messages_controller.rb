class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit update destroy]
  before_action :sitename

  # GET /messages
  # GET /messages.json
  def index
    @message = Message.new
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    if @message
      print @message.message
      respond_to :json, :xml, :html
      @message.destroy
    else
      respond_to do |format|
        format.html { 'Message not found.' }
        format.xml { 'Message not found.' }
        format.json { head :no_content }
      end
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    if message_params.to_h[:message].is_a?(Hash)
      msg = message_params.to_h[:message]
      @message = Message.new(msg)
    else
      @message = Message.new(message_params)
    end

    respond_to do |format|
      if @message.save
        format.xml { render :message_info }
        format.json { render :message_info }
        format.html { render :message_info }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find_by(id: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.permit(:message, :message => {})
  end

  def sitename
    @host = "#{request.host}:#{request.port}"
  end
end
