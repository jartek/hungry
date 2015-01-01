class BaseController < ApplicationController
  before_action :set_resource, only: [:update, :destroy, :show]
  before_action :create_resource, only: :create
  before_action :authorize_resource, only: [:create, :destroy, :show, :update]

  after_action :verify_authorized, except: [:index]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  respond_to :json

  def create
    if get_resource.save
      render json: get_resource, status: :created
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    get_resource.destroy
    head :no_content
  end

  def index
    pluralized_resource_name = "#{resource_name.pluralize}"
    resources = resource_klass.filtered_per_page(filter_params, pagination_params)
    instance_variable_set("@#{pluralized_resource_name}", resources)
    render json: instance_variable_get("@#{pluralized_resource_name}")
  end

  def show
    render json: get_resource, status: :ok
  end

  def update
    if get_resource.update(resource_params)
      head :ok
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  private

  def filter_params
    {}
  end

  def pagination_params
    params.permit(:page, :per_page)
  end

  def get_resource
    instance_variable_get("@#{resource_name}")
  end

  # resource_class conflicts with devise, so used klass here
  def resource_klass
    @resource_klass ||= resource_name.classify.constantize
  end

  def resource_name
    @resource_name ||= self.controller_name.singularize
  end

  def resource_params
    @resource_params ||= self.send("#{resource_name}_params")
  end

  def set_resource(resource = nil)
    resource ||= resource_klass.find(params[:id])
    instance_variable_set("@#{resource_name}", resource)
  end

  def record_not_found
    head :not_found
  end

  def create_resource
    set_resource(resource_klass.new(resource_params))
  end

  def authorize_resource
    authorize get_resource
  end
end
