class ReportsController < ApplicationController
	require 'csv'

	def daily
		@transactions = Transaction.where("created_at >= ?", Time.zone.now.end_of_day)
		respond_to do |format| 
			format.html
				format.csv { send_data @transactions.to_csv }
				format.xls
				format.pdf do
						render pdf: "RigidWare - Daily - #{Time.zone.now.to_date}",
										 template: 'reports/daily.pdf.html',
										 disposition: 'attachment'
					end
		end
	end

	def weekly
		@transactions = Transaction.where("created_at >= ?", Time.zone.now.end_of_week)
		respond_to do |format| 
			format.html
				format.csv { send_data @transactions.to_csv }
				format.xls
				format.pdf do
						render pdf: "RigidWare - Weekly - #{Time.zone.now.to_date}",
										 template: 'reports/daily.pdf.html',
										 disposition: 'attachment'
					end
		end
	end

	def monthly
		@transactions = Transaction.where("created_at >= ?", Time.zone.now.end_of_month)
		respond_to do |format| 
			format.html
				format.csv { send_data @transactions.to_csv }
				format.xls
				format.pdf do
						render pdf: "RigidWare - Monthly - #{Time.zone.now.to_date}",
										 template: 'reports/daily.pdf.html',
										 disposition: 'attachment'
					end
		end
	end

	def quarterly
		@transactions = Transaction.where("created_at >= ?", Time.zone.now.end_of_quarter)
		respond_to do |format| 
			format.html
				format.csv { send_data @transactions.to_csv }
				format.xls
				format.pdf do
						render pdf: "RigidWare - Quarterly - #{Time.zone.now.to_date}",
										 template: 'reports/daily.pdf.html',
										 disposition: 'attachment'
					end
		end
	end

	def yearly
		@transactions = Transaction.where("created_at >= ?", Time.zone.now.end_of_year)
		respond_to do |format| 
			format.html
				format.csv { send_data @transactions.to_csv }
				format.xls
				format.pdf do
						render pdf: "RigidWare - Daily - #{Time.zone.now.to_date}",
										 template: 'reports/daily.pdf.html',
										 disposition: 'attachment'
					end
		end
	end

	def audit
	end

	def po_report
	end

	def inventory
		@inv = Inventory.all 
		respond_to do |format| 
			format.html
				format.csv { send_data @transactions.to_csv }
				format.xls
				format.pdf do
						render pdf: "RigidWare - Inventoryu - #{Time.zone.now.to_date}",
										 template: 'reports/inventory.pdf.html',
										 disposition: 'attachment'
					end
		end
	end
end
