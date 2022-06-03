# Exercise

An exercise that takes as input a text file containing a table of
employees containing their names and schedules to output pairs of
employees and the times they've coincided in office.

## Overview

**input:**
```
PEDRO=MO6:00-11:00,TH12:00-16:00,SU15:00-21:00
PABLO=MO8:00-13:00,TU10:00-16:00,TH11:00-17:00
JUANA=MO9:00-13:00,TH12:00-17:00,SU11:00-15:00
```

**output:**
```
PABLO-PEDRO: 2
JUANA-PABLO: 2
PEDRO-JUANA: 3
```

## Architecture

The program consists of 4 parts:
1. Parsing input file as an array of Employees.
2. Create an array of pairs of Employees.
3. Map through that array creating a hash with the concatenation of
the names of the employees as keys and the amount of times they
coincided in office as values.
4. Printing the hash in a table format.

**in detail:**

1. The program reads the text file and parses its lines as structures
of employees, which are made by their names and a hash of the days and
hours they attended containing the ranges of hours for each day.
	1. The name of the employee and the schedule are separated into
	different variables by an equal sign character.
	2. The name of the employee is left as is.
	3. The hash of days and hours is made by splitting the schedule by
	comma characters, thus creating an array of strings that is mapped
	into a hash by separating the first two characters of each string
	as a key that represents the day, and the remaining string is
	split by the dash sign character into the the starting hour and
	ending hour, these are converted to integers and a range is
	created between these two.

2. An array of pairs of employees is created to be mapped through
returning a hash containing the the pair of employees names
contatenated with a dash and the times they have coincided.
	1. If the ammount of employees is over 2 a copy of the array of
	employees is created, rotated and zipped with the array of
	employees, thus creating an array of pairs of employees. But if
	the ammount of employees is 2 or below, the array of pairs is made
	by putting the array of employees inside another array.
	2. This array is mapped through to create a hash.
		1. The keys of the hash are the concatenation of the pair of
		employees' names with a dash sign character.
		2. The values of the hash are the count of the times they
		coincided. The schedule of the first employee of the pair is
		iterated though, if the second employee attended the day the
		first employee did and the range of hours they attended that
		day overlaps, the counter goes up by 1.
	3. At the end, for each coincidence it is printing the employees'
	pair names, followed by a colon and the amount of times they were
	in office at the same time.

## Approach

My approach was designing the program around the Employee class,
arrays and hashes to ease its reading write less. That is why I chose
Ruby as it is a fully OOP language with great array and hash mapping
capabilities.

## How to run

The program is a Ruby script so the only thing needed to run it is a
Ruby interpreter.

**command:**

	$ ./src/exercise.rb <INPUT_FILE>

**example:**

	$ ./src/exercise.rb examples/1.txt

If the Ruby interpreted failed for some reason or the file wasn't
executable it could be run this way instead:

	$ ruby src/exercise.rb examples/1.txt
