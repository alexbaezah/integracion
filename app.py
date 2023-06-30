from flask import Flask, render_template, request, redirect, url_for, flash, session, jsonify, Blueprint


from flask_mysqldb import MySQL, MySQLdb
import requests

import schedule
import time

import random



from transbank.webpay.webpay_plus.mall_transaction import MallTransaction
from transbank.webpay.webpay_plus.request import MallTransactionCreateDetails
from transbank.common.integration_commerce_codes import IntegrationCommerceCodes
from transbank.error.transbank_error import TransbankError
from datetime import datetime as dt
from datetime import timedelta





Result = []


app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'prodw3'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
mysql = MySQL(app)

app.secret_key = 'mysecretkey'





@app.route('/')
def home():
    return render_template("/home.html")




@app.route('/Login', methods=["GET", "POST"])
def Login():
    if request.method == "POST":
        email = request.form['email']
        password = request.form['password']

        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('select * from usuario where email=%s', (email,))
        usuario = cur.fetchone()
        cur.close()
        if len(usuario) > 0:
            if password == usuario['password']:
                session['nickname'] = usuario['nickname']
                session['email'] = usuario['email']
                session_active = True
                return redirect(url_for('master'))
            else:
                return redirect(url_for('Register'))


               

@app.route('/Logout')
def Logout():
    session.clear()
    return render_template('home.html')


@app.route('/Register')
def Register():
    return render_template("Register.html")



@app.route('/Agregar_usuario', methods=['POST'])
def Agregar_usuario():
    if request.method == 'POST':
        nombre = request.form['nombre']
        nickname = request.form['nickname']
        password = request.form['password']
        conf_password = request.form['conf-password']
        cellphone = request.form['cellphone']
        email = request.form['email']

        cur = mysql.connection.cursor()

        if password == conf_password:

            cur.execute("insert into usuario(nombre, nickname, password, cellphone, email) values(%s,%s,%s,%s,%s)",
                        (nombre, nickname, password, cellphone, email))
            mysql.connection.commit()
            flash('usuario agregado')
            session['nickname'] = nickname
            session['email'] = email
            return redirect(url_for('home'))




@app.route('/api_agregar_usuario', methods=['POST'])
def api_agregar_usuario():
    if request.method == 'POST':
        nombre = request.json.get('nombre')
        nickname = request.json.get('nickname')
        password = request.json.get('password')
        conf_password = request.json.get('conf-password')
        cellphone = request.json.get('cellphone')
        email = request.json.get('email')

        cur = mysql.connection.cursor()

        if password == conf_password:
            try:
                cur.execute("INSERT INTO usuario(nombre, nickname, password, cellphone, email) VALUES (%s,%s,%s,%s,%s)",
                            (nombre, nickname, password, cellphone, email))
                mysql.connection.commit()
                session['nickname'] = nickname
                session['email'] = email
                return jsonify({'status': 'success', 'message': 'User added'})
            except MySQLdb.IntegrityError as e:
                return jsonify({'status': 'error', 'message': 'Usuario repetido, intenta con otro'})
        else:
            return jsonify({'status': 'error', 'message': 'Passwords do not match'})
        


@app.route('/gestorProductos')
def gestorProductos():
    cur = mysql.connection.cursor()
    cur.execute('select * from producto')
    data = cur.fetchall()
    return render_template('gestorProductos.html', productos=data)


@app.route('/agregarProducto', methods=['POST'])
def agregar_producto():
    if request.method == 'POST':
        url_img = request.form['url_img']
        nombre = request.form['nombre']
        precio_unitario = request.form['precio_unitario']
        cantidad = request.form['cantidad']
        descripcion = request.form['descripcion']

        cur = mysql.connection.cursor()
        cur.execute('insert into producto(url_img, nombre, precio_unitario, cantidad, descripcion) values(%s ,%s ,%s ,%s ,%s)',
                    (url_img, nombre, precio_unitario, cantidad, descripcion))
        mysql.connection.commit()
        return redirect(url_for('gestorProductos'))


@app.route('/eliminar_producto/<string:id>')
def eliminar_producto(id):
    cur = mysql.connection.cursor()
    cur.execute('delete from producto where id = {0}'.format(id))
    mysql.connection.commit()
    flash('eliminado correctamente')
    return redirect(url_for('gestorProductos'))


