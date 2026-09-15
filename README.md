# 📡 Wi-Fi Attacks Lab

### Educational 802.11 Deauthentication & Beacon Flooding

Repositorio educativo dedicado al estudio práctico de determinados **Management Frames de IEEE 802.11**, concretamente:

- 🔌 **Deauthentication Attack**
- 📡 **Beacon Flood Attack**

El proyecto está orientado al aprendizaje de **redes inalámbricas, seguridad Wi-Fi y análisis de tráfico 802.11**, utilizando un entorno de laboratorio controlado.

> ⚠️ **Uso exclusivamente educativo.** Las pruebas deben realizarse únicamente sobre redes, dispositivos y laboratorios propios o cuando exista autorización explícita para realizar la auditoría.

---

# 🎯 Objetivo

El objetivo de este proyecto es comprender cómo funcionan algunos de los mecanismos utilizados por las redes Wi-Fi a nivel de **Management Frames**.

A través de los dos módulos del repositorio se estudian diferentes comportamientos:

```text
                    IEEE 802.11
                         │
              ┌──────────┴──────────┐
              │                     │
       Deauthentication        Beacon Flood
              │                     │
              ▼                     ▼
        Desconexión de        SSIDs ficticios
          clientes             anunciados
              │                     │
              └──────────┬──────────┘
                         │
                         ▼
                  Wi-Fi Security
```

El proyecto busca comprender tanto el **funcionamiento ofensivo** como las posibilidades de **detección y mitigación** de estas técnicas.

---

# 📂 Estructura del proyecto

```text
deauth-attack/
│
├── deauth-attack.sh
│
├── beacon-attack/
│
└── README.md
```

### 🔌 `deauth-attack.sh`

Script principal relacionado con el módulo de **Deauthentication Attack**.

Permite experimentar con el comportamiento de los **Deauthentication Frames** dentro de un laboratorio Wi-Fi.

### 📡 `beacon-attack/`

Módulo dedicado al **Beacon Flood Attack**.

Su objetivo es estudiar la generación de **Beacon Frames** que anuncian redes inalámbricas ficticias.

---

# 🔌 1. Deauthentication Attack

## 🧠 ¿Qué es?

Un **Deauthentication Frame** es un tipo de Management Frame definido dentro de IEEE 802.11 que permite terminar una relación de autenticación entre una estación y un punto de acceso.

El problema histórico es que determinados Management Frames 802.11 no incorporaban mecanismos suficientes para verificar criptográficamente su origen.

Esto puede permitir que un dispositivo envíe frames falsificados que aparenten proceder de otro dispositivo.

En un escenario de ataque, esto puede provocar que un cliente pierda temporalmente su conexión Wi-Fi y tenga que volver a realizar el proceso de conexión.

---

## 🔄 Funcionamiento conceptual

```text
┌──────────────┐
│    Cliente   │
└──────┬───────┘
       │
       │  Wi-Fi
       │
       ▼
┌──────────────┐
│ Access Point │
└──────────────┘
       ▲
       │
       │ Deauthentication
       │ Management Frame
       │
┌──────┴───────┐
│    Test      │
│   Station    │
└──────────────┘
```

De forma simplificada:

```text
Cliente
   │
   │ Asociación normal
   ▼
Access Point
   │
   │
   │  Deauthentication Frame
   │  ───────────────────────►
   │
   ▼
Cliente desconectado
   │
   │
   └──► Intento de reconexión
```

La finalidad educativa del módulo es observar este comportamiento y comprender qué ocurre durante el proceso.

---

# 📡 2. Beacon Flood Attack

## 🧠 ¿Qué es un Beacon Frame?

Un **Beacon Frame** es un Management Frame de IEEE 802.11 utilizado por los Access Points para anunciar la existencia de una red inalámbrica.

Estos frames contienen información que permite a los clientes conocer características de la red, como:

- SSID
- BSSID
- Canal
- Capacidades soportadas
- Parámetros de seguridad
- Información de sincronización

Los Beacon Frames se transmiten periódicamente por los Access Points. citeturn0search26turn0search2

---

## 💥 ¿Qué es un Beacon Flood?

Un **Beacon Flood Attack** consiste en transmitir una gran cantidad de Beacon Frames que anuncian redes inalámbricas ficticias.

A diferencia del ataque de deautenticación, cuyo objetivo principal es provocar la desconexión de clientes, el Beacon Flood busca principalmente **contaminar el entorno de descubrimiento Wi-Fi con redes inexistentes**.

Conceptualmente:

