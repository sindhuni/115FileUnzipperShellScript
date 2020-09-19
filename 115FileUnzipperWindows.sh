#!/bin/sh

#################################################################################################
#                                                                                               #
#   name:   Sean Sindhunirmala                                                                  #
#   email:  sindhuni@usc.edu                                                                    #
#                                                                                               #
#   How To:                                                                                     #
#   0. Download and install GitBash at https://git-scm.com/download/win							#
#	1. Create a new folder to contain all of the files for the assignment you want to grade     #
#   2. Put this script and zip file downloaded from Blackboard into this folder                 #
#   3. Run the script by double clicking on it                                                  #
#   4. All the .py files should now be under "ReadyToGrade" in each student's corresponding     #
#      personal folder (Assignment configuration)                                               #
#                                                                                               #
#   NOTES:                                                                                      #
#       - The program looks for python files starting with "ITP" in all subdirectories. If the	#
# 		  file is found, it is moved to the student's corresponding personal folder in			#
#		  "ReadyToGrade". If you want the program to search for files with a different starting #
# 		  name, feel free to change it below.													#
#		- If the file is not found, this means that the student didn't properly name the file,  #
#		  and the program moves all python files up to a depth of 2 subdirectory levels from	#
#		  the student's zipped folder to their peronsal folder in "ReadyToGrade". If you want 	#
#		  the program to move all the python files within all subdirectories instead of a depth	#
#		  of 2, feel free to change it below.													#
#		- The program can also handle situations when the student didn't zip the file and puts  #
#		  the unzipped python file in a corresponding personal folder.							#
#																								#
#################################################################################################

# -------------- MODIFY THE FOLLOWING AS NECESSARY -------------- #

# The script will search for python files with this starting word
StartingWord="ITP"

# The program will search for all python files in current directory and 1 level of subdirectory
declare -i folderDepth=2

# --------------------------------------------------------------- #

# outputs log file
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>logfile_"$(date +'%Y-%m-%d_%H-%M-%S')".txt 2>&1

# creates ReadyToGrade and AllLeftOverFiles directories
mkdir "ReadyToGrade"
mkdir "AllLeftoverFiles"
# creates subdirectories in AllLeftOverFiles directory
if cd "AllLeftoverFiles"
then
	mkdir "StudentZips"
	mkdir "StudentFiles"
	cd ..
fi
# if in ReadyToGrade directory...
if cd "ReadyToGrade"
# unzips all zip files in the folder
then
	unzip ../\*.zip
else
	echo "ERROR: Failed to unpack zip file"
fi
# moves all the text files to StudentZips directory
# if student forgets to zip file, whatever file was uploaded except .txt files will still be in this folder
find . -name "*.txt" -exec mv "{}" ../AllLeftoverFiles/StudentZips \;

# for every zipped file...
for zip in *.zip
do
	# sets directory name to their Blackboard username
  dir=`echo $zip | sed 's/\.zip$//'`
  dirname="${dir#*_}"; dirname="${dirname%%_*}"
	# creates the student's directory
  if mkdir "$dirname"
  then
	# if inside the student's directory
    if cd "$dirname"
    then
	  # unzips student's zipped file
      unzip ../"$zip"
	  # return to StudentFiles directory
	  cd ../../"AllLeftoverFiles"/"StudentFiles"
	  # creates the student's directory for leftover files
	  mkdir "$dirname"
	  # return to ReadyToGrade directory
	  cd ../../"ReadyToGrade"
	  # moves all of the student's files to the leftover files
	  mv "$dirname"/* ../"AllLeftoverFiles"/"StudentFiles"/"$dirname"
    else
      echo "ERROR: Could not unpack $zip - cd failed"
    fi
  else
    echo "ERROR: Could not unpack $zip - mkdir failed"
  fi
done

# moves all of the student's zipped files to StudentZips
# if student forgets to zip file, whatever file was uploaded except .txt files will still be in this folder
find . -name "*.zip" -type f -exec mv {} ../"AllLeftoverFiles"/"StudentZips" \;

# if there are no python files...
if find . -maxdepth 1 -name '*.py' -type f -exec false {} +
then
	echo "No python files found."
# otherwise, there are python files
else
	# for every python file...
	for python in *.py
	do
		# creates a directory for the student
		dir=`echo $python | sed 's/\.python$//'`
		dirname="${dir#*_}"; dirname="${dirname%%_*}"
		if mkdir "$dirname"
		then
			# enters the directory created
			if cd "$dirname"
			then
				# moves python file into this directory
				mv ../"$python" .
				# renames the python file to a more readable format
				mv "$python" "$dirname.py"
			else
				echo "ERROR: Unable to create python file"
			fi
			cd ..
		else
			echo "ERROR: Unable to create directory"
		fi
	done
fi



# returns to the StudentFiles directory
cd ../"AllLeftoverFiles"/"StudentFiles"

# for every student's directory in the AllLeftOverFiles directory...
for sub in */
do
	if cd "$sub"
	then
		# if file not found...
		if find . -name '*.py' -a -name "${StartingWord}*" -type f -exec false {} +
		then
			# finds all of their python files
			# moves them to the student's subdirectory in the ReadyToGrade directory
			find . -maxdepth $folderDepth -type f -name '*.py' -exec mv {} ../../../"ReadyToGrade"/"$sub" \;
		# otherwise, file found...
		else
			# finds the python file starting with StartingWord
			# moves them to student's subdirectory in the ReadyToGrade directory
			find . -name '*.py' -a -name "${StartingWord}*" -type f -exec mv {} ../../../"ReadyToGrade"/"$sub" \;
		fi
		# return to StudentFiles directory
		cd ..
	else
		echo "ERROR: Did not move .py files to student directory in ReadyToGrade"
	fi
done


