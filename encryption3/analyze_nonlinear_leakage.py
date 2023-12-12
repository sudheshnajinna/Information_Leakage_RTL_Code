def nonlinear_encrypt(data_in, key):
    N = len(data_in)
    data_out = [0] * N
    intermediate = [0] * N

    # First stage: XOR with key
    for i in range(N):
        intermediate[i] = data_in[i] ^ key[i]

    # Second stage: Nonlinear transformation
    for i in range(N):
        next_i = (i + 1) % N
        data_out[i] = (intermediate[i] + (intermediate[next_i] & key[i])) % 2

    return data_out

def analyze_nonlinear_leakage(N):
    for data in range(2**N):
        data_in = [(data >> i) & 1 for i in range(N-1, -1, -1)]
        key = [1 if i % 2 == 0 else 0 for i in range(N)]  # Example key pattern

        encrypted = nonlinear_encrypt(data_in, key)
        print(f"Data: {data_in}, Key: {key}, Encrypted: {encrypted}")

# Example usage
N = 4  # Number of bits
analyze_nonlinear_leakage(N)