@app.route('/actualizar_producto', methods=['POST'])
def actualizar_producto():
    if request.method == 'POST':

        id = request.form['id']
        url_img = request.form['url_img']
        nombre = request.form['nombre']
        precio_unitario = request.form['precio_unitario']
        cantidad = request.form['cantidad']
        descripcion = request.form['descripcion']

        cur = mysql.connection.cursor()

        cur.execute('update producto set url_img=%s ,nombre=%s ,precio_unitario=%s ,cantidad=%s ,descripcion=%s where id = %s',
                    (url_img, nombre, precio_unitario, cantidad, descripcion, id))

        print(descripcion)

        mysql.connection.commit()
        return redirect(url_for('gestorProductos'))
    else:
        return 'no entro ni mierda'



@app.route('/shoppingList')
def shoppingList():
    cur = mysql.connection.cursor()

    cur.execute('select id, nro_pedido, nombre, precio_unitario, cantidad_requerida, sub_total from shoppinglist')
    data = cur.fetchall()
    cur.execute('select sum(sub_total) "total" from shoppinglist')
    Total = cur.fetchall()
    nroPago = random.randint(99999, 999999)

    cur.execute('select CAST(precio_dolar as DECIMAL(10,2)) "precio_dolar" from precio_dollar order by id desc limit 1;')
    Dolar = cur.fetchall()

    # Almacena el buy_order y amount en las variables de sesión
    session['buy_order'] = str(nroPago)
    session['amount'] = Total[0]['total']

    print(Total, Dolar)

    return render_template('shoppingList.html', lista=data, lista2=Total, nroPago=nroPago, lista3=Dolar)




####################################################################################################################################################




@app.route('/shopListAct', methods=['POST'])
def shopListAct():
    if request.method == 'POST':
        id = request.form['id']
        nro_pedido = request.form['nro_pedido']
        nombre = request.form['nombre']
        precio_unitario = request.form['precio_unitario']
        cantidad_requerida = request.form['cantidad_requerida']

        cur = mysql.connection.cursor()
        cur.execute('update shoppinglist set nro_pedido=%s, nombre=%s, precio_unitario=%s, cantidad_requerida=%s, sub_total= precio_unitario*cantidad_requerida where id = %s',
                    (nro_pedido, nombre, precio_unitario, cantidad_requerida, id))
        mysql.connection.commit()
        return redirect(url_for('shoppingList'))


@app.route('/editar', methods = ['POST'])
def editar():
    if request.method == 'POST':
        id = request.form['id']
        cur = mysql.connection.cursor()
        cur.execute('select * from shoppinglist where id = %s', (id,))
        data = cur.fetchone()
        return render_template('cantidadProducto.html', lista=data)


@app.route('/eliminar/<string:id>')
def eliminar_pedido(id):
    cur = mysql.connection.cursor()
    cur.execute('delete from shoppinglist where id = {0}'.format(id))
    mysql.connection.commit()
    flash('eliminado correctamente')
    return redirect(url_for('shoppingList'))


@app.route('/master')
def master():
    cur = mysql.connection.cursor()
    cur.execute('select * from producto')
    data = cur.fetchall()

    cur = mysql.connection.cursor()
    cur.execute('select nombre from usuario')
    User = cur.fetchall()
    cur.close()

    return render_template('master.html', productos=data, lista=User)




@app.route('/pushProducto', methods=['POST'])
def pushProducto():
    if request.method == 'POST':
        id = request.form['id']

        miLista = list(range(999, 9999))

        random.shuffle(miLista)
       
        nro_pedido = miLista[:1]

        nombre = request.form['nombre']
        precio_unitario = request.form['precio_unitario']
        cantidad_requerida = request.form['cantidad_requerida']
        total = int(precio_unitario)*int(cantidad_requerida)

        print(id, nombre, nro_pedido)
        cur = mysql.connection.cursor()
        cur.execute('insert into shoppinglist( id, nro_pedido, nombre, precio_unitario, cantidad_requerida, sub_total) values(%s, %s, %s, %s, %s, %s)',
                    (id, nro_pedido, nombre, precio_unitario, cantidad_requerida, total))

        mysql.connection.commit()
        return redirect(url_for('master'))
    
