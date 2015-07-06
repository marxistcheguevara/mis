require 'dm-core'
require 'dm-migrations'


DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/users.db")

class User
	include DataMapper::Resource
	property :id, Serial
	property :fname, String
	property :lname, String
	property :username, String
	property :password, String
	property :bio, Text
	property :role, Integer, :default => 0

	def rolename
		if self.role ==1
			"Head of Dep."
		elsif self.role ==2
			"Chief Nurse"
		elsif self.role ==3
			"Just Nurse"
		elsif self.role ==4
			"Doctor"
		end
	end

end


class Journal
	include DataMapper::Resource
	property :id, Serial
	property :identity, Integer, :unique_index => :uniqueness
	property :fname, String
	property :lname, String
	property :mname, String
	property :assigned_doctor, String
	property :detail_one, Text
	property :detail_two, Text
	property :detail_three, Text
	property :detail_four, String
	property :other_detail, String
	property :some_other_detail, String
	property :another_detail, Text
	property :created, DateTime, :default => Time.now
	property :viewed, Boolean, :default => false


end

class Manual
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :title, String
	property :body, Text
end


DataMapper.finalize

module JournalHelpers
	def find_journals
		@journals = Journal.all
	end

	def find_journal
		Journal.get(params[:id])
	end

	def create_journal
		@journal = Journal.create(params[:journal])
	end
end

helpers JournalHelpers

get '/journals' do 
	find_journals
	erb :journals
end

#new
get '/journals/new' do
	#protected!
	@journal = Journal.new
	erb :new_journal
end


#show
get '/journals/:id' do
	@journal = find_journal
	@journal.viewed = true
	erb :show_journal
end

#create
post '/journals' do
	#protected!
  flash[:notice]= "Journal was succesfull posted" if create_journal
  redirect to("/journals/#{@journal.id}")
end

#edit
get '/journals/:id/edit' do
	#protected!
	@journal = find_journal
	erb :edit_journal
end

#put/update

put '/journals/:id' do
	#protected!
	journal = find_journal
	if journal.update(params[:journal])
		flash[:notice] = "Journal successfully updated"
	end
	redirect to("/journals/#{journal.id}")
end

#delete 
# delete '/journals/:id' do
# 	#protected!
# 	if find_journal.destroy
# 		flash[:notice] = "Journal deleted"
# 	end
# 		redirect to('/journals')
# end
