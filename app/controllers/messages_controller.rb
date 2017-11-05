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
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        if req_xml?
          format.xml { render :message_info }
        elsif req_json?
          format.json { render :message_info }
        else
          format.html { render :message_info }
        end
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

  def req_xml?
    request.content_type.include? 'xml'
  end

  def req_json?
    request.content_type.include? 'json'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find_by(id: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    if req_xml?
      { 'message' => Nokogiri::XML(request.body).content }
    elsif req_json?
      params.permit(:message)
    else
      params.permit(message: {}).to_h[:message]
    end
    # params.permit(:message, :message => {})
    # print params
  end

  def sitename
    if Rails.env.production?
      @host = request.host
    else 
      @host = "#{request.host}:#{request.port}"
    end
  end
end
