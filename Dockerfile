FROM postgres:latest

# Actualiza la lista de paquetes disponibles
RUN apt-get update \
    # Instala el paquete "aptitude" de forma silenciosa
    && apt-get install -y aptitude \
    # Realiza una actualización segura de paquetes de forma silenciosa
    && aptitude safe-upgrade -y

# Instalar paquetes adicionales de forma silenciosa
RUN apt-get install -y \ 
    # Autocompletado de Bash 
    bash-completion \
    # Transferencia de datos
    curl \
    # Monitor de procesos
    htop \
    # Administrador de archivos
    mc \
    # Editor de texto simple
    nano \
    # Información del sistema
    neofetch \
    # Editor de texto avanzado
    neovim \
    # Servidor SSH
    openssh-server \
    # Ejecutar comandos con privilegios
    sudo \
    # Herramienta de descarga
    wget

    # Configurar zona horaria
ENV TZ=America/Mexico_City
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Establecer contraseña del usuario root
RUN echo "root:p0576r3SQL" | chpasswd

# Crear usuario eureka y establecer contraseña
RUN useradd -m -s /bin/bash dba && echo "dba:p0576r3SQL" | chpasswd

# Agregar usuario eureka al grupo sudo
RUN usermod -aG sudo dba

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh