class BaseController < ApplicationController
  before_action :set_resource, only: [:update, :destroy, :show]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  respond_to :json

  def create
    set_resource(resource_class.new(resource_params))
    authorize get_resource
    if get_resource.save
      render json: get_resource, status: :created
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize get_resource
    get_resource.destroy
    head :no_content
  end

  def index
    pluralized_resource_name = "#{resource_name.pluralize}"
    resources = resource_class.filtered_per_page(filter_params, pagination_params)
    instance_variable_set("@#{pluralized_resource_name}", resources)
    render json: instance_variable_get("@#{pluralized_resource_name}")
  end

  def show
    render json: get_resource, status: :ok
  end

  def update
    authorize get_resource
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

  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  def resource_name
    @resource_name ||= self.controller_name.singularize
  end

  def resource_params
    @resource_params ||= self.send("#{resource_name}_params")
  end

  def set_resource(resource = nil)
    resource ||= resource_class.find(params[:id])
    instance_variable_set("@#{resource_name}", resource)
  end

  def record_not_found
    head :not_found
  end
end
