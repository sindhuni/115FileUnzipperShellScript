# 115FileUnzipperShellScript

#   name:   Sean Sindhunirmala                                                                  #
#   email:  sindhuni@usc.edu                                                                    #
#                                                                                               #
#   WHAT'S NEW?                                                                                 #
#   - It's written in Bash, so it has a faster runtime performance                              #
#   - It's implemented to handle bad submissions from students including:                       #
#       - Unzipped files                                                                        #
#       - Incorrect file names                                                                  #
#       - Incorrect folder names                                                                #
#       - Both incorrect file and folder names (to an extent)                                   #
#       - File placed in incorrect folder or subfolders (to an extent)                          #
#                                                                                               #
#   WINDOWS:                                                                                    #
#   0. Download and install GitBash at https://git-scm.com/download/win							            #
#	  1. Create a new folder to contain all of the files for the assignment you want to grade     #
#   2. Put this script and zip file downloaded from Blackboard into this folder                 #
#   3. Run the script by double clicking on it                                                  #
#   4. All the .py files should now be under "ReadyToGrade" in each student's corresponding     #
#      personal folder (Assignment configuration)                                               #
#                                                                                               #
#   MACOS:                                                                                      #
#   0. Unzip the tar file by double clicking on it								                      				#
#	  1. Create a new folder to contain all of the files for the assignment you want to grade     #
#   2. Put this script and zip file downloaded from Blackboard into this folder                 #
#   3. Running the script: open Terminal, drag this file onto Terminal window, and hit enter    #
#   4. All the .py files should now be under "ReadyToGrade" in each student's corresponding     #
#      personal folder (Assignment configuration)                                               #
#                                                                                               #
#   NOTES:                                                                                      #
#   - The program looks for python files starting with "ITP" in all subdirectories. If the file is found, it is moved to the student's corresponding personal folder in "ReadyToGrade". If you want the program to search for files with a different starting name, feel free to change it in the .sh file. #
# - If the file is not found, this means that the student didn't properly name the file, and the program moves all python files up to a depth of 2 subdirectory levels from the student's zipped folder to their peronsal folder in "ReadyToGrade". If you want the program to move all the python files within all subdirectories instead of a depth of 2, feel free to change it in the .sh file.	#
#   - The program can also handle situations when the student didn't zip the file and puts the unzipped python file in a corresponding personal folder. #
