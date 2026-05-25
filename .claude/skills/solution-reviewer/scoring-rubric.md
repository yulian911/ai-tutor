# Scoring Rubric — 6 osi oceny

Każda oś: 0–10 punktów.  
Wynik końcowy = średnia.  
Próg zaliczenia: **7.0 / 10**

---

## 1. Poprawność (0–10)

**Co oceniamy:** Czy rozwiązanie spełnia WSZYSTKIE wymagania z `task.md`?

### 10/10 — Doskonale
- ✅ Wszystkie wymagania spełnione
- ✅ Edge cases obsłużone
- ✅ Żadne błędy logiczne

### 8–9/10 — Dobrze
- ✅ Wszystkie wymagania spełnione
- ⚠️ Jeden drobny edge case pominięty

### 6–7/10 — Wystarczająco
- ✅ Większość wymagań spełniona
- ⚠️ Jeden wymóg częściowo lub błędnie

### 4–5/10 — Słabo
- ❌ Kilka wymagań nie spełnione
- ❌ Poważne błędy logiczne

### 0–3/10 — Bardzo źle
- ❌ Większość wymagań nie spełniona
- ❌ Rozwiązanie nie działa

---

## 2. Czytelność (0–10)

**Co oceniamy:** Czy kod jest jasny, dobrze sformatowany, z dobrymi nazwami?

### 10/10 — Doskonale
- ✅ Konsistentne formatowanie
- ✅ Zmienne i funkcje mają jasne nazwy
- ✅ Logika łatwa do śledzenia
- ✅ Komentarze gdzie są potrzebne

### 8–9/10 — Dobrze
- ✅ Formatowanie OK
- ✅ Nazwy sensowne
- ⚠️ Jeden brak komentarza lub zła nazwa

### 6–7/10 — Wystarczająco
- ⚠️ Niekonsistentne formatowanie
- ⚠️ Kilka niejasnych nazw
- ⚠️ Trudno śledź logikę

### 4–5/10 — Słabo
- ❌ Zły kod do czytania
- ❌ Wiele niejasnych nazw
- ❌ Brak formatowania

### 0–3/10 — Bardzo źle
- ❌ Nieczytelne
- ❌ Niemożliwe do zrozumienia

---

## 3. Best Practices (0–10)

**Co oceniamy:** Czy rozwiązanie stosuje standardy technologii?

### 10/10 — Doskonale
- ✅ Wszystkie best practices zastosowane
- ✅ Nowoczesne podejście
- ✅ Zoptymalizowane

### 8–9/10 — Dobrze
- ✅ Większość best practices
- ⚠️ Jedna mała suboptymalizacja

### 6–7/10 — Wystarczająco
- ✅ Podstawowe best practices
- ⚠️ Kilka suboptymalizacji

### 4–5/10 — Słabo
- ❌ Best practices nie stosowane
- ❌ Mało zdaje sobie sprawę

### 0–3/10 — Bardzo źle
- ❌ Anti-patterns zamiast best practices

---

## 4. Bezpieczeństwo (0–10)

**Co oceniamy:** Secrets, uprawnienia, attack surface, podatności?

### 10/10 — Doskonale
- ✅ Brak hardcoded secretów
- ✅ Uprawnienia minimalne (principle of least privilege)
- ✅ Input validation
- ✅ Brak podatności

### 8–9/10 — Dobrze
- ✅ Bez secretów
- ✅ Prawidłowe uprawnienia
- ⚠️ Jedna mała luka

### 6–7/10 — Wystarczająco
- ✅ Bez secretów
- ⚠️ Uprawnienia mogą być bardzie restrykcyjne

### 4–5/10 — Słabo
- ❌ Hardcoded sekrety LUB
- ❌ Zbyt szeroke uprawnienia

### 0–3/10 — Bardzo źle
- ❌ Poważne problemy bezpieczeństwa

---

## 5. Gotowość do pracy (0–10)

**Co oceniamy:** Czy to można wdrożyć w prawdziwej firmie?

### 10/10 — Doskonale
- ✅ Gotowe do produkcji
- ✅ Skalowalne
- ✅ Maintainowalne
- ✅ Dokumentacja

### 8–9/10 — Dobrze
- ✅ Prawie gotowe do produkcji
- ⚠️ Drobne braki

### 6–7/10 — Wystarczająco
- ✅ Działa
- ⚠️ Wymaga poprawek przed wdrożeniem

### 4–5/10 — Słabo
- ❌ Nie jest gotowe
- ❌ Wymaga znaczących zmian

### 0–3/10 — Bardzo źle
- ❌ Daleko od produkcji

---

## 6. Samodzielność (0–10)

**Co oceniamy:** Czy użytkownik myślał, czy ślepo kopał starter files?

### 10/10 — Doskonale
- ✅ Znaczące zmiany vs. starter files
- ✅ Własne rozumowanie widać
- ✅ Dodatkowe optimizacje

### 8–9/10 — Dobrze
- ✅ Naturalnie rozszerzył starter files
- ✅ Widać zrozumienie

### 6–7/10 — Wystarczająco
- ✅ Wypełnił starter files
- ⚠️ Mało oryginalności

### 4–5/10 — Słabo
- ⚠️ Prawie pełne copy starter files
- ⚠️ Brak własnego myślenia

### 0–3/10 — Bardzo źle
- ❌ Kompletne copy bez zmian

---

## Przykład scorecarda

| Oś | Punkty | Uwagi |
|----|--------|-------|
| Poprawność | 9/10 | Wszystkie wymagania, jeden edge case |
| Czytelność | 8/10 | Dobrze sformatowane, jedna zmienna mogła mieć lepszą nazwę |
| Best practices | 7/10 | Stosuje konwencje, jedna suboptymalizacja |
| Bezpieczeństwo | 10/10 | Brak secretów, minimalne uprawnienia |
| Gotowość do pracy | 8/10 | Prawie gotowe, wymaga logowania |
| Samodzielność | 8/10 | Naturalnie rozszerzył starter files |
| **Średnia** | **8.3/10** | ✅ **Zaliczone** |
