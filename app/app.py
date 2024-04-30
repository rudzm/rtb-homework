from flask import Flask, jsonify
import requests
from bs4 import BeautifulSoup

# Inicjalizacja aplikacji Flask
app = Flask(__name__)

# Funkcja do pobierania wpisów ze strony bash.pl
def fetch_bash_entries(pages_to_fetch=10):
    entries_list = []
    base_url = 'http://bash.org.pl/latest/'
    
    # Iteracja przez strony, aby uzyskać 100 wpisów
    for page_number in range(1, pages_to_fetch + 1):
        # Konstrukcja URL dla danej strony
        url = f'{base_url}?page={page_number}'
        
        # Pobranie strony
        response = requests.get(url)
        
        # Sprawdzenie, czy zapytanie zakończyło się sukcesem
        if response.status_code != 200:
            continue  # Pomijamy tę stronę, jeśli jest problem
        
        # Parsowanie strony za pomocą BeautifulSoup
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Znajdowanie wszystkich wpisów na stronie
        entries = soup.find_all('div', class_='q')
        
        # Dodawanie wpisów do listy
        for entry in entries:
                entry_text = entry.find('div', class_='quote').get_text()
                entries_list.append({"joke": entry_text})

                # Przerwanie, jeśli mamy już 100 historii
                if len(entries_list) >= 100:
                    return entries_list[:100]
        
        # Przerwanie, jeśli mamy już 100 wpisów
        if len(entries_list) >= 100:
            break

    return entries_list[:100]

# Endpoint do pobrania 100 wpisów ze strony bash.pl
@app.route('/api/bash_entries', methods=['GET'])
def get_bash_entries():
    # Pobranie 100 wpisów
    entries_list = fetch_bash_entries()
    
    # Zwracanie danych w formacie JSON
    return jsonify(entries_list)

# Uruchamianie serwera Flask
if __name__ == '__main__':
    app.run(debug=True)