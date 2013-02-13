class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  layout "out", :only=>[:print]
  def index
    @registration = Registration.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find_by_pid("PRH"+params[:pid])

    if @registration.nil?
      redirect_to registrations_path,alert: "You have not registered already! Please register."
    end

  end

  def list
    @registrations=Registration.all
    @registrations=Kaminari.paginate_array(@registrations).page(params[:page]).per(3)
  end

  def print
    @registrations=Registration.all
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @registration = Registration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    if !Registration.find_by_email(params[:registration][:email])
      @registration = Registration.new(params[:registration])
      if @registration.save
        @registration.generate_pid
        redirect_to registration_path({:id=>1,:pid=>@registration.pid[3..6]}), alert: 'Registration was succesful!'
      else
        redirect_to registrations_path,alert: "Registration Failed! Try again."
      end
    else
      redirect_to registrations_path,notice: "Given email has already been registered!"
    end

  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to registration_path({:id=>1,:pid=>@registration.pid}), notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end
end
