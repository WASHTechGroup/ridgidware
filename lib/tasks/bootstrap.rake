namespace :bootstrap do
	desc "Add default Program data"
	task :load_programs => :environment do
		['Architectural Studies',
		'Biomedical Engineering',
		'Chemical Engineering',
		'Civil Engineering',
		'Computer Engineering',
		'Electrical Engineering',
		'Environmental Engineering',
		'Geological Engineering',
		'Management Engineering',
		'Mechanical Engineering',
		'Mechatronics Engineering',
		'Nanotechnology Engineering',
		'Software Engineering',
		'Systems Design Engineering'].each do |p|
			Program.find_or_create_by({name: p})
		end
	end

	desc "Add default roles"
	task :load_roles => :environment do
		['Admin', 'Manager', 'Staff', 'Student'].each do |r|
			Role.find_or_create_by({name: r})
		end		
	end
end