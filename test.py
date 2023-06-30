import requests

# URL de prueba para verificar la conexión
test_url = 'https://webpay3gint.transbank.cl/webpayserver/status.txt'

try:
    response = requests.get(test_url, timeout=5)
    if response.status_code == 200 and response.text.strip() == 'OK':
        print('Conexión exitosa con Transbank')
    else:
        print('Error: No se pudo establecer la conexión con Transbank')
except requests.exceptions.RequestException as e:
    print('Error: No se pudo establecer la conexión con Transbank:', str(e))