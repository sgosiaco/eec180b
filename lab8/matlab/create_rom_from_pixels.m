% module_name: string.
% pixels: 2-D array of pixel values to be written to this ROM instance.
% bits: selects which bits of each pixel value will be written to the ROM.
function create_rom_from_pixels(module_name, pixels, bits)
    global fobj
    
    [rows, cols] = size(pixels);
    mem_words = rows * cols;
    address_bits = ceil(log2(mem_words));
    [~, data_bits] = size(bits);

    %Write the module ports and declarations.
    fprintf(fobj, 'module %s (\n\tinput clock,\n\tinput [%d:0] address,\n\toutput reg [%d:0] data_out\n);\n\n', module_name, address_bits - 1, data_bits - 1);
    fprintf(fobj, 'reg [%d:0] mem [0:%d];\n\n', data_bits - 1, 2^address_bits - 1);
    fprintf(fobj, 'always @(posedge clock) begin\n\tdata_out <= mem[address];\nend\n\n');

    %Print ROM contents inside an "initial begin" block.
    fprintf(fobj, 'initial begin\n');

    %Memory layout is row major.
    mem_address = 0;
    for row = 1:rows
        for col = 1:cols
            %Pull the pixel value from the array.
            p = pixels(row, col);
            
            %Shift and bitmask this value to access only the desired bits.
            q = 0;
            bits2 = bits;
            for i = 0:data_bits-1
                [a, b] = min(bits2);
                q = q + bitshift(bitand(bitshift(p, -a), 1), i);
                bits2(b) = NaN;
            end
            
            %Write this value to the output file in Verilog syntax.
            fprintf(fobj, '\tmem[%d] = %d''b%s;\n', mem_address, data_bits, dec2bin(q, data_bits));
            mem_address = mem_address + 1;
        end
    end

    %Fill up any remaining ROM addresses with zeros.
    %Quartus throws a warning if these are not specified.
    for mem_address = mem_words:2^address_bits - 1
        fprintf(fobj, '\tmem[%d] = %d''b%s;\n', mem_address, data_bits, dec2bin(0, data_bits));
    end

    %Terminate the inital begin block and module.
    fprintf(fobj, 'end\nendmodule\n\n');
end