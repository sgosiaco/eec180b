% jpeg_file: string specifying the file name/path.
function [r, g, b] = read_image(jpeg_file)
    global bit_depth

    rgb_array = imread(jpeg_file);
    %Get the JPEG properties, mainly to find out the native color depth.
    info = imfinfo(jpeg_file);
    native_bit_depth = info.BitDepth;

    %Scale RGB values from the native color depth to the desired color
    %depth to be stored in ROM.
    %Divide-by-3 factor comes from the three independent color channels.
    rgb_array = bitshift(rgb_array, (bit_depth - native_bit_depth)/3);
    
    r = rgb_array(:, :, 1);
    g = rgb_array(:, :, 2);
    b = rgb_array(:, :, 3);
end