require 'rails_helper'

shared_examples 'api resource' do |args|
  let(:resource_class) { args[:resource].capitalize.constantize }
  let(:resource) { args[:resource] }

  let(:object) { double("#{resource_class}", { id: 1 }) }
  let(:another_object) { double("#{resource_class}", { id: 2 }) }

  describe "Setup" do
    before do
      get :index
    end

    it "sets the correct resource name" do
      expect(assigns[:resource_name]).to eql(resource)
    end

    it "sets the correct resource class" do
      expect(assigns[:resource_class]).to eql(resource_class)
    end
  end

  describe "POST /create" do
    before do
      @params ||= {}
      @params[resource] = {
        id: 123
      }
    end

    context 'with valid data' do
      it "creates a resource" do
        allow(resource_class).to receive(:new).and_return(object)
        allow(object).to receive(:save).and_return(true)
        post :create, @params

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid data' do
      it "does not create a resource" do
        allow(resource_class).to receive(:new).and_return(object)
        allow(object).to receive(:save).and_return(false)
        allow(object).to receive(:errors)

        post :create, @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    context 'with valid data' do
      it "destroys a restaurant" do
        allow(resource_class).to receive(:find).and_return(object)
        allow(object).to receive(:destroy).and_return(true)
        delete :destroy, {
          id: object.id
        }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid data' do
      it "throws a 404 if restaurant is not found" do
        delete :destroy, {
          id: 123456
        }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    it "returns a list of restaurants" do
      objects = [object, another_object]
      allow(resource_class).to receive(:filtered_per_page).and_return(objects)
      get :index
      expect(assigns[:restaurants]).to eq(objects)
    end
  end

  describe "GET /show" do
    context 'with valid data' do
      it "returns successfully" do
        allow(resource_class).to receive(:find).and_return(object)

        get :show, {
          id: object.id
        }
        expect(response).to have_http_status(:ok)
      end

      it "returns a restaurant" do
        allow(resource_class).to receive(:find).and_return(object)
        get :show, {
          id: object.id
        }

        expect(assigns[:restaurant]).to eq(object)
      end
    end

    context 'with invalid data' do
      it "throws a 404 if restaurant is not found" do
        get :show, {
          id: 123456
        }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT /update" do
    before do
      @params ||= { id: 123 }
      @params[resource] = {
        new_data: '123'
      }
    end

    context 'with valid data' do
      it "returns successfully" do
        allow(resource_class).to receive(:find).and_return(object)
        allow(object).to receive(:update).and_return(true)
        put :update, @params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid data' do
      it "throws a 404 if restaurant is not found" do
        put :update, {
          id: 123456
        }

        expect(response).to have_http_status(:not_found)
      end

      it "returns a 422 if it fails" do
        allow(resource_class).to receive(:find).and_return(object)
        allow(object).to receive(:update).and_return(false)
        allow(object).to receive(:errors)
        put :update, @params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
