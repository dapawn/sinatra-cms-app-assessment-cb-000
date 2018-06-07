require 'pry'

class HackController < ApplicationController

  get '/hacks' do
      @hacks = Hack.all
      erb :'hacks/hacks'
  end

  get '/hacks/new' do
      erb :'hacks/create_hack'
  end

  post '/hacks' do
    if params[:description].empty?
      redirect to "/hacks/new"
    else
      @hack = current_user.hacks.create(description: params[:description])
      redirect to "/hacks/#{@hack.id}"
    end
  end

  get '/hacks/:id' do
      @hack = Hack.find_by_id(params[:id])
      erb :'hacks/show_hack'
  end

  get '/hacks/:id/edit' do
      @hack = Hack.find_by_id(params[:id])
      if @hack.user_id == current_user.id
       erb :'hacks/edit_hack'
      else
        redirect to '/hacks'
      end
  end

  post '/hacks/:id' do
    if params[:description].empty?
      redirect to "/hacks/#{params[:id]}/edit"
    else
      @hack = Hack.find_by_id(params[:id])
      @hack.description = params[:description]
      @hack.save
      redirect to "/hacks/#{@hack.id}"
    end
  end

  delete '/hacks/:id/delete' do
      @hack = Hack.find_by_id(params[:id])
      @hack.delete if @hack.user_id == current_user.id
      redirect to '/hacks'
  end

end