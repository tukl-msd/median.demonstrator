set proj_dir [get_property DIRECTORY [current_project]]
puts $proj_dir
set top [get_property TOP [current_design]]
puts $top
set bitstream_in ${proj_dir}/${top}
puts $bitstream_in
set bitstream_in [file normalize $bitstream_in]
puts $bitstream_in
set bitstream_out [get_property directory [current_project]]/../../../Output
puts $bitstream_out
set bitstream_out [file normalize $bitstream_out]
puts $bitstream_out
file copy -force ${bitstream_in}.bit $bitstream_out

set filename $bitstream_out/output.bif
set fileId [open $filename "w"]
puts $fileId "the_ROM_image:"
puts $fileId "{"
puts $fileId \t$bitstream_out/$top.bit
puts $fileId "}"
close $fileId

exec bootgen -image $bitstream_out/output.bif -arch zynq -w -process_bitstream bin
