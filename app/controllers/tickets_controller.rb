class TicketsController < ApplicationController

  # %i[ ] - Non-interpolated Array of symbols, separated by whitespace
  # before_action call method before the actions
  
  before_action :set_ticket, only: %i[show edit update destroy]
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = current_user.tickets.build
  end

  def edit
  end

  # respond_to declares all the formats that you want your controller to send to your views
  def create
    @ticket = current_user.tickets.build(ticket_params)
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
      end
    end
  end
  
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  # def correct_user
  #   @ticket = current_user.tickets.find_by(id: params[:id])
  #   redirect_to tickets_path, notice: "Not Authorized To Edit This Ticket" if @ticket.nil?
  # end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:name, :email, :phone_number, :age, :no_of_tickets, :user_id)
    end
end