@app.route('/apiProductos')
def get():   
        cur = mysql.connection.cursor()
        cur.execute('select * from producto')
        data = cur.fetchall()
        productos = []
        producto = {}
        for fila in data:
            producto = {'id' : fila['id'],
                        'nombre' : fila['nombre']
                        ,'precio_unitario' : fila['precio_unitario']
                        ,'cantidad' : fila['cantidad']
                        ,'descripcion' : fila['descripcion']
                        ,'url_img' : fila['url_img']
                        }
            
            productos.append(producto)
            producto = {}
        return jsonify('productos: ',productos)


@app.route('/apiProductos/<int:product_id>')
def get_product(product_id):
    # Tu código para obtener el producto por su ID
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM producto WHERE id = %s', (product_id,))
    product = cur.fetchone()
    if product:
        producto = {
            'id': product['id'],
            'nombre': product['nombre'],
            'precio_unitario': product['precio_unitario'],
            'cantidad': product['cantidad'],
            'descripcion': product['descripcion'],
            'url_img': product['url_img']
        }
        return jsonify(producto)
    else:
        return jsonify({'error': 'Producto no encontrado'})
    
@app.route('/webpay-plus-mall/create', methods=['GET'])
def show_create():
    return render_template('./webpay/plus_mall/create.html', dt=dt, timedelta=timedelta,
                           child_commerce_codes=IntegrationCommerceCodes.WEBPAY_PLUS_MALL_CHILD_COMMERCE_CODES)


@app.route('/webpay-plus-mall/create', methods=['POST'])
def webpay_plus_mall_create():
    buy_order = request.form.get('buy_order')
    session_id = request.form.get('session_id')
    return_url = request.url_root + 'webpay-plus-mall/commit'
    
    commerce_code_child_1 = request.form.get('details[0][commerce_code]')
    buy_order_child_1 = request.form.get('details[0][buy_order]')
    amount_child_1 = request.form.get('details[0][amount]')

    commerce_code_child_2 = request.form.get('details[1][commerce_code]')
    buy_order_child_2 = request.form.get('details[1][buy_order]')
    amount_child_2 = request.form.get('details[1][amount]')

    details = MallTransactionCreateDetails(amount_child_1, commerce_code_child_1, buy_order_child_1) \
            .add(amount_child_2, commerce_code_child_2, buy_order_child_2)

    response = (MallTransaction()).create(
        buy_order=buy_order,
        session_id=session_id,
        return_url=return_url,
        details=details,
    )
    
    print(response)
    return redirect(url_for('templates/webpay/plus_mall/created.html', details=details, response=response))





@app.route('/precioDollar')
def get_exchange_rate():
   
    response = requests.get('https://v6.exchangerate-api.com/v6/b3dba377ad0474313b7158c9/latest/USD')
    
    if response.status_code == 200:
        
        data = response.json()
        nombre = 'USD'
        date = data['time_last_update_utc']
        rate = data['conversion_rates']['CLP']
        result = {
            'date': date,
            'rate': rate
        }
       

        Result.append(result)

        cur = mysql.connection.cursor()
        cur.execute("insert into precio_dollar(nombre, precio_dolar, fecha_info) values(%s,%s,%s)",
                        (nombre, rate, date))
        mysql.connection.commit()

        return jsonify(result)
     
    else:
        return 'Error al obtener el tipo de cambio', 500
    


@app.route('/convertirDolaresAPesos', methods=['POST'])
def convertir_dolares_a_pesos():
    monto_dolares = request.json.get('monto_dolares')

    if monto_dolares <= 0:
        return jsonify({'error': 'El monto en dólares debe ser mayor que cero'})

    try:
        response = requests.get('https://v6.exchangerate-api.com/v6/b3dba377ad0474313b7158c9/latest/USD')

        if response.status_code == 200:
            data = response.json()
            tipo_cambio = data['conversion_rates']['CLP']
            monto_pesos = monto_dolares * tipo_cambio

            return jsonify({'monto_pesos': monto_pesos})
        else:
            return jsonify({'error': 'Error al obtener el tipo de cambio'})
    except Exception as e:
        return jsonify({'error': str(e)})





def programar_tarea():
    
    schedule.every(24).hours.do(get_exchange_rate)


programar_tarea()





if __name__ == '__main__':
    app.run(port=3000, debug=True)
    
   
    while True:
        # Comprobar si hay tareas programadas para ejecutar
        schedule.run_pending()
        time.sleep(1)

