class EventsController < ApplicationController
	# Event.all會抓出所有的資料，回傳一個陣列給實例變數(instance variables)指派給@events
	def index
		@events = Event.all
		# 上述的程式用Event.all一次抓出所有活動，
		# 這在資料量一大的時候非常浪費效能和記憶體。
		# 通常會用分頁機制來限制抓取資料的筆數。
		@events = Event.page(params[:page]).per(10)

	end

	# 透過before_action，我們可以將Controller中重複的程式獨立出來。
	before_action :set_event, :only => [ :show, :edit, :update, :destroy]

	# using event instead of events, 實例化一個空的Event物件
	def new
		@event = Event.new  
		# 網址變成 /new.html
	end
	def create
		@event = Event.new(event_params)  #params[:event]
		# Rails 4 is different. Here is reason: http://stackoverflow.com/questions/17371334/how-is-attr-accessible-used-in-rails-4
		# @event.save
  		#redirect_to :action => :index

  		# 驗證錯誤並顯示錯誤訊息
  		if @event.save
		    redirect_to events_url
		else
		    render :action => :new
		end

		flash[:notice] = "event was successfully created"
	end

	def show
  		# @event = Event.find(params[:id])  
  		@page_title = @event.name
	
  		# 依照id 另外成立新網頁顯示
  		# 這個show Action用find方法從資料庫中找出該篇活動。找到資料之後，Rails用show.html.erb樣板顯示出來。
	end
		# 同理
	def edit
  		# @event = Event.find(params[:id])
	end

	def update
	  # @event = Event.find(params[:id])
	  @event.update(event_params)
	  # 驗證錯誤並顯示錯誤訊息
		if @event.save
		    redirect_to events_url(@event)
		else
		    render :action => :new
		end
		flash[:notice] = "event was successfully created"
	end

	def destroy
		# @event = Event.find(params[:id])
		@event.destroy

		redirect_to events_url
		flash[:alert] = "event was successfully deleted"
	end




	# private以下的所有方法都會變成private方法，所以記得放在檔案的最底下。
	private
	def event_params
		params.require(:event).permit(:name, :description)
	end

	def set_event
	  @event = Event.find(params[:id])
	end

end