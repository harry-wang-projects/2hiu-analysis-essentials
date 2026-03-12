# Original script by Esmael Haddadian and Kipp Johnson
# Modified by Bernard Xie and Rajiv Venkatesh for Lab 7
# February 15, 2026

# Open an output file 
#LINE 1:
set filename "rmsf.dat"
set outfile [open $filename "w"]

# Write the words "Residue" and "RMSF" as the first line of the file
#LINE 2:
puts $outfile "Residue\tRMSF"


# LINE 3: Set the selection to be only the alpha-carbons of each residue
set sel [atomselect top "alpha carbon"]

# LINE 4: Set $nframes to be the number of frames in the trajectory
set nframes [molinfo top get numframes]

set nframes2 [expr $nframes - 1]

# LINE 5: Set the variable $rmsfCA to be the RMSF for each C-alpha (CA) in your protein 
# In this command you need to specify the starting and final frame to be considered in 
# the calculations. HINT: This requires a measure command.  You have already defined all 
# the variables you need.

set rmsfCA [measure rmsf $sel first 1000 last $nframes2]

# Print out the RMSF for each C-alpha using a for loop
#Line 6: 
for {set i 0} {$i < [llength $rmsfCA]} {incr i} {
    set rmsf [lindex $rmsfCA $i]
    puts $outfile "[expr {$i + 1}]\t$rmsf"
}

close $outfile
