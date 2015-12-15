class Admin::LocationsController < AdminsController
  def index
  end

  def new
    @location = Location.new
    @captured_image = @location.captured_images.build
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to admin_locations_path
    else
      render :new
    end
  end

  private
  def location_params
    params.require(:location).permit(:name, :introduction, :prefecture, captured_images_attributes: [:name, :status])
  end
end
