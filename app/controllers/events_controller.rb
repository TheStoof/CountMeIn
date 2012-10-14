class EventsController < ApplicationController
  
  before_filter :authenticate_user
  
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    
    if @event.save
      redirect_to :controller => 'events', :action => 'index'
    else
      render "new"
    end
  end

  def update
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  end

  def index
    @event = Event.all
    @event.delete_if {|x| x.public == 0}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def search
    if params[:search]
      @results = Event.find(:all, :conditions => ['name || location || username LIKE ?', "%#{params[:search.downcase]}%"])
    else
      @results = []
    end
  end
  
end
