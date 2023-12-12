# analyze_leakage.py
def encrypt(data_in, key):
    data_out = []
    for bit, key_bit in zip(data_in, key):
        data_out.append(bit << 1 if key_bit == 1 else bit)  # Information leakage when key_bit is 0
    return data_out

def analyze_leakage(N):
    for data in range(2**N):
        data_in = [int(x) for x in format(data, f'0{N}b')]
        key = [1 if x % 2 == 0 else 0 for x in range(N)]  # Example key with a simple pattern

        encrypted = encrypt(data_in, key)
        print(f"Data: {data_in}, Key: {key}, Encrypted: {encrypted}")

# Example usage
N = 4  # Number of bits
analyze_leakage(N)