```text
                  Beacon Flood
                       │
          ┌────────────┼────────────┐
          │            │            │
          ▼            ▼            ▼
       SSID-01      SSID-02      SSID-03
          │            │            │
          ▼            ▼            ▼
       SSID-04      SSID-05      SSID-06
          │            │            │
          └────────────┼────────────┘
                       │
                       ▼
                Cliente Wi-Fi
                       │
                       ▼
             Muchas redes ficticias
```

El cliente recibe los Beacon Frames y puede interpretar que existen múltiples redes inalámbricas en su entorno aunque no exista físicamente ningún Access Point asociado a ellas.

Este comportamiento se ha documentado como una técnica de **Beacon Flooding / AP Spam**. citeturn0search1turn0search4

---

# 🔬 ¿Cómo funciona el Beacon Attack?

El proceso conceptual es:

```text
1. Crear Beacon Frame
          │
          ▼
2. Definir información del AP
          │
          ▼
3. Anunciar un SSID ficticio
          │
          ▼
4. Transmitir el Beacon
          │
          ▼
5. Cliente recibe el frame
          │
          ▼
6. Aparece una red ficticia
```

Cuando se generan múltiples Beacon Frames con diferentes identificadores de red, el dispositivo puede terminar mostrando una lista con una gran cantidad de SSIDs.

```text
Wi-Fi

Networks found:

📡 Network_01
📡 Network_02
📡 Network_03
📡 Network_04
📡 Network_05
📡 Network_06
📡 Network_07
📡 Network_08
📡 Network_09
📡 Network_10
...
```

El efecto principal es **confusión y contaminación de la lista de redes**, y en determinados dispositivos o implementaciones puede provocar consumo adicional de recursos o problemas de funcionamiento. citeturn0search0turn0search9

---

# 🔄 Deauthentication vs Beacon Flood

| Característica | Deauthentication | Beacon Flood |
|---|---|---|
| 📡 Frame utilizado | Deauthentication | Beacon |
| 🎯 Objetivo principal | Clientes conectados | Clientes / escáneres Wi-Fi |
| 💥 Efecto | Desconexiones | Redes ficticias |
| 🔐 Área | Autenticación | Descubrimiento de redes |
| 🧩 Tipo | Management Frame | Management Frame |
| 📊 Visibilidad | Desconexiones repetidas | Gran cantidad de SSIDs |
| 🛡️ Defensa | PMF / 802.11w | Detección y filtrado |
| 🧪 Uso educativo | Sí | Sí |

Los dos ataques pertenecen a la categoría de técnicas que explotan características de los **Management Frames 802.11**, pero tienen efectos diferentes. citeturn0search8

---

# 🧪 Entorno de laboratorio

Para experimentar con ambos módulos se recomienda utilizar una infraestructura completamente controlada:

```text
                ┌───────────────────┐
                │    Kali Linux     │
                │                   │
                │ Wi-Fi Adapter     │
                └─────────┬─────────┘
                          │
                          │ 802.11
                          │
                ┌─────────▼─────────┐
                │   Access Point    │
                │    LABORATORIO    │
                └─────────┬─────────┘
                          │
                          │
                ┌─────────▼─────────┐
                │  Cliente de       │
                │  laboratorio      │
                └───────────────────┘
```

### Recomendaciones

- Utilizar dispositivos propios.
- Utilizar una red creada específicamente para las pruebas.
- Evitar redes de terceros.
- Mantener las pruebas aisladas de infraestructuras productivas.
- Analizar el tráfico generado con herramientas como Wireshark.

---

