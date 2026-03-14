# Original script by Esmael Haddadian and Kipp Johnson
# Modified by Bernard Xie for Lab 5
# 23 Jan 2016
#
# Measures the RG of a protein trajectory
# Usage: source rg.tcl
# Outputs calculations to the file rg.dat

# In this exercise, we are going to provide the pseudocode for the RG
# calculation, and you will need to write every line

## SETUP - This portion will be very similar to the setup of the RMSD script
set filename "2HIUb24_A17B22_distance.dat"


# Select the top molecule using "molinfo top" command and set it to a molecule variable
set mol [molinfo top]

# Open a file called "rg.dat", and set this to a file variable
set outfile [open $filename "w"]

set reference [atomselect top "protein" frame 0]

set num_steps [molinfo $mol get numframes]

puts $outfile "Frame\tDistance"

## COMPUTATION - Like RMSD, we will be iterating over each frame of the trajectory

for {set i 0} {$i < $num_steps} {incr i} {
    # Set the selection to the current frame using the command
    # "(selection variable) frame (iterator variable)"
    set selection [atomselect $mol "protein" frame $i]	

    
    #2HIU: 249 250 and 646 649
	set dist1 [measure bond {249 646} frame $i]
    set dist2 [measure bond {249 649} frame $i]
    set dist3 [measure bond {250 646} frame $i]
    set dist4 [measure bond {250 649} frame $i]
    set dist [expr {min($dist1, $dist2, $dist3, $dist4)}]

    # Write the string "(frame variable)\t(RG variable)" to your file.  The tab is used
    # so that plotting software can recognize how the frame and RG are separated.
	puts $outfile "$i\t$dist"

    # Close the for loop
}

# Close the output file
close $outfile
