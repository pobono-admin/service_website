class Event < ActiveRecord::Base
	validates_presence_of :name
	# 名字必填
end
