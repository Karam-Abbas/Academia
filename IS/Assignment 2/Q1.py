ciphers_in_hex = open("CipherText.txt","r")
arr_of_ciphers = ciphers_in_hex.readlines()
xored_plain_texts=['' for i in range(len(arr_of_ciphers)-1)]  # initializing list

def xor_hex(hex1, hex2):
    int_value1 = int(hex1, 16)   # hex->int
    int_value2 = int(hex2, 16) 
    
    result = int_value1 ^ int_value2   # xor
    
    result_hex = hex(result)[2:]  # to remove leading '0x'
    if len(result_hex) % 2 != 0:
        result_hex = result_hex  + '0' 
    return result_hex

for i in range(len(arr_of_ciphers)-1):         # results of c[i] xor c[j] 
    xor_result = xor_hex(arr_of_ciphers[i],arr_of_ciphers[i+1])
    xored_plain_texts[i]=xor_result
    
with open('output(hex).txt', 'w') as file:   # saving results in a file
    for line in xored_plain_texts:
        file.write(f"{line}\n") 
        

def hex_to_ascii(hex_string):
    # Split the hex string into two-character chunks (each representing a byte)
    ascii_string = ''
    
    # Iterate through the hex string in steps of two
    for i in range(0, len(hex_string), 2):
        hex_chunk = hex_string[i:i+2]
        
        try:
            # Convert the hex chunk to an integer
            char_code = int(hex_chunk, 16)
        except ValueError:
            ascii_string += "<INvalid>"
            continue
        
        # Check if the character code is within the range 0x20 to 0x7E
        if 0x00 <= char_code <= 0x7F:
            ascii_string += chr(char_code)
        else:
            # For out of range values, append a placeholder
            ascii_string += "_"
    
    return ascii_string

print(f"Number of lines in xored_plain_texts: {len(xored_plain_texts)}")

# Clear the file at the start by opening in write mode
with open('output(ascii).txt', 'w') as file:
    file.write('')  # This clears the file before writing to it

# Convert XOR hex results to ASCII and write to file
with open('output(ascii).txt', 'w') as file:  # Open in write mode
    for text in xored_plain_texts:
        result = hex_to_ascii(text)
        file.write(f"{result}\n\n")

print(hex_to_ascii(xored_plain_texts[0]))