# 🛠️ Tecnologías

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Kali Linux](https://img.shields.io/badge/Kali_Linux-557C94?style=for-the-badge&logo=kalilinux&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-121011?style=for-the-badge&logo=gnubash&logoColor=white)
![WiFi](https://img.shields.io/badge/Wi--Fi-802.11-0078D4?style=for-the-badge)
![Cybersecurity](https://img.shields.io/badge/Cybersecurity-8B0000?style=for-the-badge)

---

# 📦 Requisitos

Para utilizar el laboratorio se recomienda:

- 🐧 Linux / Kali Linux
- 📡 Adaptador Wi-Fi compatible con las capacidades necesarias
- 🔧 Bash
- 🛠️ Herramientas de auditoría inalámbrica
- 📶 Access Point propio
- 💻 Cliente Wi-Fi de pruebas

Un adaptador Wi-Fi externo puede ser necesario dependiendo del chipset y de las funciones inalámbricas requeridas por el entorno.

---

# 🚀 Instalación

Clonar el repositorio:

```bash
git clone https://github.com/borjacandeel/deauth-attack.git
```

Entrar en el directorio:

```bash
cd deauth-attack
```

Consultar los scripts incluidos y preparar previamente el entorno de laboratorio.

Para el script principal:

```bash
chmod +x deauth-attack.sh
```

> Los comandos específicos de ejecución deben utilizarse únicamente sobre equipos y redes autorizados.

---

# 🔎 Análisis del tráfico

Una parte importante del proyecto es no limitarse a generar los frames, sino **analizar qué está ocurriendo en la red**.

Con herramientas como Wireshark se pueden estudiar diferentes tipos de Management Frames:

```text
802.11 Management

├── Beacon
├── Probe Request
├── Probe Response
├── Authentication
├── Association
├── Reassociation
├── Disassociation
└── Deauthentication
```

Esto permite observar directamente cómo se comportan los paquetes durante los diferentes escenarios de laboratorio.

---

# 🛡️ Detección

## Deauthentication

Algunos indicadores que pueden revelar actividad anómala:

- Gran cantidad de Deauthentication Frames.
- Desconexiones repetidas.
- Frames procedentes de direcciones inesperadas.
- Incremento anormal de determinados códigos de razón.
- Clientes que pierden y recuperan la conexión repetidamente.

Los sistemas de detección inalámbrica pueden utilizar características de los frames 802.11 para identificar patrones de este tipo. citeturn0search3turn0search5

## Beacon Flood

Algunos indicadores:

- Aparición repentina de numerosos SSIDs.
- Muchos BSSIDs diferentes anunciando redes.
- Densidad anormal de Beacon Frames.
- Redes con características inconsistentes.
- SSIDs que aparecen y desaparecen rápidamente.

La detección puede apoyarse en características como la densidad de beacons, BSSID, timestamps y otros campos de los frames. citeturn0search3

---

# 🔐 Mitigación

## Protected Management Frames

Una de las principales medidas frente a determinados ataques basados en Management Frames es **Protected Management Frames (PMF)**, definido originalmente en IEEE 802.11w.

PMF proporciona protección criptográfica a determinados frames de gestión y dificulta la falsificación de mensajes utilizados en ataques de desautenticación.

Por este motivo, **PMF es especialmente relevante para la protección frente a Deauthentication y Disassociation spoofing**.

Sin embargo, PMF no elimina todos los posibles ataques de flooding basados en frames que no están protegidos de la misma manera, como los Beacon Frames. citeturn0search0

---

# 📚 Conceptos aprendidos

Este proyecto permite practicar conceptos relacionados con:

### 🌐 Redes

- IEEE 802.11
- WLAN
- Access Points
- BSSID / SSID
- Canales Wi-Fi
- Management Frames

### 🔐 Ciberseguridad

- Wireless Security
- Denial of Service
- Frame spoofing
- Attack detection
- Security monitoring
- Mitigation

### 🧪 Análisis

- Captura de tráfico
- Análisis de paquetes
- Identificación de anomalías
- Wireshark
- Monitorización inalámbrica

---

# ⚠️ Uso responsable

Este repositorio ha sido creado con **finalidad educativa y de investigación**.

No debe utilizarse contra:

- ❌ Redes públicas.
- ❌ Redes de empresas sin autorización.
- ❌ Redes de vecinos.
- ❌ Dispositivos de terceros.
- ❌ Infraestructuras productivas.
- ❌ Sistemas donde una interrupción pueda causar daños.

Las pruebas deben realizarse únicamente en:

- ✅ Redes propias.
- ✅ Laboratorios aislados.
- ✅ Dispositivos propios.
- ✅ Entornos educativos.
- ✅ Auditorías con autorización explícita.

El objetivo del proyecto es comprender cómo funcionan estas técnicas para poder **identificarlas, analizarlas y mitigarlas**.

---

# 📖 Referencias

- IEEE 802.11 — Wireless LAN standards.
- IEEE 802.11w — Protected Management Frames.
- Wireshark — análisis de tráfico 802.11.
- Investigación sobre detección de ataques de deautenticación y Beacon Flood. citeturn0search5
- Documentación técnica sobre Beacon Flooding y Management Frames. citeturn0search0turn0search4

---

# 👨‍💻 Autor

### Borja Candel

🎓 **Administración de Sistemas Informáticos en Red (ASIR)**

💻 Sistemas · Redes · Ciberseguridad · Automatización

🌐 [Portfolio](https://borjacandeel.github.io)

💻 [GitHub](https://github.com/borjacandeel)

---

<p align="center">
  <strong>📡 Wireless Security · 🔐 Cybersecurity · 🧪 Education</strong>
  <br><br>
  <sub>Educational project — use responsibly and only with authorization.</sub>
</p>
