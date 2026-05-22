# Task: Daily log report — parser logów nginx

## Typ tasku
work-ticket

## Poziom
junior

## Temat
bash

## Etap projektu
ops-toolkit — log parser i raport

## Kontekst

Zespół SRE dostał zgłoszenie: nie ma żadnego automatycznego raportu z logów nginx. Każdy rano ręcznie przegląda logi żeby sprawdzić anomalie. Twoje zadanie to napisać skrypt, który będzie generował dzienny raport z pliku `access.log` i zapisywał go do pliku.

Skrypt ma działać jako zadanie cron, więc musi obsługiwać brakujący plik (exit 1, komunikat do stderr) i nie może crashować.

## Cel

Napisz skrypt `parse-logs.sh` który parsuje plik access.log nginx (Combined Log Format) i generuje czytelny raport tekstowy.

## Dane wejściowe

Plik `starter-files/logs/access.log` jest dostarczony. Format: Combined Log Format nginx:
```
IP - - [timestamp] "METHOD /path HTTP/1.1" STATUS bytes "referer" "user-agent"
```

Przykładowe linie:
```
192.168.1.10 - - [22/May/2026:08:15:30 +0000] "GET /api/inventory HTTP/1.1" 200 1234 "-" "curl/7.88.1"
10.0.0.5 - - [22/May/2026:08:15:31 +0000] "POST /api/orders HTTP/1.1" 201 567 "-" "python-requests/2.31"
192.168.1.20 - - [22/May/2026:08:15:32 +0000] "GET /api/missing HTTP/1.1" 404 89 "-" "Mozilla/5.0"
10.0.0.5 - - [22/May/2026:08:15:33 +0000] "GET /api/inventory HTTP/1.1" 500 120 "-" "python-requests/2.31"
```

Kolumny (numeracja awk):
- $1 = IP
- $7 = ścieżka URL
- $9 = status HTTP

## Pliki do użycia

- `task.md` — to zadanie
- `starter-files/parse-logs.sh` — szkielet do uzupełnienia
- `starter-files/logs/access.log` — plik testowy z logami
- `../../validators/validate.sh` — uruchom po zakończeniu

## Co już istnieje

Nic poza plikami startowymi.

## Co trzeba zrobić

1. Skrypt przyjmuje ścieżkę do pliku logów jako `$1` (obowiązkowy argument).
2. Sprawdź czy argument podano, czy plik istnieje i nie jest pusty. Jeśli nie — wypisz komunikat błędu do `stderr` i wyjdź z exit code 1.
3. Utwórz katalog `reports/` jeśli nie istnieje (`mkdir -p`).
4. Oblicz i zapisz do raportu:
   - Łączna liczba requestów (liczba linii)
   - Liczba unikalnych adresów IP (kolumna 1)
   - Top 5 najczęściej odwiedzanych URL-i (kolumna 7) z liczbą requestów
   - Liczba błędów 4xx
   - Liczba błędów 5xx
5. Zapisz raport do `reports/report-YYYYMMDD.txt` (data z `date +%Y%m%d`).
6. Wypisz ścieżkę do raportu na stdout.
7. Exit code: 0 jeśli wszystko ok, 1 jeśli błąd.

Format raportu (przykład):
```
=== Nginx Access Log Report ===
Date: 2026-05-22
Log file: logs/access.log
Total requests: 1247
Unique IPs: 34
Error requests (4xx): 89
Error requests (5xx): 12

Top 5 URLs:
  1. /api/inventory       (423 requests)
  2. /api/orders          (312 requests)
  3. /api/products        (198 requests)
  4. /api/health          (145 requests)
  5. /api/missing         (89 requests)
```

## Ograniczenia

- `set -euo pipefail` na początku (obowiązkowe)
- Nie używaj `python`, `perl` ani innych zewnętrznych języków — tylko bash i standardowe narzędzia Unix
- Komunikaty błędu idą na stderr (`>&2`), dane na stdout
- Skrypt nie może crashować jeśli plik jest pusty lub nie istnieje

## Definition of done

- [ ] `shellcheck parse-logs.sh` przechodzi bez ERROR i WARNING
- [ ] `bash -n parse-logs.sh` przechodzi (syntax ok)
- [ ] Skrypt z brakującym plikiem wychodzi z exit code 1 i komunikatem na stderr
- [ ] Raport generuje się poprawnie na dostarczonym `access.log`
- [ ] Plik raportu ma datę w nazwie
- [ ] Top 5 URL-i jest posortowanych malejąco

## Najczęstsze błędy

- Brak `set -euo pipefail` — skrypt nie zatrzymuje się przy błędach
- `echo "błąd"` zamiast `echo "błąd" >&2` — błędy idą na stdout
- Brak cudzysłowów wokół zmiennych (`$LOG_FILE` zamiast `"$LOG_FILE"`)
- Brak sprawdzenia czy `$1` jest podane (powoduje `unbound variable` z `-u`)
- Złe parsowanie awk — kolumna statusu to `$9`, nie `$8`

## Tip produkcyjny

W skryptach cron stderr zazwyczaj idzie do maila lub jest ciche. Zawsze loguj błędy w sposób czytelny i dający się diagnozować. Dobry wzorzec: `echo "[ERROR] $(date): $message" >&2`. W produkcji raporty często idą do S3 lub są wysyłane przez SNS — ale lokalna wersja plikowa to dobry punkt startowy.

## Jak powiedzieć o tym na rozmowie

_"Napisałem skrypt Bash parsujący logi nginx, który działa jako zadanie cron i generuje dzienny raport. Skrypt waliduje wejście, obsługuje błędy (set -euo pipefail, exit codes), używa awk do parsowania logów i sortuje wyniki. Przeszedł shellcheck bez ostrzeżeń."_
