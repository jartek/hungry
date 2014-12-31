shared_examples 'an api resource' do |args|
  let(:resource_class) { args[:resource].capitalize.constantize }
  let(:resource) { args[:resource] }
  let(:nested_resource) { args[:nested_resource] }

  let(:object) { double("#{resource_class}", { id: 1 }) }
  let(:another_object) { double("#{resource_class}", { id: 2 }) }

  describe "Setup" do
    before do
      @params ||= {}
      @params["#{nested_resource}_id"] = 123 if nested_resource
      get :index, @params
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
      @params["#{nested_resource}_id"] = 123 if nested_resource
      @params[resource] = {
        id: 123
      }
    end

    context 'with valid data' do
      context 'authorized user' do
        it "creates a resource" do
          allow(resource_class).to receive(:new).and_return(object)
          allow(controller).to receive(:authorize).with(object)
          allow(object).to receive(:save).and_return(true)
          post :create, @params

          expect(response).to have_http_status(:created)
        end
      end

      context 'unauthorized user' do
        it "does not create a resource" do
          allow(resource_class).to receive(:new).and_return(object)
          allow(controller).to receive(:authorize).with(object).and_raise(Pundit::NotAuthorizedError)
          allow(object).to receive(:save).and_return(true)
          post :create, @params

          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'with invalid data' do
      it "does not create a resource" do
        allow(resource_class).to receive(:new).and_return(object)
        allow(controller).to receive(:authorize).with(object)
        allow(object).to receive(:save).and_return(false)
        allow(object).to receive(:errors)

        post :create, @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      @params ||= {}
      @params["#{nested_resource}_id"] = 123 if nested_resource
    end

    context 'with valid data' do
      before do
        @params["id"] = object.id
      end

      context 'authorized user' do
        it "destroys a resource" do
          allow(resource_class).to receive(:find).and_return(object)
          allow(controller).to receive(:authorize).with(object)
          allow(object).to receive(:destroy).and_return(true)
          delete :destroy, @params

          expect(response).to have_http_status(:no_content)
        end
      end

      context 'unauthorized user' do
        it "destroys a resource" do
          allow(resource_class).to receive(:find).and_return(object)
          allow(controller).to receive(:authorize).with(object).and_raise(Pundit::NotAuthorizedError)
          allow(object).to receive(:destroy).and_return(true)
          delete :destroy, @params

          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'with invalid data' do
      before do
        @params["id"] = 123456
      end

      it "throws a 404 if resource is not found" do
        delete :destroy, @params

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    before do
      @params ||= {}
      @params["#{nested_resource}_id"] = 123 if nested_resource
    end

    it "returns a list of resources" do
      objects = [object, another_object]
      allow(resource_class).to receive(:filtered_per_page).and_return(objects)
      get :index, @params
      expect(assigns["#{resource.pluralize}"]).to eq(objects)
    end
  end

  describe "GET /show" do
    before do
      @params ||= {}
      @params["#{nested_resource}_id"] = 123 if nested_resource
    end

    context 'with valid data' do
      before do
        @params["id"] = object.id
      end

      it "returns successfully" do
        allow(resource_class).to receive(:find).and_return(object)

        get :show, @params
        expect(response).to have_http_status(:ok)
      end

      it "returns a resource" do
        allow(resource_class).to receive(:find).and_return(object)
        get :show, @params

        expect(assigns[resource]).to eq(object)
      end
    end

    context 'with invalid data' do
      before do
        @params["id"] = 123456
      end

      it "throws a 404 if resource is not found" do
        get :show, @params

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT /update" do
    before do
      @params ||= {}
      @params["#{nested_resource}_id"] = 123 if nested_resource
      @params["id"] = object.id
      @params[resource] = {
        new_data: '123'
      }
    end

    context 'with valid data' do
      context 'authorized user' do
        it "returns successfully" do
          allow(resource_class).to receive(:find).and_return(object)
          allow(controller).to receive(:authorize).with(object)
          allow(object).to receive(:update).and_return(true)
          put :update, @params

          expect(response).to have_http_status(:ok)
        end
      end

      context 'unauthorized user' do
        it "returns successfully" do
          allow(resource_class).to receive(:find).and_return(object)
          allow(controller).to receive(:authorize).with(object).and_raise(Pundit::NotAuthorizedError)
          allow(object).to receive(:update).and_return(true)
          put :update, @params

          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'with invalid data' do
      it "throws a 404 if resource is not found" do
        @params["id"] = 123456
        allow(controller).to receive(:authorize).with(object)
        put :update, @params

        expect(response).to have_http_status(:not_found)
      end

      it "returns a 422 if it fails" do
        allow(resource_class).to receive(:find).and_return(object)
        allow(controller).to receive(:authorize).with(object)
        allow(object).to receive(:update).and_return(false)
        allow(object).to receive(:errors)
        put :update, @params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
