# !/bin/bash
# Este script agrega por default el enlace 'eclipse' a la variable $PATH.
# De esta manera podremos ejecutar el IDE mediante ALT+F2, como en la terminal.
# Tambien permite crear un enlace propio a modo de practica para BASH.
# Al final del documento, una breve explicacion del codigo.
# Federico Cipriani - sietedosfede@gmail.com

if [ ! -d "$HOME/.bin" ]; then
	mkdir $HOME/.bin
	$ADD
fi

read -p "Agregar al PATH > " -e -i eclipse VAR

if [ $VAR == 'eclipse' ]; then
	for files in *; do
		if [ $files == 'eclipse' ]; then $ADD
			ln -s /$files/eclipse $HOME/.bin
		fi
	done
fi	

if [ ! -z $VAR ]; then
	cat <<- EOF > $HOME/.bin/$VAR
		echo "Para modificar este script -> vim $HOME/.bin/$VAR"
	EOF
	chmod 755 $HOME/.bin/$VAR
	ln -s $HOME/.bin/$VAR $PWD/$VAR
	echo "Ahora podes ejecutar tu nuevo comando mediante '$VAR'."
	echo "Tambien fue creado un enlance en el directorio actual."
fi
	
ADD=$(
cat <<- 'EOF' > $HOME/.profile
	# Agregar directorio para enlaces propios al PATH:
	if [ -d "$HOME/.bin" ]; then
		PATH="$HOME/.bin:$PATH"
	fi
EOF
);

# Explicacion:
# El primer IF comprueba si existe la carpeta de enlaces propios .bin
# De no existir tal (-d) directorio, se crea. Es necesario decirle al sistema
# donde se encuentra .bin; esto es, agregar su ruta a la variable $PATH.
# En Linux, esto se especifica en el archivo de configuracion $HOME/.profile
# La variable ADD hace de funcion y la misma CONcatENA un script a .profile
# La razon por la cual el 'EOF' (End Of File) lleva comillas, indica a bash que
# no debe imprimir las variables respecto a su valor, sino su identificador.
# Esto no es mas que un script que genera otro script!
# Puede encontrarse mas informacion al respecto buscando 'Here Documents'
# El resto del codigo pertenece a la creacion de enlaces simbolicos a .bin
# El programa permite agregar la aplicación 'eclipse' por default asi tambien
# cualquier nuevo comando STRING distinto a CER0 ( ! -z ).
# Es necesario generar permisos de acceso (chmod) ante un nuevo archivo.
# Los mismos pueden ser expresados en dos modos: caracter / octal.
# Para este ejemplo, el parámetro 755 permite  todo usuario del sistema
# leer y ejecutar el archivo generado, mientras que unicamente nuestro
# usuario puede escribirlo.

# Notas:
# En BASH las variables se identifican con el signo '$'
# Para Linux todo archivo o directorio que empieze con . será oculto.
# Es posible listar todas las variables de entorno mediante el comando 'env'
