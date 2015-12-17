=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
class Administration::CustomersController < ApplicationController
  before_action :login_required
  before_action :role_required
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :follow_button]
  
  def index 
    redirect_to all_administration_customers_path  
  end

  def all
    manufacturer = Role.with_name(:manufacturer).id
    distributor = Role.with_name(:distributor).id
    simple_customer = Role.with_name(:simple_customer).id
    
    @customers = User.all_customers([simple_customer, distributor, manufacturer]).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
    #@employee = User.paginate(:page => params[:page], :per_page => 10).order(last_name: :desc)
  end

  def manufacturers
    @customers = User.manufacturers.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def distributors
    @customers = User.distributors.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def simple_customers
    @customers = User.simple_customers.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    if @customer.company.try(:any?)
      #@featured_products = @customer.company.products.filter(params.slice(:status, :location, :starts_with)).last(12)
      @featured_products = @customer.company.products.last(12)
    else
      #redirect_to :root
      @featured_products = nil
      toast :error, "Ошибка."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = User.find(params[:id])
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end