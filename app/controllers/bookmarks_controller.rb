class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    @bookmark.save
    redirect_to list_path(@list)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    # On pourrait croire que bookmark.list n'est plus dispo puisque ci dessus
    # j'ai fait Bookmark.destroy mais mon super buddy Thibault m'explique que
    # La methode destroy ne détruit reellement @bookmark qu'après avoir effectué toute la méthode
    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
