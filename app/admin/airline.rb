ActiveAdmin.register Airline do
  form partial: 'form'

  index download_links: false do
    selectable_column
    column :id
    column :name
    column :created_at
    column :updated_at
    actions defaults: false do |airline|
      item 'View', airline_details_admin_airline_path(airline), class: 'member_link'
      item 'Edit', edit_admin_airline_path(airline), class: 'member_link'
      item 'Delete', admin_airline_path(airline), method: :delete
    end
  end

  controller do
    before_action :load_defaults

    def load_defaults
      if params[:id].blank?
        @airline = Airline.new
        @url = '/admin/airlines'
        @method = :post
      else
        @airline = Airline.find(params[:id])
        @seat_configs = @airline.seat_configs.includes(:seat_type_config)
        @url = "/admin/airlines/#{params[:id]}"
        @method = :patch
      end
    end

    def create
      begin
        @airline = Airline.new(airline_params)
        if @airline.save!
          @airline.seat_configs.import(params[:airline][:seat_config_attributes].values.map(&:symbolize_keys))
          flash[:success] = 'Airline added'
          redirect_to '/admin/airlines'
        end
      rescue Exception => ex
        flash[:error] = ex.message
        return render :new
      end
    end

    def update
      begin
        @airline.update!(airline_params)
        @seat_configs.each_with_index do |seat_config, index|
          seat_config.update!(params[:airline][:seat_config_attributes].values[index])
        end
        flash[:success] = 'Airline details updated'
        redirect_to '/admin/airlines'
      rescue Exception => ex
        flash[:error] = ex.message
        return render :edit
      end
    end

    def airline_params
      params.require(:airline).permit(:name)
    end
  end

  member_action :airline_details, method: :get do
    begin
      @airline = Airline.find(params[:id])
      @seat_configs = @airline.seat_configs.includes(:seat_type_config)
    rescue Exception => ex
      flash[:error] = ex.message
    end
  end
end
