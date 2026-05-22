# Task: CSV processor — raport stanów magazynowych

## Typ tasku
work-ticket

## Poziom
junior+

## Temat
bash

## Etap projektu
ops-toolkit — CSV data processor

## Kontekst

Aplikacja Inventory API eksportuje codziennie stany magazynowe do pliku CSV. Potrzebny jest skrypt, który przetworzy ten plik i wygeneruje raport z podsumowaniem per kategoria. Raport jest używany przez dział logistyki.

Skrypt musi walidować dane (nieprawidłowe wiersze są zbierane i raportowane osobno) i zwracać exit code 1 jeśli są błędne dane.

## Cel

Napisz skrypt `process-inventory.sh` przetwarzający plik CSV z danymi inwentaryzacyjnymi i generujący raport per kategoria.

## Dane wejściowe

Plik `starter-files/data/inventory.csv` jest dostarczony. Format:
```
id,name,category,quantity,price
```

Przykładowe dane:
```csv
id,name,category,quantity,price
1,Laptop Pro,electronics,25,1299.99
2,Office Chair,furniture,50,399.50
3,USB Hub,electronics,0,29.99
4,Standing Desk,furniture,bad_number,599.00
5,Monitor 4K,electronics,10,799.00
```

## Pliki do użycia

- `task.md` — to zadanie
- `starter-files/process-inventory.sh` — szkielet do uzupełnienia
- `starter-files/data/inventory.csv` — plik testowy z danymi (w tym błędnymi wierszami)
- `../../validators/validate.sh` — uruchom po zakończeniu

## Co już istnieje

Pliki startowe z szkieletem i danymi testowymi.

## Co trzeba zrobić

1. Skrypt przyjmuje jako argumenty: `$1` — plik CSV, `$2` — katalog output (domyślnie `output`).
2. Waliduj argumenty i istnienie pliku.
3. Utwórz katalog output.
4. Pomiń wiersz nagłówka (pierwsza linia).
5. Dla każdego wiersza:
   - Sparsuj pola przez IFS lub `awk`/`cut`
   - Sprawdź czy `quantity` i `price` są liczbami (`>0`). Jeśli nie — zapisz do `errors.txt` z numerem wiersza
   - Jeśli ok — dodaj do tablic asocjacyjnych: `qty_by_cat["$category"]` i `val_by_cat["$category"]`
6. Wygeneruj `summary.txt` posortowany alfabetycznie po kategorii.
7. Jeśli są błędy — zapisz do `errors.txt` i wróć exit code 1.

Format `summary.txt`:
```
=== Inventory Summary ===
Generated: 2026-05-22

Category             | Total Qty | Total Value (USD)
---------------------+-----------+------------------
electronics          |        35 |       2128.98
furniture            |        50 |        399.50

Total items: 2 categories, 85 units, USD 2528.48
```

Format `errors.txt`:
```
=== Validation Errors ===
Line 4: id=4, name=Standing Desk — invalid quantity: 'bad_number'
```

## Ograniczenia

- `set -euo pipefail`
- Używaj tablic asocjacyjnych `declare -A` (bash 4+)
- Nie używaj `python` — tylko bash i awk
- Obliczenia float przez `awk` lub `bc` (bash nie obsługuje floatów)
- Walidacja: quantity i price muszą być liczbami > 0 (nie tylko != 0)

## Definition of done

- [ ] `shellcheck process-inventory.sh` przechodzi bez ERROR
- [ ] Skrypt z brakującym plikiem wychodzi z exit code 1
- [ ] Nagłówek CSV jest pomijany
- [ ] Błędne wiersze trafiają do `errors.txt`
- [ ] `summary.txt` posortowany alfabetycznie
- [ ] Wartości float obliczane poprawnie (co najmniej 2 miejsca po przecinku)
- [ ] Exit code 1 jeśli są błędne wiersze

## Najczęstsze błędy

- Brak `declare -A` dla tablic asocjacyjnych
- Nieobsługiwanie wierszy z przecinkami w nazwie (CSV quoting)
- Floaty przez `$(( ))` — bash obsługuje tylko integer
- Niepomijanie nagłówka (linia 1)
- Exit code 0 mimo błędnych wierszy

## Tip produkcyjny

Prawdziwe pliki CSV mogą mieć pola w cudzysłowach z przecinkami w środku (`"Laptop, Pro",electronics,...`). Bash `IFS=','` tego nie obsługuje. W produkcji używa się `csvkit`, `miller` lub Pythona. W tym zadaniu zakładamy uproszczony format (bez quoted fields) — ale warto o tym wspomnieć.

## Jak powiedzieć o tym na rozmowie

_"Napisałem skrypt Bash agregujący dane z CSV i generujący raporty. Używam tablic asocjacyjnych dla agregacji per kategoria, awk do obliczeń float. Skrypt waliduje każdy wiersz i zbiera błędy do osobnego pliku, zwracając exit code 1 jeśli są nieprawidłowe dane — dzięki temu pipeline CI może reagować na błędy danych."_
