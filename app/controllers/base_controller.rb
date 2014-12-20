class BaseController < ApplicationController
  before_action :set_resource, only: [:update, :destroy, :show]
  respond_to :json

  def create
    set_resource(resource_class.build(resource_params))

    if get_resource.save
      render :show, status: :created
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if get_resource.destroy
      head :no_content
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  def index
    pluralized_resource_name = "#{resource_name.pluralize}"
    resources = resource_class.where(filter_params).page(pagination_params[:page]).per(pagination_params[:per_page])
    instance_variable_set("@#{pluralized_resource_name}", resources)
    respond_with instance_variable_get("@#{pluralized_resource_name}")
  end

  def show
    respond_with get_resource
  end

  def update
    if get_resource.update(resource_params)
      render :show, status: :ok
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
end
