=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::EmployeesController < ApplicationController
  before_action :login_required
  before_action :role_required
  before_action :set_employee, only: [:show, :edit, :update]
  
  helper_method :sort_column, :sort_direction

  def index 
    @employees = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
    #@employee = User.paginate(:page => params[:page], :per_page => 10).order(last_name: :desc)
  end

  def all
    @employees = User.manufacturers.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def administrators
    @employees = User.administrators.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def moderators
    @employees = User.moderators.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def operators
    @employees = User.operators.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end 

  def show 
    #redirect_to user_path(params[:id]) 
  end 
  
  # GET /administration/employees/1/edit
  def edit
  end

  # PATCH/PUT /administration/employees/1
  # PATCH/PUT /administration/employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
         
        format.html {
          if params[:stay] 
            redirect_to edit_administration_employee_path(@employee)
            toast :success, "Сотрудник #{full_name_user(@employee)} был успешно обновлен."
          else
            redirect_to administration_employees_path
            toast :success, "Сотрудник #{full_name_user(@employee)} был успешно обновлен."
          end
        }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:user).permit(
        :first_name,
        :last_name         
      )
    end
    
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end