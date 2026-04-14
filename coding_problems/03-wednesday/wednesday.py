def meeting(s: str) -> str:

    names = s.upper().split(";")

    people = [tuple(name.split(";")) for name in names]

    people.sort(key=lambda x: (x[1], x[0]))

    return "".join(f"({last}, {first})" for first, last in people)


print(meeting("Fred:Corwill;Wilfred:Corwill;Barney:Tornbull;Betty:Tornbull;Bjon:Tornbull;Raphael:Corwill;Alfred:Corwill"))
