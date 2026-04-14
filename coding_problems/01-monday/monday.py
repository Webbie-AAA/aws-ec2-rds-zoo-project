def wave(people: str) -> list[str]:
    mexican_wave_list = []
    for i in range(len(people)):
        if people[i] == " ":
            continue
        wave = people[:i] + people[i].upper() + people[i+1:]
        mexican_wave_list.append(wave)
    return mexican_wave_list


print(wave("hello"))
