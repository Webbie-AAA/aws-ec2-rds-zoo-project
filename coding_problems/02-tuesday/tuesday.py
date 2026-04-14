def diamond(n: int) -> str:
    if n > 0 and n % 2 != 0:
        diamond = ""

        for i in range(n+1):
            diamond += f"{'*'*i}\n"

        for i in reversed(range(n-1)):
            diamond += f"{'*'*i}\n"

        print(diamond)

    return None


diamond(1)

# Unfinished
