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
			puts p
			Program.find_or_create_by({name: p})
		end
	end

	desc "Add default roles"
	task :load_roles => :environment do
		['Admin', 'Manager', 'Staff', "Ordering Officer", "VPFin", 'Student'].each do |r|
			puts r
			Role.find_or_create_by({name: r})
		end		
	end

	desc "Add Parts"
	task :load_parts => :environment do
		[[ "900-00005-ND",  "Motor Servo DC Geared 6V",  "900-000005", "Digi-Key",  16.33,  3], 
		 [ "2N3904FS-ND",  "IC TRANS NPN SS GP 200MA TO-92",  "2N3904BU", "Digi-Key",  0.00,  0],
		 [ "2N3906-APCT-ND",  "TRANSISTOR PNP SS GP 200MA TO-92",  "2N3906-AP", "Digi-Key",  0.00,  0],
		 [ "497-2537-5-ND",  "TRANS NPN DARL 80V 5A TO-220",  "TIP121", "Digi-Key",  0.8744,  25], 
		 [ "497-1491-5-ND",  "IC REG LDO 3.3V 0.8A TO220AB",  "LD1117V33", "Digi-Key",  0.674,  10],
		 [ "497-7311-5-ND",  "IC REG LDO 5V 0.8A TO220AB",  "LD1117V50", "Digi-Key",  0.674,  10],
		 [ "LM7809CT-ND",  "IC REG LDO 9V 1A TO220-3",  "LM7809CT", "Digi-Key",  0.739,  10],
		 [ "KA378R12CTUFS-ND",  "IC REG LDO 12V 3A TO220FL",  "KA378R12CTU", "Digi-Key",  1.483,  10],
		 [ "T1062-P5RP-ND",  "TRANS WALL 12VDC 1.0A LEVEL V",  "EPSA120100U-P5RP-EJ", "Digi-Key",  15.46,  4],
		 [ "237-1453-ND",  "PWR SUPPLY WALL 12V 0.7A ",  "WSU120-0700", "Digi-Key",  8.66,  0],
		 [ "993-1236-ND",  "PWR SUPPLY WALL 5V 550MA 3W",  "PSM03A-050-R", "Digi-Key",  5.64,  5],
		 [ "T1186-P5RP-ND",  "WALL ADPT PLUG 5VDC 2.5A P5RP",  "EPSA050250U-P5RP-EJ", "Digi-Key",  15.46,  2],
		 [ "T1187-P5RP-ND",  "WALL ADPT PLUG 6VDC 2A PRP5",  "EPSA060200U-P5RP-EJ", "Digi-Key",  0.00,  0],
		 [ "SAM1013-50-ND",  "CONN HEADER 50POS .100\" SGL GOLD",  "TSW-150-05-G-S", "Digi-Key",  5.66,  3],
		 [ "SAM1089-50-ND",  "CONN RCPT .100\" 50POS SNGL GOLD",  "SLW-150-01-G-S", "Digi-Key",  8.99,  3],
		 [ "CLA357-ND",  "MOSFET DVR ULT FAST 14A 8-DIP",  "IXDD614PI", "Digi-Key",  3.27,  5],
	   	 [ "FQP30N06L-ND",  "MOSFET N-CH 60V 32A TO-220",  "FQP30N06L", "Digi-Key",  1.48,  5],
		 [ "296-8251-5-ND",  "IC 8-bit SHIFT REGISTER 16-DIP",  "SN74HC165N", "Digi-Key",  0.484,  25],
		 [ "ED2740-ND",  "TERMINAL BLOCK 3.5MM 2POS PCB",  "OSTTE020104", "Digi-Key",  0.457,  10],
		 [ "ATMEGA328-PU-ND",  "IC MCU 8BIT 32KB FLASH 28DIP",  "ATMEGA328-PU", "Digi-Key",  4.29,  5],
		 [ "3310R-125-103L-ND",  "POT 10K OHM 9MM SQ PLASTIC",  "3310R-125-103L", "Digi-Key",  3.12,  5]].each do |data|
		 	puts data[0]
		 	part = Part.find_or_create_by({part_number:data[0], description:data[1], mfg_part_no:data[2], default_supplier:data[3], price:data[4].to_f})
	 		part.inventory = Inventory.new
	 		part.inventory.on_hand = data[5] 
	 		part.save!
		 end


		 desc "Add all the default data"
		task :all => [:load_parts, :load_roles, :load_programs]
	end
end