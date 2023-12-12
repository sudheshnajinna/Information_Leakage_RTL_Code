# Define the S-box
s_box = [4, 10, 9, 2, 13, 8, 0, 14, 6, 11, 1, 12, 7, 15, 5, 3]

# Function to expand key
def expand_key(key, round):
    return [k ^ round for k in key]

# Enhanced encryption function
def enhanced_encrypt(data_in, key):
    N = len(data_in)
    state = data_in[:]
    for round in range(3):
        # Substitution using S-box
        for i in range(0, N, 2):
            # Convert two bits to an integer for S-box lookup
            two_bit_index = (state[i] << 1) + state[i+1]
            s_box_output = s_box[two_bit_index]
            # Convert S-box output back to two bits
            state[i], state[i+1] = s_box_output >> 1, s_box_output & 1

        # Permutation (bitwise rotation)
        state = state[-2:] + state[:-2]

        # Add round key
        round_key = expand_key(key, round)
        state = [s ^ rk for s, rk in zip(state, round_key)]
    
    return state

# Function to convert integer to binary list
def int_to_bin_list(value, N):
    return [(value >> i) & 1 for i in reversed(range(N))]

# Analyze leakage
def analyze_leakage(N):
    for data in range(2**N):
        for key in range(2**N):
            data_in = int_to_bin_list(data, N)
            key_in = int_to_bin_list(key, N)
            encrypted = enhanced_encrypt(data_in, key_in)
            print(f"Data: {data_in}, Key: {key_in}, Encrypted: {encrypted}")

# Example usage
N = 2  # Adjusted to 4 bits for consistency with Verilog
analyze_leakage(N)
