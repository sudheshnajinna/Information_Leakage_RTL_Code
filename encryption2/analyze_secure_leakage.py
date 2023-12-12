# analyze_secure_leakage.py
def secure_encrypt(data_in, key):
    data_out = []
    for bit, key_bit in zip(data_in, key):
        if key_bit == 1:
            data_out.append((bit << 1) ^ key_bit)  # Double and XOR with key bit if key bit is 1
        else:
            data_out.append((bit * 3) ^ key_bit)  # Multiply by 3 and XOR with key bit if key bit is 0
    return data_out

def analyze_secure_leakage(N):
    for data in range(2**N):
        data_in = [int(x) for x in format(data, f'0{N}b')]
        key = [1 if x % 2 == 0 else 0 for x in range(N)]

        encrypted = secure_encrypt(data_in, key)
        print(f"Data: {data_in}, Key: {key}, Encrypted: {encrypted}")

# Example usage
N = 4  # Number of bits
analyze_secure_leakage(N)
