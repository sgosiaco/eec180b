% Image to Verilog converter
% 
% A JPEG image opened and converted to an array of RGB values.  (The imread 
% function can open other image formats as well; type "help imread" for more 
% information)
% The 2-D image array is linearized and the RGB values are written to a file
% as ROM modules in Verilog syntax.
% 
% This script calls two functions defined within this file. This script
% works on the machines in Kemper 2110, which run matlab release 2017a.
% If your version of matlab gives the error "Function definitions are not
% permitted in this context," you can work around this by moving the function
% definitions for read_image() and create_rom_from_pixels() into separate
% files named read_image.m and create_rom_from_pixels.m, respectively.
% 
% 2018/05/29  Rewrote to manually write selected pixels using function calls
% 2018/05/29  Image automatically split across a specified number of ROM modules
% 2018/05/29  Automatic image resizing removed
% 2018/05/27  Written. (Timothy Andreas)

%==============================================================================
%===== User options (specify these)  vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

%Place the input image in the same directory with this MATLAB script, or
%specify the path to the image.
jpeg_file    = 'rin.jpg';        % input image file name
verilog_file = 'roms.v';                % output verilog file name

%===== User options (specify these)  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%==============================================================================

% Non-user options.
global bit_depth fobj   %These vars are shared with other functions.
bit_depth    = 12;      %Number of bits per pixel, to be evenly split among 
                        %R, G, B channels.
% Open the JPEG file, store contents in three 2-D arrays containing
%the R, G, B values for each pixel.
%R, G, B values are 4 bits each.
[r, g, b] = read_image(jpeg_file);
[jpeg_height, jpeg_width] = size(r);

%Open the Verilog output file.
fobj = fopen(verilog_file, 'w');

%==============================================================================
%==== DESIGN YOUR ROM MODULES BELOW THIS LINE  vvvvvvvvvvvvvvvvvvvvvvvvvvvvv

%This function call creates a new ROM called rom_0 containing the Red values
%  of the pixels from rows 1-90 and columns 1-60.
%  Pixels are written to the ROM in row major order.
%Argument 0:3 specifies that all bits [3:0] of the 4-bit Red value are written.
%  Bits are written with the MSB on the left, as is typical in Verilog.
%  Do NOT put 3:0, MATLAB doesn't know how to handle it.
%    If the 0:3 reversal really bugs you, either of the following will
%    produce identical results.
%    [3, 2, 1, 0]
%    3:-1:0
create_rom_from_pixels('rom_0r', r(1:32, 1:128), 0:3);
create_rom_from_pixels('rom_1r', r(33:64, 1:128), 0:3);
create_rom_from_pixels('rom_2r', r(65:96, 1:128), 0:3);
create_rom_from_pixels('rom_3r', r(97:128, 1:128), 0:3);

create_rom_from_pixels('rom_0g', g(1:32, 1:128), 0:3);
create_rom_from_pixels('rom_1g', g(33:64, 1:128), 0:3);
create_rom_from_pixels('rom_2g', g(65:96, 1:128), 0:3);
create_rom_from_pixels('rom_3g', g(97:128, 1:128), 0:3);

create_rom_from_pixels('rom_0b', b(1:32, 1:128), 0:3);
create_rom_from_pixels('rom_1b', b(33:64, 1:128), 0:3);
create_rom_from_pixels('rom_2b', b(65:96, 1:128), 0:3);
create_rom_from_pixels('rom_3b', b(97:128, 1:128), 0:3);
%==== DESIGN YOUR ROM MODULES ABOVE THIS LINE ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%==============================================================================

% Close the Verilog file.
fclose(fobj);




