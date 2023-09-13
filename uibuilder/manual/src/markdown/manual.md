# SCADA Aislapol - Preguntas Frecuentes <!-- omit in toc -->

![This is an image](./markdown/images/AiSCada.png)

<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->

- [Usuarios Simples](#usuarios-simples)
  * [¿Cómo me registro en la aplicación?](#cómo-me-registro-en-la-aplicación)
  * [¿Cómo inicio sesión en la aplicación?](#cómo-inicio-sesión-en-la-aplicación)
  * [¿Cómo puedo ver los datos de mi maquinaria?](#cómo-puedo-ver-los-datos-de-mi-maquinaria)
  * [¿Cómo puedo descargar los datos de mi maquinaria?](#cómo-puedo-descargar-los-datos-de-mi-maquinaria)
  * [¿Cómo puedo compartir los datos de mi maquinaria con otros usuarios?](#cómo-puedo-compartir-los-datos-de-mi-maquinaria-con-otros-usuarios)
  * [¿Cómo puedo cambiar mi contraseña?](#cómo-puedo-cambiar-mi-contraseña)
- [Usuarios Administradores](#usuarios-administradores)
  * [¿Cómo agrego nuevos usuarios a la aplicación?](#cómo-agrego-nuevos-usuarios-a-la-aplicación)
  * [¿Cómo elimino usuarios de la aplicación?](#cómo-elimino-usuarios-de-la-aplicación)
  * [¿Cómo cambio los permisos de usuario?](#cómo-cambio-los-permisos-de-usuario)
  * [¿Cómo configuro la aplicación para trabajar con diferentes tipos de maquinaria?](#cómo-configuro-la-aplicación-para-trabajar-con-diferentes-tipos-de-maquinaria)

<!-- TOC end -->

<!-- TOC --><a name="usuarios-simples"></a>
## Usuarios Simples
<!-- TOC --><a name="cómo-me-registro-en-la-aplicación"></a>
### ¿Cómo me registro en la aplicación?
> El formulario de registro para la aplicación puede encontrarse en la página de inicio, tras hacer clic en el botón “Registrarse”. En el formulario, debe ingresar su correo electrónico, tras solicitar el registro, si el correo utilizado fue permitido por el administrador, se enviará a esa dirección un correo con el token de registro, solicitado en el paso siguiente de registro junto a la contraseña para su cuenta. Si el registro se realiza exitosamente, se iniciará sesión automáticamente. En caso de que el registro no sea exitoso, contacte al administrador de la aplicación.
<!-- TOC --><a name="cómo-inicio-sesión-en-la-aplicación"></a>
### ¿Cómo inicio sesión en la aplicación?
> Una vez que se haya registrado exitosamente, deberá ingresar su nombre de usuario y contraseña en la página de inicio. Si las credenciales son correctas, podrá acceder y hacer uso de la aplicación.
<!-- TOC --><a name="cómo-puedo-ver-los-datos-de-mi-maquinaria"></a>
### ¿Cómo puedo ver los datos de mi maquinaria?
> Para ver los datos de su maquinaria, debe dirigirse a la pestaña “Estado de Maquinarias” en la página principal. Allí encontrará una serie de cartas que resumen el estado de cada máquina (pre expansor o moldeadora). Al hacer clic en cualquiera de las cartas, aparecerá un modal con información detallada sobre esa máquina en particular.
<!-- TOC --><a name="cómo-puedo-descargar-los-datos-de-mi-maquinaria"></a>
### ¿Cómo puedo descargar los datos de mi maquinaria?
> Para descargar los datos de su maquinaria, debe dirigirse a la segunda pestaña llamada “Base de Datos” en la página principal. En esta sección de la aplicación, puede hacer una consulta a la base de datos con el registro del funcionamiento de las máquinas. Tras realizar una consulta, se genera una tabla donde puede previsualizar el resultado de la consulta realizada. Una vez que haya encontrado los datos que desea descargar, haga clic en el botón “Descargar CSV” para descargar la tabla generada en forma de un archivo de valores separados por comas (CSV).
<!-- TOC --><a name="cómo-puedo-compartir-los-datos-de-mi-maquinaria-con-otros-usuarios"></a>
### ¿Cómo puedo compartir los datos de mi maquinaria con otros usuarios?
> En la versión actual de la aplicación, la única forma de compartir los datos obtenidos en la sección de bases de datos es a través del archivo CSV generado. Puede enviar el archivo CSV a otros usuarios por correo electrónico o cualquier otro medio que prefiera.
<!-- TOC --><a name="cómo-puedo-cambiar-mi-contraseña"></a>
### ¿Cómo puedo cambiar mi contraseña?
> Para cambiar su contraseña, debe dirigirse a la sección “Ajustes de Usuario” en la esquina superior derecha de la aplicación después de hacer clic en su nombre de usuario. En esta sección, seleccione la pestaña “Cambiar Contraseña”. Aquí, puede cambiar su contraseña si la nueva cumple con los requisitos y la actual es correcta. El cambio se hará efectivo inmediatamente.

<!-- TOC --><a name="usuarios-administradores"></a>
## Usuarios Administradores
<!-- TOC --><a name="cómo-agrego-nuevos-usuarios-a-la-aplicación"></a>
### ¿Cómo agrego nuevos usuarios a la aplicación?
> Si eres un administrador, puedes acceder a las herramientas de administrador en la sección “Admin” encontrada en la esquina superior izquierda de la aplicación. Esta sección premite acceder al formulario para permitir usuarios, donde se ingresa el nivel de acceso a la aplicación y su correo para registrarse en la aplicación, esta acción toma efecto inmediatamente. Los usuarios deben hacer el registro por su propia cuenta en esta versión de la aplicación.
<!-- TOC --><a name="cómo-elimino-usuarios-de-la-aplicación"></a>
### ¿Cómo elimino usuarios de la aplicación?
> En las herramientas de administrador puedes eliminar usuarios registrados, y revocar permisos de registro. Borrar usuarios registrados sólo elimina las credenciales del sistema, mientras que revocar los permisos de registro impide un nuevo registro, pero no impide que el usuario siga operando. Para remover permanentemente un usuario de la aplicación ambas acciones deben ejecutarse. Estas acciones son inmediatas y de carácter irreversible.
<!-- TOC --><a name="cómo-cambio-los-permisos-de-usuario"></a>
### ¿Cómo cambio los permisos de usuario?
> En esta versión de la aplicación, los permisos de usuario son fijos y no pueden ser cambiados. La única forma de cambiar los permisos de usuario es eliminando el usuario y creando uno nuevo con los permisos deseados.
<!-- TOC --><a name="cómo-configuro-la-aplicación-para-trabajar-con-diferentes-tipos-de-maquinaria"></a>
### ¿Cómo configuro la aplicación para trabajar con diferentes tipos de maquinaria?
> En esta versión de la aplicación, añadir máquinas a la aplicación es un proceso manual y requiere acceso al codigo fuente de la aplicación. En node-red debe añadir un nuevo nodo IIoT OPC UA con el nombre de la máquina y la dirección IP de la máquina. Luego, conectar la salida a un nodo reutilizable de formateo. En caso de que las máquinas sean de un proveedor distinto, puede que necesite actualizar el nodo de formateo para considerar las diferencias entre los servidores OPC UA.