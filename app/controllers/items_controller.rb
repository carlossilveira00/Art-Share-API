class ItemsController < ApplicationController
  def index
    @items = Item.all

    @items.each do |item|
      # Set the first photo from the item photos as the image_url to be displayed in the home page.
      item.image_url = item.photos[0].url if item.photos.attached?
    end

    render json: ItemBlueprint.render(@items)
  end

  def user_items
    @items = Item.where(user: params[:user_id])

    render json: ItemBlueprint.render(@items)
  end

  def show
    @item = Item.find(params[:id])
    item_photos_urls = []

    @item.photos.each { |photo| item_photos_urls << photo.url }

    render json: {item: @item, photos_urls: item_photos_urls }
  end

  def create
    item_photos = []
    params[:photos].each do |photo|
      item_photos << photo[1]
    end

    @item = Item.new(item_params)
    @item.update(photos: item_photos)
    if @item.save
      render json: ItemBlueprint.render(@item)
    else
      render json: {
        message: 'Could not create item.',
        status: :unauthorized
      }
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      render json: ItemBlueprint.render(@item)
    else
      render json: {
        message: 'Could not update this item.',
        status: :unauthorized
      }
    end
  end

  def destroy
    @item = Item.find(params[:id])

    if @item.destroy
      render json: {
        message: 'This item was destroyed.'
      }, status: :ok
    else
      render json:{
        error: @item.errors.messages
      }, status: :unauthorized
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category, :current_situation, :location, :user_id, :price)
  end
end
