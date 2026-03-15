# Originally written by Kipp Johnson and Esmael Haddadian
# Modified by Bernard Xie for Lab 9
# February 25, 2016

set outfile [open "2HIUb_RMSF.dat" w]
set sel0 [atomselect top all]
set sel1 [$sel0 num]
set sel2 [atomselect top "resid 1 to $sel1 and name CA"]

set nframes [molinfo top get numframes]
set nframes2 [expr $nframes - 1]

puts $outfile "Residue\tRMSF"

# LINE 1
# Set $rmsf to be the result of measuring RMSF, using the optional
# first and last frame arguments to omit the first 10 ns
set rmsf [measure rmsf $sel2 first 500 last $nframes2]

puts [$sel2 num]

for {set i 0} {$i < 21} {incr i} {
        # LINE 2
        # Set sel3 to the atoms of residue $i+1, of the top molecule, and zeroeth frame
    set sel3 [atomselect top "resid [expr $i + 1] frame 0 and chain A"]

    # LINE 3
    # Set the beta of $sel3 to be the RMSF of the residue.
    # You may find the lindex command to be useful.
    $sel3 set beta [lindex $rmsf [expr $i]]
    puts $i
    puts [lindex $rmsf [expr $i]]

    # LINE 4
    # Write the residue number, followed by a tab, followed by its RMSF
    # to the output file
    puts $outfile "[expr {$i + 1}]\t$[lindex $rmsf $i]"
}

for {set i 0} {$i < 30} {incr i} {
    set sel3 [atomselect top "resid [expr $i + 1] frame 0 and chain B"]
    $sel3 set beta [lindex $rmsf [expr $i + 21]]
    puts $outfile "[expr {$i + 22}]\t$[lindex $rmsf [expr {i + 21}]]"
}

set sel4 [atomselect top "protein" frame 0]

# LINE 5
# Write $sel4 to a PDB file with a filename of your choosing
$sel4 writepdb "2HIU_colored2.pdb"

close $outfile