#!/bin/env ruby

=begin
The company ACME offers their employees the flexibility to work the
hours they want. But due to some external circumstances they need to
know what employees have been at the office within the same time frame

The goal of this exercise is to output a table containing pairs of
employees and how often they have coincided in the office.
=end

class Range
	def overlaps? range
		last >= range.first and range.last >= first
	end
end

Employee = Struct.new :name, :schedule do
	def initialize name, schedule
		self.name = name
		self.schedule = Employee.parse_schedule schedule
	end
	def self.parse_schedule schedule
		(schedule.split ',').to_h do |day_and_hours|
			day = day_and_hours [..1]
			hour_start, hour_end = day_and_hours [2..].split '-', 2
			[day, hour_start.to_i...hour_end.to_i]
		end
	end
end

# parsing input file as an array of employees
INPUT = File.read ARGV.first
EMPLOYEES = INPUT.lines.map do |line|
	name, schedule = line.chomp.split '=', 2
	Employee.new name, schedule
end

# create and array of pairs of employees
PAIRS = EMPLOYEES.combination 2

# map though the pairs and create a hash with the employees and the
# times they coincided in office
COINCIDENCES = PAIRS.to_h do |employee_1, employee_2|
	[
		# ex: "ASTRID-RENE"
		employee_1.name + '-' + employee_2.name,
		# ex: 2
		employee_1.schedule.count do |day, range_1|
			range_2 = employee_2.schedule[day]
			range_2 and range_1.overlaps? range_2
		end
	] # ex: "ASTRID-RENE" => 2
end

# printing the coincidences
COINCIDENCES.each do |employees, times|
	puts "#{employees}: #{times}"
end

