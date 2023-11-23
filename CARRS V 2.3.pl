%declaracion de librerias

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).
:- dynamic color/2.

/*
INTERFAZ GRAFICA: Esta parte del sistema experto es la que se encarga de
interactuar con la persona comun, mostrar imagenes, botones, textos, etc.
*/
% metodo principal para iniciar la interfaz grafica, declaracion de
% botones, labels, y la pocicion en pantalla.


inicio:-

	new(Menu, dialog('Proyecto de diagnostico de fallos en vehiculos automotris', size(1000,800))),
	new(L,label(nombre,'BIENVENIDOS A SU SISTEMA EXPERTO DE ATENCION A SU VEHICULO')),
	new(A,label(nombre,'hecho por Cristian Camilo Sierra Nuñez, Daniel Camilo Alarcon Rodriguez, Juan Andres Rico Parra')),
	new(@texto,label(nombre,'Responde un breve cuestionario para resolver tu falla')),
	new(@respl,label(nombre,'')),
	new(Salir,button('SALIR',and(message(Menu, destroy),message(Menu,free)))),
	new(@boton,button('realizar test',message(@prolog,botones))),

	send(Menu,append(L)),new(@btncarrera,button('Diagnostico?')),
	send(Menu,display,L,point(125,20)),
	send(Menu,display,A,point(80,360)),
	send(Menu,display,@boton,point(100,150)),
	send(Menu,display,@texto,point(20,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).


/* BASE DE CONOCIMIENTOS: Sintomas y fallas del vehiculo, en caso de no reconocer el fallo se mostrar fallo desconocido
*/
%solucion a las fallas de acuerdo a las reglas de diagnostico

fallas('hacer un cambio de aceite:
	primero abra el cofre y ubique la figura del carter,
	el motor debe estar tibio antes de proceder, despues
	ubicar la valvula de purgacion debajo del motor y
	colocar una cubeta debajo, abrir la valvula y drenar
	el aceite antiguo, vea su manual de usuario para saber
	cuantos litros de aceite necesita su coche despues de
	drenar el aceite cierre la valvula y abra el carter
	para rellenar con el nuevo aceite y tapar el carter'):-aceite,!.

fallas('realizar una alineacion y balanceo:
        la solucion para esto es llavar el auto a un taller
        para que alinien y balancen las llantas del auto'):-suspension,!.

fallas('verificar el estado actual de la bateria:
	primero abra el capo y ubique la bateria del coche
        verifique si estan bien conectados los cables, arranque
	el coche, si no arranca entonces la bateria esta muerta
	para esto recarguela pase corriente con otro coche, pida ayuda al alguien que sepa,
	en caso de no tener exito debera reemplazar la bateria'):-electronico,!.

fallas('llego la hora de cambiar tus pastillas de freno:
	si se escucha un chillido agudo al frenar es tiempo
        de cambiar las pastillas de los frenos, para ello hay
	que levantar con un gato hidraulico el lado del freno
	donde se va a cambiar, con una llave inglesa y una
	matraca aflojar los cubre pastillas y sacar las patillas
	antiguas y reponerlas con las nuevas, colocar todo en su
	lugar y bla bla bla. '):-frenos,!.

fallas('se encendio el indicador check engine:
	esta luz puede indicar varias fallas en el sistema de la ECU,
	las pricipales son fallas de sensores, servicio de motor,
	catalizador, etc. si se cuenta con un escaner automotriz puede
	borrarse la falla pero esto no arregla el problema, para ello
	acuda con su mecanico certificado por los aliens.'):-computadora,!.

fallas('seguro subes demaciado el volumen:
	primero debes ubicar la bocina que no se escucha despues
        quitar o desatornillar el caparcete que protege la bocina
	y verificar que la bocina este bien conectado o tenga un cable
	quemado, dado uno de los casos deberas cambiar el cable
	o remplazar la bocina. Otro caso es verificar el estereo
	del auto si estan bien conectados los cables'):-sonido,!.

fallas('bomba de combustible defectuosa:
        El diagnóstico de un posible fallo en la bomba de combustible se fundamenta en una serie de indicadores clave.
        Cuando un vehículo experimenta fallos intermitentes del motor, detenciones inesperadas durante la conducción o
	pérdida de potencia al acelerar, estos síntomas pueden sugerir un problema con la bomba de combustible.
        La verificación de ruidos inusuales cercanos al tanque de combustible y una posible tendencia del vehículo a
	sobrecalentarse pueden ser señales adicionales de un mal funcionamiento de la bomba. Sin embargo, es crucial
	realizar un diagnóstico exhaustivo mediante herramientas especializadas, así como inspecciones visuales, para
	confirmar la condición de la bomba de combustible y determinar si requiere un reemplazo o mantenimiento adecuado
	para restaurar el funcionamiento óptimo del sistema de combustible del vehículo.'):-bomba,!.

fallas('problema en la transmisión:
        El diagnóstico de problemas en la transmisión de un automóvil implica una evaluación minuciosa de varios síntomas y
	componentes. Cuando se presentan dificultades al cambiar de marcha, ruidos inusuales durante esta acción,
	vibraciones o sacudidas durante la aceleración, fugas de líquido de transmisión visibles debajo del vehículo o
	un comportamiento irregular al retroceder, estos indicios sugieren posibles inconvenientes en la transmisión.
	Para abordar eficazmente estos problemas, se recomienda un enfoque paso a paso: verificar el nivel y la calidad
	del líquido de transmisión, inspeccionar visualmente en busca de fugas y desgastes, y realizar una evaluación
	profesional para diagnosticar y resolver la causa raíz del problema. Un mecánico especializado puede llevar a
	cabo pruebas adicionales, como escaneo computarizado o pruebas de conducción, para identificar con precisión la
	falla y realizar las reparaciones necesarias, que podrían incluir desde ajustes menores hasta reemplazos de
	componentes clave, asegurando así un rendimiento óptimo y seguro de la transmisión del automóvil.'):-marcha,!.


fallas('Falla desconocida').

% preguntas para resolver las fallas con su respectivo identificador de
% falla
aceite:- cambio_aceite,
	pregunta('¿Ha notado sonidos inusuales o vibraciones provenientes del motor últimamente?'),
	pregunta('¿Tiene problemas para arrancar el vehiculo en frio?'),
	pregunta('¿Su automovil gasta mas combustible de lo normal?'),
	pregunta('¿Su motor se escucha muy ruidoso?'),
	pregunta('¿Siente que su motor tiene menos fuerza?').

suspension:- alineacion_direccion,
	pregunta('¿Ha golpeado algún obstaculo (bache, anden) recientemente?'),
	pregunta('¿Ha notado alguna llanta desgastada?'),
	pregunta('¿Tiene su volante neutral y el auto gira?'),
	pregunta('¿Ha realizado un viaje largo que haya afectado a la alineacion de las ruedas?'),
	pregunta('¿Siente vibraciones o sacudidas inusuales al conducir a ciertas velocidades?').

electronico:- bateria_agotada,
	pregunta('¿Tiene problemas para arrancar el vehiculo en frio?'),
	pregunta('¿Los faros titilan o encienden con poca intencidad?'),
	pregunta('¿El radio no enciende?'),
	pregunta('¿El auto emite un crack cuando es encendido?');
	pregunta('¿El auto no enciende de ninguna forma?');
	pregunta('¿El auto cuenta con suficiente energia?').

frenos:- cambio_frenos,
	pregunta('¿Ha golpeado algún obstaculo (bache, anden) recientemente?'),
	pregunta('¿Ha notado alguna llanta desgastada?'),
	pregunta('¿Siente que el pedal del freno se hunde más de lo habitual al presionarlo?'),
        pregunta('¿Al frenar escucha chillidos agudos?');
        pregunta('¿Al frenar siente que se el vehiculo tarda mas en frenar?').

computadora:- check_engine,
	pregunta('¿Siente que su motor tiene menos fuerza?'),
	pregunta('¿Ha notado algún olor extraño o ruidos inusuales prevenientes del motor?'),
	pregunta('¿Ha revisado el estado del tapón del combustible (aflojado o apretado)?');
	pregunta('¿la luz se mantiene encendida todo el tiempo en el tablero del auto?').

sonido:- cambio_bocina,
	pregunta('¿Ha habido alguna situación de humedad o lluvia que podria haber afectado a las bocinas?'),
	pregunta('¿En la bocina no se escucha ningun sonido?'),
	pregunta('¿Ha revisado los fusibles y la conexión de las bocinas?'),
	pregunta('¿Antes de que dejan de funcionar las bocinas escucho algún sonido extraño?');
	pregunta('¿El auto cuenta con suficiente energia?').

bomba:- bombacombustible,
	pregunta('¿Siente que su motor tiene menos fuerza?'),
	pregunta('¿El carro se sobrecalienta con frecuencia?'),
	pregunta('Ha verificado si hay ruidos extraños cerca del tanque de combustible?');
	pregunta('¿El carro se detiene inesperadamente mientras conduce?').

marcha:- problema_marcha,
	pregunta('¿El indicador de check engine o de transmision se encendio en el tablero del vehiculo?'),
	pregunta('¿Se escuchan ruidos extraños al cambiar de marcha?'),
	pregunta('¿Ha notado fugas de líquido de transmisión debajo del automóvil?');
	pregunta('¿El vehículo retrocede de manera brusca o tarda en hacerlo al cambiar de dirección?').


%identificador de falla que dirige a las preguntas correspondientes

cambio_aceite:-pregunta('¿Ha encendido el indicador de advertencia de aceite en el tablero del vehículo?'),!.
alineacion_direccion:-pregunta('¿Ha notado que el carro tiende a desviarse hacia un lado mientras conduce en línea recta?'),!.
bateria_agotada:-pregunta('¿tiene problemas electricos?'),!.
cambio_frenos:-pregunta('¿tiene problema al frenar?'),!.
cambio_bocina:-pregunta('¿Presenta problemas con las bocinas?'),!.
check_engine:-pregunta('¿la luz check engine se encendio en el tablero del vehiculo?'),!.
bombacombustible:-pregunta('¿Ha experimentado fallos intermitentes del motor?'),!.
problema_marcha:-pregunta('¿La transmisión presenta dificultades al cambiar de marcha?'),!.

/* MOTOR DE INFERENCIA: Esta parte del sistema experto se encarga de
 inferir cual es el diagnostico a partir de las preguntas realizadas
 */
% proceso del diagnostico basado en preguntas de si y no, cuando el
% usuario dice si, se pasa a la siguiente pregunta del mismo ramo, si
% dice que no se pasa a la pregunta del siguiente ramo
% (motor,frenos,etc.)

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Diagnostico mecanico')),
     new(L2,label(texto,'Responde las siguientes preguntas')),
     new(La,label(prob,Problema)),
     new(B1,button(si,and(message(Di,return,si)))),
     new(B2,button(no,and(message(Di,return,no)))),

         send(Di,append(L2)),
	 send(Di,append(La)),
	 send(Di,append(B1)),
	 send(Di,append(B2)),

	 send(Di,default_button,si),
	 send(Di,open_centered),get(Di,confirm,Answer),
	 write(Answer),send(Di,destroy),
	 ((Answer==si)->assert(si(Problema));
	 assert(no(Problema)),fail).

% cada vez que se conteste una pregunta la pantalla se limpia para
% volver a preguntar

pregunta(S):-(si(S)->true; (no(S)->false; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

% proceso de eleccion de acuerdo al diagnostico basado en las preguntas
% anteriores

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	fallas(Falla),
	send(@texto,selection('la solucion es ')),
	send(@respl,selection(Falla)),
	new(@boton,button('inicia procedimiento mecanico',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).
