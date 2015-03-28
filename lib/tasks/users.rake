namespace :users do
	desc "Add a user as an admin"
	task :new_admin, [:username] => :environment do |t, args|
		args.with_defaults(:username => nil)
		if args.username != nil
			user = User.find_by({username: args.username})
			if user
				user.role = Role.find_by({name: "Admin"})
				user.save!
			else
				puts "User #{args.username} does not exist"	
			end
		end
	end
end